# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project status

This repository is a fresh scaffold — it contains `README.md`, `LICENSE`, and `.gitignore`, but no backup code has been written yet. The sections below describe the intended design, agreed with the user, that new code in this repo should follow.

## Purpose

A backup tool for a [TeslaMate](https://github.com/adminy/teslamate) stack running via Docker Compose on a host referenced as `rpimonitor` to `nas1`. 

## Environment

### Host: rpimonitor

- internal `rpimonitor.thefunkhouse.net` (`10.1.1.3`) 
- external `rpimonitor.taile146ca.ts.net` (`100.125.93.20`) (Tailscale address). 

### Host: nas1 backup target

- internal `NAS1.thefunkhouse.net` (`10.1.1.4`)
- external `nas1.taile146ca.ts.net` (`100.110.135.20`) (Tailscale address). 
- Mount path `/volume1/backup`

The Compose stack has four services (Compose project name is `mfunk`, so actual running container names are prefixed, e.g. `mfunk-database-1` — confirmed via `docker ps` in `host-rpimonitor-info.md`):

- `teslamate` (container `mfunk-teslamate-1`) — the app itself (no persistent data of its own beyond the `./import` bind mount)
- `database` (container `mfunk-database-1`) — Postgres 17, volume `mfunk_teslamate-db` — **this is the primary backup target** (all trip/vehicle history)
- `grafana` (container `mfunk-grafana-1`) — volume `mfunk_teslamate-grafana-data` (dashboards/config). Note: a stray, unrelated, empty volume named bare `teslamate-grafana-data` (no project prefix) also exists on the host — don't confuse the two.
- `mosquitto` (container `mfunk-mosquitto-1`) — volumes `mfunk_mosquitto-conf`, `mfunk_mosquitto-data`

## Intended architecture

- **Language**: shell script(s) (bash), not Python or a container — this is meant to be a simple host-level ops tool.
- **Backup method**: `docker exec` into the `mfunk-database-1` container (or resolve it dynamically via `docker compose ps -q database`, in case the project name changes) and run `pg_dump` (not a raw volume copy) to get a consistent, restorable Postgres dump.
  - Also archiving the `teslamate-grafana-data` volume to support rebuilding the dashboards/config.
- **Destination**: copy/rsync the resulting dump(s) to an NFS-mounted path on the network (no cloud/S3 target).
  - /mnt/backup (see: host-rpimonitor-info.md)
- **Scheduling**: triggered by a **host crontab** entry — not a systemd timer, not a container with an internal scheduler.

## Live deployment (rpimonitor)

Deployed and running as of 2026-07-11:

- Script + config live at `/home/mfunk/teslamate-auto-backup/` (`backup-teslamate.sh`, `config.env` — the latter is `600` perms, not in git).
- Crontab (user `mfunk`): `0 3 * * * /home/mfunk/teslamate-auto-backup/backup-teslamate.sh /home/mfunk/teslamate-auto-backup/config.env >> /home/mfunk/teslamate-auto-backup/backup.log 2>&1` — daily at 3 AM, logging to `backup.log` in the same directory.
- `/mnt/backup/teslamate/{db,grafana}` is owned by `mfunk:mfunk` (had to `sudo chown` it once — it was root-owned under the root-owned `/mnt/backup` NFS mount root).
- **Secrets**: DB credentials (`DATABASE_USER`/`DATABASE_PASS`/`DATABASE_NAME`) must be read from a local config/env file that is gitignored, never hardcoded into the script or committed.

## Working conventions for this repo

- Since this is a small standalone ops script (not a library or service), avoid over-engineering: no unnecessary abstraction layers, no config framework beyond a simple env/config file.
- Never commit real database passwords, encryption keys, or NFS credentials — use placeholder values in any example/config files checked into the repo.
- Local git commits fall back to an auto-generated identity (`mfunk@MacBookPro.lan`) since `user.name`/`user.email` aren't configured globally; existing commits use this until it's set.
