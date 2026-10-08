# Deep Flow Hermes: project instructions

This repo is the home of Flow, Sreekar's assistant. Hermes loads this file whenever it works from this folder.

## On a fresh session

1. If `~/.hermes/SOUL.md` does not contain "Deep Flow", setup has not run. Follow `SETUP.md` from step 2.
2. Otherwise read `context/00-READ-ORDER.md` and the files it lists, once.
3. Check `~/.hermes/parked/` for tasks waiting on Sreekar and mention them in your next reply if any exist.

## Layout

```
SETUP.md            the walkthrough: install, keys, channel, gateway, site, email, cron
install.sh          applies hermes/ to ~/.hermes and installs skills/ (idempotent, safe to rerun)
hermes/             SOUL.md, memories/, config.yaml (reference), env.example
context/            everything Flow needs to know, read in the 00 order
skills/             Hermes skills, one folder each, SKILL.md inside
cron/jobs.sh        the scheduled jobs, created with hermes cron create
scripts/            verify.sh, check-dashes.sh, llmfit-check.sh, slop_lint.py
site/               the deepf1ow.com pages (created by the first landing page build)
proposals/          harness-improver output, one file per night
CHANGELOG.md        what changed in the harness and when
```

## Rules in this folder

- Commit after every change to skills, context or site, with a one line message. Never commit `.env`, `~/.hermes`, session files or anything with a token in it.
- Run `scripts/check-dashes.sh` before any commit. It fails on an em dash or en dash anywhere in the repo.
- When Sreekar decides something that is marked as his to decide in `context/02-brand-foundation.md`, update that table, add a line to `context/05-decisions.md`, and update `skills/deepflow-brand/SKILL.md` in the same commit.
- Site deploys follow `context/07-domain-site-and-stack.md`: preview first, production on a yes.
- Skills you create on your own go in `skills/` too, not only in `~/.hermes/skills/`, so the repo stays the single copy. `install.sh` symlinks them.
