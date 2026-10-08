---
name: outreach-email
description: Read, triage, draft and send email for Sreekar through the himalaya CLI. Draft, show, send on yes. Standing approvals per class let routine replies go out without asking. Use for inbox triage, replies, partner outreach, follow ups, event confirmations, any email.
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [email, outreach, inbox, deepflow]
    related_skills: [no-ai-slop, deepflow-brand, research-brief]
    requires_toolsets: [terminal]
required_credential_files:
  - path: ../.config/himalaya/config.toml
    description: himalaya account config (IMAP and SMTP), set up in SETUP.md step 9
---

# Outreach email

Email is the channel that embarrasses fastest and is hardest to take back. So: draft, show, send on yes. Autonomy grows through standing approvals, one class at a time, granted by Sreekar in his own words and recorded in `MEMORY.md`.

## When to use

Inbox triage (cron, three times a day), replies, first contact with a partner or venue, follow ups, confirmations to people who booked, anything that leaves the mailbox.

## Quick reference

**Read.** `himalaya envelope list --folder INBOX` and `himalaya message read <id>`. Unread since last run: keep the last seen id in `~/.hermes/email-cursor`.

**Send.** `himalaya template send` or `himalaya message send` with a plain text body. Plain text by default; HTML only for a newsletter, and only with a yes.

**Classes with standing approval (none until Sreekar grants them).** Written in `MEMORY.md` as "Standing approvals: replies to session enquiries with the standard answer; confirmations to bookings". Anything not listed needs a yes.

**Always ask.** First contact with anyone. Any message with a price, a date commitment, a partnership, a sponsor, a press contact, or a Champions Group entity. Any reply to a complaint.

## Writing rules

- Short and plain. One idea, one ask, under 120 words unless the task says otherwise.
- Subject line says the thing: "Sunday session, directions" not "Quick question".
- First two lines carry the message. No "hope this finds you well", no "just circling back", no apology for a delay (say what happens next instead).
- Sign as Sreekar unless he said to sign as Flow for Deep Flow. Never deny being an assistant if asked directly.
- Deep Flow voice from `deepflow-brand`. Group entities use their own voice; ask Champ for the brand skill before writing for them.
- Zero em dashes and en dashes. Gate every draft through `no-ai-slop`.

## Procedure

**Triage (cron or on request).**
1. List unread since the cursor. Group: needs Sreekar, routine (standing approval), noise.
2. Noise (newsletters, notifications, receipts): archive, count them, one line in the report.
3. Routine: reply using the standard answer for that class, log it, report it.
4. Needs Sreekar: draft the reply, send him the draft with a one line summary of the thread and buttons: send, edit, skip. If he picks edit, take his notes and resend the draft.
5. Update the cursor. Report: "3 archived, 1 replied (session enquiry), 2 waiting for you".

**Outreach (on request).**
1. Research the person or org for two minutes (`research-brief`): what they do, one recent thing, the right name.
2. Draft: why them, what Deep Flow is in one line, the specific ask, a date option. Under 120 words.
3. Show the draft with the research under it. Send on yes. Log sender, recipient, subject and date in `~/.hermes/sent.log`.
4. Follow up once after five working days if no reply, with a two line nudge, only if Sreekar said to follow up.

**Standing approval requests.** When the same class of email has gone out three times with no edits from Sreekar, ask: "Want me to send replies to [class] without checking from now on? I will list them in the morning brief." Record his answer in `MEMORY.md`.

## Pitfalls

- Sending from the wrong account. Check `himalaya account list` once per session.
- Attaching files you have not opened. Read every attachment before forwarding.
- Replying to a thread that mentions money or a partnership as if it were routine.
- Long emails. Depth goes in a page or a document, linked.
- Cold outreach to a list. One person at a time, each researched. Never bulk.

## Verification

Draft passed the no-ai-slop gate, under the word budget, correct account, logged in `sent.log`, and either a yes exists or the class is on the standing list.
