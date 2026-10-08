---
name: harness-improver
description: The nightly and weekly self review that makes this harness better over time. Reads the day's runs, finds failures, rate limits, slow steps and corrections from Sreekar, proposes concrete edits, applies the safe ones on a git branch, and re-verifies models and skills weekly. Attached to the nightly and weekly cron jobs. Use for "review yourself", "why did that fail", "tune the setup".
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [harness, self-improvement, cron, maintenance]
    related_skills: [daily-marketing-loop]
    requires_toolsets: [terminal]
---

# Harness improver

The harness gets better the way a good employee does: by noticing what went wrong today and fixing it before tomorrow, and by asking before changing anything that matters. Free tier models run this job, so it stays small and mechanical.

## Inputs

- `~/.hermes/cron/output/*/` for today: every run's output, including `[SILENT]` runs and errors.
- `hermes sessions list` and the day's session transcripts (search for "no", "wrong", "not that", "stop", "again" from Sreekar: these are corrections).
- `~/.hermes/ratelimits.log`, `~/.hermes/sent.log`, `~/.hermes/deploys.log`, `~/.hermes/images.log`.
- `git log --since=yesterday` in the repo.
- Agent created skills in `~/.hermes/skills/` that are not symlinks from the repo (the ones Hermes wrote on its own).

## Nightly procedure (23:00 IST)

1. **Collect.** One table: job or session, outcome (ok, silent, failed, rate limited, corrected), time taken, model used.
2. **Diagnose each failure or correction** in one line: wrong prompt, missing fact, wrong tool, rate limit, Sreekar's preference not recorded, skill gap.
3. **Propose.** Write `proposals/harness-<date>.md` with sections: what broke, root cause, the exact edit (file, old line, new line), risk (wording only, behaviour, config, spend), and whether it needs a yes.
4. **Apply the safe class only.** Safe means: wording changes inside a skill in `skills/`, a new fact in `MEMORY.md` within the size limit, a new standing default recorded from an explicit Sreekar instruction, a cron prompt clarification that does not change its schedule or delivery. Do it on a branch `harness/<date>`, commit, and leave the branch for Sreekar to merge (or merge it yourself the next morning if he has not objected and the change is wording only; say so in the brief).
5. **Never apply on your own:** model or provider changes, schedule changes, approval or deny list changes, anything in `SOUL.md`, anything in `context/02` fixed rules, spending, new channels, new tools.
6. **Adopt agent created skills.** For each skill Hermes wrote today on its own: read it, if it is useful and specific, move it into `skills/` in the repo with a proper frontmatter and a one line description, symlink it back, commit. If it duplicates an existing skill, merge the useful lines and delete it.
7. **Report in three lines:** what broke, what you changed, what needs a yes. `[SILENT]` if the day was clean and nothing was proposed.

## Weekly procedure (Sunday 10:00 IST)

1. `hermes skills check` and `hermes skills update` for hub skills. `hermes update --check` if available; propose the update, do not run it unattended.
2. `hermes approvals suggest` and propose allowlist entries that are safe (never deletes, never sudo).
3. Re-verify every model id in `hermes/config.yaml`: still exists, still 64K plus context, still free where marked. Re-read the free tier limits for OpenRouter, Google AI Studio, Cerebras and Groq from their pricing pages and the free LLM API resources list. Note changes.
4. Count rate limit hits per job this week from `ratelimits.log`. Any job with three or more hits gets a proposed fix: a different hour, a different model in the chain, or the paid model with the cost estimated.
5. Review `MEMORY.md` for size and staleness; propose condensing.
6. Append the five line weekly review from `daily-marketing-loop` to `proposals/weekly-log.md`.
7. Write `proposals/weekly-<date>.md`. Report in five lines.

## Rules

- Small edits, every day, beat one big rewrite. If a proposal is over 40 lines, split it.
- Every edit cites the run or correction that caused it. No edits from taste alone.
- Run `scripts/check-dashes.sh` before every commit.
- Keep the repo as the single copy. Anything useful in `~/.hermes/skills/` ends up in `skills/`.
- Do not touch `~/.hermes/.env`, `~/.hermes/platforms/`, or any credential file.

## Verification

Proposal file written (or a clean day declared), safe edits on a branch with a commit, nothing from the never apply list touched, report under the line budget.
