---
name: daily-marketing-loop
description: The always on marketing rhythm for Deep Flow: morning brief, the content calendar, the next session countdown, and the weekly review. Attached to the morning brief cron job. Use for "what is on today", "plan this week", "what should we post", "where are we on the next event".
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [marketing, cadence, cron, deepflow]
    related_skills: [deepflow-brand, no-ai-slop, research-brief, outreach-email, image-gen-brief]
---

# Daily marketing loop

A small brand grows on rhythm, not campaigns. One session a week, one post rhythm, one brief a day. This skill keeps the rhythm and reports in two lines.

## Files it owns

- `proposals/calendar.md`: the content and event calendar, next six weeks, one line per item: date, channel, what, status (idea, drafted, approved, posted).
- `proposals/content-<date>.md`: the three concepts from the content ideas job.
- `~/.hermes/parked/`: tasks waiting on Sreekar, one file each, with the question and the default.

## The weekly rhythm (defaults, adjust to what Sreekar chose in discovery)

| Day | What | Owner |
|---|---|---|
| Mon | Week plan in the brief: the session this week, the posts, anything due | Flow |
| Wed | One post goes out (a session photo or a short clip from last week), caption drafted and approved earlier | Sreekar posts, Flow drafts |
| Fri | Reminder post or story for Sunday's session; reply to enquiries | Flow drafts, Sreekar posts |
| Sun | Session. Sreekar shoots five photos and one clip | Sreekar |
| Mon | Recap post from Sunday's material, next date announced | Flow drafts |

Instagram posting stays manual until Sreekar grants a standing approval and a posting tool is set up; Flow prepares everything so posting takes one minute.

## The morning brief (08:30 IST, cron)

Two lines first: the one thing to do today, and anything parked on him. Then, under ten short lines:

1. Days to the next session and places left (from the booking form or the sheet).
2. What went out overnight (replies under standing approvals, from `sent.log`).
3. Inbox: waiting for him, count.
4. Today's content item and its status; if it is drafted, the caption is in the message, ready to paste.
5. Paid model use since yesterday, if any.
6. One idea, one line, for later.

If nothing changed and nothing is due, `[SILENT]`.

## The event countdown (per event, from the moment a date is set)

| When | What Flow does |
|---|---|
| Date set | Add to calendar; draft the listing text; propose two listing sites; create the event page with `consumer-landing-page` (event mode), preview |
| T minus 14 | Announcement post drafted; event page live after the yes |
| T minus 7 | Reminder story; enquiry replies; places left check |
| T minus 3 | Final push post; confirmations to everyone booked (standing approval class, once granted) |
| T minus 1 | What to bring reminder to everyone booked; weather check; Sreekar's day of checklist |
| T plus 1 | Thank you note to attendees; ask for one photo each; recap post drafted; next date announced |

## Weekly review (Sunday night, part of the nightly harness review)

Five lines: sessions held and attendance; posts out and the best one; enquiries in and replies out; what slipped and why; one thing to change next week. Append to `proposals/weekly-log.md`.

## Pitfalls

- A brief that is a wall. Two lines then ten short ones, or silence.
- Inventing attendance or booking numbers. If there is no source, say "no data yet".
- Scheduling posts for days Sreekar did not agree to.
- Treating the loop as content for its own sake. Every item points at the next session.

## Verification

Calendar file current, parked folder reviewed, brief under the length budget, numbers sourced or marked.
