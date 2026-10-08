# Deep Flow Hermes

This repo turns a Hermes Agent install into Flow: your assistant and chief marketer for Deep Flow, running on your Mac, reachable on Telegram, working while you sleep.
Forty minutes to set up. Start with `SETUP.md`.

## What you get

- **An assistant that acts.** Research, drafts, pages, images, inbox triage, forms, scheduling, all done and reported in two lines. It asks you, with buttons, only before the things that are public, permanent, expensive or brand changing.
- **The whole Deep Flow story.** Both earlier versions of the brand, the decisions and the reasons, the voice rules, the stable, the flow arts scene in Bangalore, and the light version of Champions Club and 100X so it never sounds lost. All in `context/`.
- **Twelve skills.** Brand rules, a brand discovery session, consumer landing pages (with a tested page shell), image briefs, email, calls (phase 2), browser and forms, research, the daily marketing loop, an initiative skill that works through the backlog when there is spare bandwidth, the nightly self review, and the no slop writing gate.
- **Seven scheduled jobs.** Morning brief, inbox triage three times a day, content ideas three times a week, a daily scene check, a 2 pm initiative slot for discretionary work from `BACKLOG.md`, a nightly review of its own work, a weekly model and skill check. Each one stays silent when there is nothing to say.
- **Free tiers for the daily work, a paid model only when you ask.** OpenRouter, Google AI Studio, Cerebras and Groq free tiers carry the loops. `/model` switches to a Sonnet class model for a hard task and switches back.

## Setup in one line

Do steps 1 and 2 of `SETUP.md` by hand (install Hermes, clone, run `./install.sh`). Then open Hermes and paste:

> Set yourself up from ~/deepflow-hermes/SETUP.md, starting at step 3. Ask me with options when a step needs something from me. Do not wait for permission on anything reversible.

## The three things it will always ask about

1. Putting anything live on deepf1ow.com, or touching DNS.
2. Changing a brand element: name, promise, palette, type, marks, bio, voice rules.
3. Money, first contact with a person, prices, commitments, public posts.

Everything else it does and tells you.

## Layout

```
SETUP.md         the walkthrough
install.sh       applies hermes/ to ~/.hermes, links skills, checks for dashes (rerun any time)
hermes/          identity (SOUL.md), memory seeds, reference config, env template
context/         read in the 00 order; the brand, the stable, the decisions, the policy, the stack, the models
skills/          one folder per skill, SKILL.md inside, Hermes format
cron/jobs.sh     creates the seven scheduled jobs
BACKLOG.md       discretionary work, prioritised; Flow picks from it, you add to it by chat
scripts/         verify.sh, check-dashes.sh, llmfit-check.sh, slop_lint.py
site/            deepf1ow.com pages, created by the first landing page build
proposals/       what Flow proposes each night and week; calendars and research briefs
```

## Hermes, not Paperclip

Champ designed the first Deep Flow as an eight agent Paperclip org. For one person and one assistant on free tiers, Hermes does the job with less to run: scheduled jobs, skills that improve, memory, approval gates, Telegram and WhatsApp, a browser, and subagents for bigger work. If Deep Flow ever needs three or more agent roles with separate budgets and a ticket queue, Hermes becomes one Paperclip worker and nothing here is wasted. The reasoning is in `context/05-decisions.md`.

## House rules

- No em dashes or en dashes anywhere. `scripts/check-dashes.sh` fails the build on one.
- Secrets live in `~/.hermes/.env`, never in this repo.
- Every change Flow makes to itself is a commit with a one line message, so you can read `git log` and see what it learned.

Built by Champ, October 2026, from the Celsus vault. Questions go to him.
