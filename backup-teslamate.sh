#!/usr/bin/env bash
#
# Backs up the TeslaMate Postgres database (via pg_dump) and the Grafana
# config volume, and writes both to an NFS-mounted destination.
# Intended to be run from the host crontab. See CLAUDE.md for the design.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${1:-$SCRIPT_DIR/config.env}"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Config file not found: $CONFIG_FILE (copy config.env.example to config.env and fill it in)" >&2
  exit 1
fi
# shellcheck source=/dev/null
source "$CONFIG_FILE"

for var in DATABASE_USER DATABASE_PASS DATABASE_NAME GRAFANA_VOLUME NFS_MOUNT BACKUP_ROOT STAGING_DIR RETENTION_DAYS; do
  if [[ -z "${!var:-}" ]]; then
    echo "Missing required config value: $var" >&2
    exit 1
  fi
done

LOCK_FILE="${STAGING_DIR}.lock"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

exec 9>"$LOCK_FILE"
if ! flock -n 9; then
  log "Another backup run is already in progress, exiting."
  exit 1
fi

cleanup() {
  rm -rf "$STAGING_DIR"
}
trap cleanup EXIT

if ! mountpoint -q "$NFS_MOUNT"; then
  echo "$NFS_MOUNT is not mounted, refusing to back up (would fill local disk instead)." >&2
  exit 1
fi

mkdir -p "$STAGING_DIR" "$BACKUP_ROOT/db" "$BACKUP_ROOT/grafana"

# Resolve the actual database container name: prefer looking it up by the
# compose project label so this keeps working if the project is recreated,
# falling back to the configured name.
DB_CONTAINER_RESOLVED="$(docker ps --filter "label=com.docker.compose.project=${COMPOSE_PROJECT:-}" \
  --filter "label=com.docker.compose.service=database" --format '{{.Names}}' | head -n1 || true)"
DB_CONTAINER="${DB_CONTAINER_RESOLVED:-${DB_CONTAINER:-}}"

if [[ -z "$DB_CONTAINER" ]]; then
  echo "Could not resolve the database container (checked compose project '${COMPOSE_PROJECT:-}' and DB_CONTAINER fallback)." >&2
  exit 1
fi

timestamp="$(date '+%Y%m%d-%H%M%S')"
db_file="teslamate-db-${timestamp}.sql.gz"
grafana_file="teslamate-grafana-${timestamp}.tar.gz"

log "Dumping database from container '$DB_CONTAINER'..."
docker exec -e PGPASSWORD="$DATABASE_PASS" "$DB_CONTAINER" \
  pg_dump -U "$DATABASE_USER" "$DATABASE_NAME" | gzip > "$STAGING_DIR/$db_file"

log "Archiving Grafana volume '$GRAFANA_VOLUME'..."
docker run --rm \
  -v "${GRAFANA_VOLUME}:/data:ro" \
  -v "${STAGING_DIR}:/backup" \
  alpine tar czf "/backup/$grafana_file" -C /data .

log "Moving backups to $BACKUP_ROOT..."
# Copy to a .tmp name on the destination filesystem, then rename into place.
# The rename is atomic (same filesystem), so a failed/interrupted copy across
# the NFS mount can never leave a partial file under its final name.
cp "$STAGING_DIR/$db_file" "$BACKUP_ROOT/db/$db_file.tmp"
mv "$BACKUP_ROOT/db/$db_file.tmp" "$BACKUP_ROOT/db/$db_file"
cp "$STAGING_DIR/$grafana_file" "$BACKUP_ROOT/grafana/$grafana_file.tmp"
mv "$BACKUP_ROOT/grafana/$grafana_file.tmp" "$BACKUP_ROOT/grafana/$grafana_file"

log "Pruning backups older than $RETENTION_DAYS days..."
find "$BACKUP_ROOT/db" -name '*.sql.gz' -mtime "+$RETENTION_DAYS" -delete
find "$BACKUP_ROOT/grafana" -name '*.tar.gz' -mtime "+$RETENTION_DAYS" -delete

log "Backup complete: $db_file, $grafana_file"
