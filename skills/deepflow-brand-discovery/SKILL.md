---
name: deepflow-brand-discovery
description: One guided session that asks Sreekar the open questions about the stable and the brand, then writes the answers into the repo and memory. Run once at setup, and again whenever a "Sreekar decides" item is still blank.
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [brand, intake, deepflow, onboarding]
    related_skills: [deepflow-brand]
    requires_tools: [clarify]
---

# Deep Flow brand discovery

The point is to get Sreekar's answers without a form. Three or four questions at a time, buttons where there are options, free text where there are not, his own words kept.

## When to use

- SETUP.md step 7, after the context files are read.
- Any time a task hits a blank in the "Sreekar decides" table in `context/02-brand-foundation.md` or the open list in `context/03-the-stable-and-the-flow-arts-scene.md`.
- When Sreekar says "let's sort the brand out".

## Procedure

**Before asking:** read `context/01`, `02` and `03`. Check what is already answered so nothing is asked twice.

**Round 1, the stable (free text, one message, four questions).**
1. Does the stable have its own name, or is it Deep Flow full stop?
2. Where is it, and is it on or beside Champions Ranch?
3. What do you personally practice, and what do you want to be known for?
4. What is the one thing you want to be true six months from now?

**Round 2, the offer (buttons).**
5. What runs first? Options: open practice evening (recommended), intro workshop, rides, monthly showcase, other.
6. How many people at once, and which days? (free text)
7. Pricing posture? Options: free open sessions with paid workshops (recommended), pay per session, membership, pay what it is worth.
8. What must never happen here? (free text, examples: no kids' riding lessons, no sponsor logos on the fence, no fire near the horses)

**Round 3, the look (buttons, with a preview page).**
Build one HTML page with three palette and type pairings side by side on the same hero (use the `consumer-landing-page` skill in swatch mode): A, Forest Forager default; B, a warmer clay and sand set; C, a cooler ink and slate set. Deploy to preview, send the link.
9. Which pairing? Options: A (recommended), B, C, mix (say which parts).
10. Display type? Options: Instrument Serif (free, recommended), buy GT Alpina, something else.
11. Marks? Options: a small hand drawn set (horse, poi, sun, leaf, sprig, recommended), a wordmark, decide later.

**Round 4, the channels (free text).**
12. Instagram handle, and does an account exist already?
13. Who else is involved (instructor, stable hand, photographer friend)?
14. Which hours do you work, and when do you want the morning brief?

**After each round:** reflect the answers in two lines and move on. Do not editorialize. If an answer is "later", write "Sreekar will decide later" and move on.

## Writing the answers back

1. `context/02-brand-foundation.md`: fill the "Sreekar decides" table. Replace the bracketed default with the choice and drop the word "default".
2. `context/03-the-stable-and-the-flow-arts-scene.md`: replace the ten open questions with a "Known" list in his words.
3. `context/05-decisions.md`: one dated entry, "D9. Brand discovery answers (date, Sreekar)", listing the choices and anything he deferred.
4. `~/.hermes/memories/USER.md`: hours, practices, brief time, six month goal, under 1375 characters.
5. `skills/deepflow-brand/SKILL.md`: update the visual defaults block if he chose a palette or type.
6. `site/css/tokens.css` if it exists: update the colour and font tokens.
7. Commit: "brand discovery: answers from Sreekar".

## Pitfalls

- Asking all fourteen at once. Four at most per message.
- Rewriting his answers into brand speak. Keep his words.
- Treating "later" as a blocker. The defaults exist so nothing stalls.
- Changing a fixed element (name, promise, manifesto, voice rules) because he mentioned it in passing. Those need an explicit "change it" and a note to Champ.

## Verification

All fourteen have an answer or "later". Files updated. Commit made. One line to Sreekar: "Brand sheet saved. Three things you left for later: ..." or "Nothing left open."
