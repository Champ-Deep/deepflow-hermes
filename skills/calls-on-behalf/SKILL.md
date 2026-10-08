---
name: calls-on-behalf
description: Place and handle phone calls for Sreekar once a voice provider is set up (phase 2). Holds the provider options, the setup, the call script rules, and the consent and disclosure rules. Use for "call the venue", "ring them and ask", "book over the phone", "set up calling".
version: 0.9.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [calls, voice, phase-2, deepflow]
    related_skills: [outreach-email, research-brief]
required_environment_variables:
  - name: DIAL_API_KEY
    prompt: "Dial (getdial.ai) API key, if Dial is the chosen provider"
    required_for: [dial]
  - name: TWILIO_ACCOUNT_SID
    required_for: [twilio]
  - name: TWILIO_AUTH_TOKEN
    required_for: [twilio]
  - name: ELEVENLABS_API_KEY
    required_for: [twilio]
---

# Calls on Sreekar's behalf

Hermes' voice mode is for talking to Flow, not for telephony. Outbound calls need a provider that costs money per minute. Until Sreekar picks and funds one, this skill answers "not set up yet, here is what it takes" and offers to send an email or a WhatsApp reply instead (to someone who messaged first).

## When to use

Venue enquiries, confirming a booking with a vendor, asking a shop whether a prop is in stock, following up with a partner who prefers calls, reminder calls to people who booked a workshop.

## Provider options (Sreekar decides, with Champ's note)

| Option | What it is | Setup effort | Cost shape | Champ's view |
|---|---|---|---|---|
| **Dial** (getdial.ai) | Hosted calling agent: give it a goal and a script, it calls and returns a transcript and outcome | Lowest, an API key and a phone number | Per minute plus number rental | The group's October 2026 choice for ChampHarbinger for ease of setup and use. Recommended here too |
| **Twilio + ElevenLabs** | You run the call loop: Twilio for the line, ElevenLabs for the voice, Hermes for the brain | Medium, a small server or a Twilio Studio flow | Per minute on both | The alternative the group keeps alongside Dial |
| **Twilio voice only, scripted** | Pre recorded or TTS reminder calls with keypress answers, no conversation | Low | Cheapest | Fine for reminder calls only |

## Setup (once chosen)

1. Sreekar creates the account and adds a small balance (ask for his yes on the amount; $10 to $20 covers a month of light use).
2. `hermes config set DIAL_API_KEY ...` (or the Twilio and ElevenLabs keys).
3. Buy or port an Indian number if the provider supports it; otherwise a virtual number that shows a clear caller name.
4. Write the three standard scripts below into `~/.hermes/scripts/calls/` as plain text and test each with a call to Sreekar's own phone.
5. Log every call in `~/.hermes/calls.log`: who, why, outcome, cost.

## Rules on every call

- Open with who is calling and why, in one sentence: "Hi, this is Flow calling for Sreekar at Deep Flow about Sunday's session." Never deny being an assistant if asked.
- One goal per call. Get it, confirm it back, end.
- Never agree a price, a date commitment, or a contract term on a call. Say "I will confirm that with Sreekar and message you today", then do.
- Never call before 10 am or after 8 pm local, never call a number that asked not to be called, never call anyone from a Champions Group client list.
- Record only where the provider and the law allow it and the person is told.
- After the call: a two line summary to Sreekar, the transcript in the log, any promised follow up sent within the hour.

## Standard scripts

**Venue or vendor enquiry.** Who and why, the one question, the dates, "what do you need from us", thank you, confirm back.

**Booking reminder.** Who and why, the date and time, what to bring, "reply to this number if you cannot make it", thank you.

**Partner follow up.** Who and why, reference the email sent, the one ask, offer two time slots, thank you.

## Pitfalls

- Treating a call as cheaper than an email. It is not, in money or in trust. Email first unless the person prefers calls.
- Calling without a researched name and a clear goal.
- Letting the agent negotiate. It does not.

## Verification

Provider configured, test call to Sreekar done, three scripts on disk, `calls.log` exists. Until then, this skill only explains and offers alternatives.
