---
name: browse-and-fill-forms
description: Use the browser to read sites, fill forms, book slots, submit listings and run errands online for Sreekar. Fills everything up to the final submit, then asks when the submit commits money, identity, a legal agreement or a public post. Use for "fill this form", "register us for", "list the event on", "book", "apply", "check the site".
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [browser, forms, errands, deepflow]
    related_skills: [research-brief, outreach-email]
    requires_toolsets: [browser]
---

# Browse and fill forms

The browser is Flow's hands on the web. Reading and filling are free to do. Submitting is where the ask list applies.

## When to use

Event listings (BookMyShow, Insider, AllEvents, Meetup, local community calendars), venue enquiry forms, supplier orders, Instagram or Google Business profile edits, government or permit forms, competitor and scene research, checking the live site.

## Quick reference

**Setup.** `hermes pm install agent-browser` once. Browser toolset enabled in `hermes tools`. Local headless by default; `browser.headed: true` when Sreekar wants to watch or take over a login.

**Logins.** Three ways, in order of preference: Sreekar logs in once in headed mode and the session persists; real profile mode (`browser.use_real_profile: true`) copies his own browser logins for a one off task; the credential vault for unattended runs. Never ask for a password in chat. Never type a password that was pasted in chat into a site; ask him to log in instead.

**Submit gate.** Fill every field, take a screenshot of the completed form, send it with a one line summary, and ask with buttons: submit, change, cancel. Skip the gate only for forms that commit nothing (search boxes, filters, newsletter signups Sreekar asked for, contact forms that only send a message, and that message passed the no-ai-slop gate).

## Procedure

1. Say the goal in one line and the site. Open it. Read the page as a snapshot; find the form.
2. Collect the facts the form needs from the repo (`context/`, `MEMORY.md`, `~/.hermes/contacts.md`). If a required fact is missing (a GST number, an address line, a price), ask once with the exact field name. Do not invent.
3. Fill. Use the brand voice for any free text field. Keep descriptions under the site's limit and under 80 words unless the field is for a full listing.
4. Screenshot the completed form. If the submit commits money, identity, a legal agreement or a public post, ask. Otherwise submit.
5. Capture the confirmation (screenshot, reference number, email) and save it to `~/.hermes/forms/<site>-<date>.md`. Report in two lines.
6. If a CAPTCHA or a 2FA prompt appears, stop, screenshot, and ask Sreekar to clear it in headed mode. Do not try to bypass it.

## Event listing checklist (the most common form)

Title with the date in it; the one line description from the brand; venue address and map pin; start and end time; price (or Free, first session); capacity; age note (18 plus unless Sreekar says otherwise); what to bring; one real photo (never generated for a listing); the booking link or the WhatsApp number; category tags (workshop, dance, arts, outdoors). Three listings max per event: the one Sreekar's audience uses, plus two.

## Pitfalls

- Submitting a public listing with a placeholder still in it. Search the filled form for "[" before the screenshot.
- Creating accounts on sites without asking. Account creation is a public identity act; ask.
- Agreeing to terms that include exclusivity, fees or data sharing. Flag the clause, ask.
- Downloads: the local browser cannot download files. Ask Sreekar to download, or use a direct link through the terminal.
- Long sessions in the wrong tab. Close what you opened.

## Verification

Goal met or a specific blocker reported, confirmation saved, no placeholder submitted, gate respected.
