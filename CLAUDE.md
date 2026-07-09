# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project status

This repository is a fresh scaffold — it contains `README.md`, `LICENSE`, and `.gitignore`, but no backup code has been written yet. The sections below describe the intended design, agreed with the user, that new code in this repo should follow.

## Purpose

A backup tool for a [TeslaMate](https://github.com/adminy/teslamate) stack running via Docker Compose on a host (referenced as `rpimonitor`, reachable at `100.125.93.20` — appears to be a Tailscale address). The Compose stack has four services:

- `teslamate` — the app itself (no persistent data of its own beyond the `./import` bind mount)
- `database` — Postgres 17, volume `teslamate-db` — **this is the primary backup target** (all trip/vehicle history)
- `grafana` — volume `teslamate-grafana-data` (dashboards/config)
- `mosquitto` — volumes `mosquitto-conf`, `mosquitto-data`

## Intended architecture

- **Language**: shell script(s) (bash), not Python or a container — this is meant to be a simple host-level ops tool.
- **Backup method**: `docker exec` into the `database` container and run `pg_dump` (not a raw volume copy) to get a consistent, restorable Postgres dump. Consider also optionally archiving the `teslamate-grafana-data` volume if dashboards/config need to survive a rebuild.
- **Destination**: copy/rsync the resulting dump(s) to an NFS-mounted path on the network (no cloud/S3 target).
- **Scheduling**: triggered by a **host crontab** entry — not a systemd timer, not a container with an internal scheduler.
- **Secrets**: DB credentials (`DATABASE_USER`/`DATABASE_PASS`/`DATABASE_NAME`) must be read from a local config/env file that is gitignored, never hardcoded into the script or committed.

## Working conventions for this repo

- Since this is a small standalone ops script (not a library or service), avoid over-engineering: no unnecessary abstraction layers, no config framework beyond a simple env/config file.
- Never commit real database passwords, encryption keys, or NFS credentials — use placeholder values in any example/config files checked into the repo.
- Local git commits fall back to an auto-generated identity (`mfunk@MacBookPro.lan`) since `user.name`/`user.email` aren't configured globally; existing commits use this until it's set.
