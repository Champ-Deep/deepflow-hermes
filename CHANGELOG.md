# Changelog

One line per change, newest first. Flow appends here when it changes its own skills, prompts or config.

## 2026-10-09

- Tested end to end against a fresh Hermes v0.21.6 install: installer, all twelve skills loading, cron create and remove, provider resolution with `key_env`, fallback chain, auxiliary routing, verifier. Fixes from the test: `personalities.flow` is a top level key (was under `agent.`); providers now use `key_env` so the whole model routing is applied by `install.sh` with no secrets in the repo; `cron.provider` and `cron.model` route every scheduled job to the free Gemini pool; `timezone: Asia/Kolkata` set (without it schedules ran on UTC, so the morning brief would have fired at 2 pm IST); cron jobs get `--workdir` so `HERMES.md` loads; job removal reads `jobs.json` by name; verifier fixed for macOS `stat`, pipefail and real gateway and scheduler status.

## 2026-10-08

- Added discretionary work: `BACKLOG.md`, the `initiative` skill, a 14:00 initiative cron slot, and `context/10-connectors-and-tools.md` (what is wired, what to add later and how). Verified Hermes toolset names and `hermes cron remove` against the docs.

- First version. Context pack (9 files), identity and memory seeds, reference config, setup walkthrough, installer, verifier, 6 cron jobs, 11 skills, page shell. Model ids and free tier limits checked on this date; the weekly job re-verifies them.
