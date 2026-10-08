#!/usr/bin/env bash
# Creates the six scheduled jobs. Safe to rerun: it removes jobs with the same names first.
# All times IST. The gateway must be running (hermes gateway install) for any of these to fire.
# Every prompt ends with the [SILENT] rule so Sreekar is not pinged for nothing.
set -euo pipefail
DELIVER="${DELIVER:-telegram}"   # or whatsapp, or origin

names=("Morning brief" "Inbox triage" "Content ideas" "Community check" "Nightly harness review" "Weekly model and skill check")
for n in "${names[@]}"; do
  id=$(hermes cron list 2>/dev/null | grep -F "$n" | grep -oE '^[a-zA-Z0-9_-]+' | head -1 || true)
  [ -n "$id" ] && hermes cron remove "$id" >/dev/null 2>&1 || true
done

SILENT="If there is nothing worth his attention, reply exactly [SILENT]."

hermes cron create "30 8 * * *" \
  "Morning brief for Sreekar. Two lines first: the one thing to do today, and anything waiting on him in ~/.hermes/parked/. Then under ten short lines: what you did overnight (from ~/.hermes/cron/output/ since yesterday), replies sent under standing approvals, paid model usage if any, the next session or event date and days remaining, and one content idea ready to post. No preamble, no recap. $SILENT" \
  --name "Morning brief" --skill daily-marketing-loop --deliver "$DELIVER"

hermes cron create "0 9,15,21 * * *" \
  "Inbox triage. Use himalaya to list unread mail since the last run. For each: reply if it is on a standing approval class in MEMORY.md and report it; draft a reply and ask with options if it needs Sreekar; archive newsletters and notifications. Flag anything that mentions money, a date commitment, a partnership or the press. One line per item. $SILENT" \
  --name "Inbox triage" --skill outreach-email --deliver "$DELIVER"

hermes cron create "0 11 * * 1,3,5" \
  "Content ideas. Produce three post concepts for Deep Flow's Instagram grounded in the brand foundation and the next session date: a hook line, the shot or visual to make, the caption under 60 words, no hashtags beyond three. Run no-ai-slop on each. Save them to proposals/content-YYYY-MM-DD.md (today's date) and send the three hook lines with a 1, 2, 3 so Sreekar can pick. $SILENT" \
  --name "Content ideas" --skill deepflow-brand --skill no-ai-slop --deliver "$DELIVER"

hermes cron create "0 18 * * *" \
  "Community check. With the browser, look at Deep Flow's Instagram profile (if set) and IndieFlow's public page for new events, mentions or comments that need a reply. Check the Bangalore flow arts and horse scene for events in the next 14 days worth attending or partnering on. Report only new items, one line each, with a suggested action. Do not post or comment. $SILENT" \
  --name "Community check" --skill research-brief --deliver "$DELIVER"

hermes cron create "0 23 * * *" \
  "Nightly harness review. Run the harness-improver skill: read today's cron outputs and session logs, list failures, rate limits (~/.hermes/ratelimits.log), slow runs and places where Sreekar had to correct you. Write proposals/harness-YYYY-MM-DD.md (today's date) with concrete edits to skills, prompts or schedules. Apply edits that only change wording in a skill you own, on a git branch named harness/YYYY-MM-DD (today's date), and commit. Anything else stays a proposal. Report in three lines: what broke, what you changed, what needs a yes. $SILENT" \
  --name "Nightly harness review" --skill harness-improver --deliver "$DELIVER"

hermes cron create "0 10 * * 0" \
  "Weekly model and skill check. Run hermes skills check, hermes update --check if available, and hermes approvals suggest. Re-verify every model id in hermes/config.yaml still exists on its provider with 64K or more context, and re-read the free tier limits for OpenRouter, Google AI Studio, Cerebras and Groq. Summarize changes and propose config edits in proposals/weekly-YYYY-MM-DD.md (today's date). Do not change the main model without a yes. $SILENT" \
  --name "Weekly model and skill check" --skill harness-improver --deliver "$DELIVER"

echo
hermes cron list
