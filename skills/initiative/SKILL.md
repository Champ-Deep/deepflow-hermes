---
name: initiative
description: Discretionary work when there is bandwidth. Checks quota, time and what is parked, picks the top unblocked item from BACKLOG.md, does it inside a fixed budget, reports in two lines, and adds what it discovered to the backlog. Attached to the daily initiative slot. Use for "do something useful", "what is next on the backlog", "add to the backlog", "you have an hour".
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [backlog, discretionary, initiative, cron]
    related_skills: [daily-marketing-loop, research-brief, consumer-landing-page, outreach-email, harness-improver]
    requires_toolsets: [terminal, file]
---

# Initiative

A diligent assistant does not wait to be told what to do between tasks. It keeps a list, knows its own limits for the day, picks the most useful thing it can finish, finishes it, and says so in two lines. This skill is that habit.

## When to use

- The daily initiative slot (cron, 14:00 IST).
- Any session where Sreekar's request is done early and he said "carry on" or "you have time".
- When Sreekar says "add to the backlog: ..." (write the line, say "added", nothing else).

## Bandwidth check (do this first, every time)

1. **Quota.** Read `~/.hermes/ratelimits.log` for today. Two or more hits on the current provider today means pick an S item or stop with `[SILENT]`. Never switch to the paid model for discretionary work.
2. **Parked work.** `~/.hermes/parked/` with a file older than a day means Sreekar has an open question; remind him in the report before starting anything new.
3. **Time.** The budget is 45 minutes of agent time or one item, whichever comes first. If an item is clearly bigger, do the first clean slice, mark it `doing`, and leave a one line note of where to resume.
4. **Quiet hours.** No discretionary runs between 22:00 and 08:00 IST unless Sreekar asked.

## Picking

1. Read `BACKLOG.md`. Skip items whose "needs" is not met, items marked `doing` by a newer run that has not finished, and anything that would need a yes to be useful (publishing, sending, spending).
2. Prefer: P1 before P2, S before M when quota is tight, items that unblock other items, items tied to the next session date.
3. Pick one. Change its status to `doing` with today's date, commit the backlog, then start.

## Doing

- Use the matching skill (`research-brief`, `consumer-landing-page`, `outreach-email` templates, `image-gen-brief`). The backlog item names the output; produce exactly that.
- Outputs go to `proposals/` (briefs, drafts, templates) or `site/` (pages, preview only). Never to production, never to a recipient, never to a public post.
- Every draft passes `no-ai-slop`. Every page passes the landing page gate.
- If you hit a real blocker (a missing fact, a login), write the question to `~/.hermes/parked/<item>.md` with the default you would take, mark the item `parked` with the reason, and move to the next item if budget remains.

## Reporting

Two lines: what got done and where it is; what, if anything, needs a yes. Then mark the item `done` with the date (move it to the Done section), commit, and append one line to `CHANGELOG.md` only if a skill or template changed. If nothing could be picked, `[SILENT]`.

## Growing the backlog

While working, note what you found that is missing or would help (a template that does not exist, a fact nobody recorded, a page the site needs). Add each as a P3 line with "needs". Do not add vanity work: no "write a blog post" without a reader, no dashboards nobody asked for, no rewriting things that work.

## Pitfalls

- Doing three half items instead of one whole one.
- Spending the day's free quota on discretionary work so the evening cron jobs fail. The quota check exists for this.
- Treating a backlog item as permission to publish or send. It never is.
- Leaving an item `doing` with no resume note.

## Verification

Bandwidth check done, one item moved through `doing` to `done` or `parked` with a reason, output in `proposals/` or `site/`, backlog committed, report under two lines plus the ask.
