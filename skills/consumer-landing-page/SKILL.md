---
name: consumer-landing-page
description: Build, refresh and ship beautiful consumer landing pages for Deep Flow (deepf1ow.com) and other consumer brands. Argument first, then layout, then a render gate at phone width, then preview deploy, production only on a yes. Use for landing page, holding page, sessions page, event page, workshop page, waitlist, "make a page", "refresh the site", or swatch previews for brand decisions.
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [landing-page, design, web, deepflow, cloudflare]
    related_skills: [deepflow-brand, no-ai-slop, image-gen-brief]
    requires_toolsets: [terminal, browser]
---

# Consumer landing page

A consumer page is not a short website. It is one feeling and one action, delivered to a person on a phone who arrived from a reel and will leave in eight seconds unless the first screen earns the next one. B2B pages argue; consumer pages invite. The structure below is adapted from Champ's landing page method for the consumer case.

Reference shell with tokens, motion and micro interactions: `references/page-shell.html`. Start from it; do not start from a blank file.

## When to use

- Deep Flow: the holding page, the main landing page, a sessions page, an event or workshop page, a waitlist.
- Other consumer brands Sreekar helps (100X Longevity consumer pages, Ranch public pages only when asked, with their own brand skill).
- Swatch mode: one hero rendered three ways for a brand decision.
- Refresh mode: an existing page that looks generic or dated.

## Modes

| Mode | Output | Ask first? |
|---|---|---|
| holding | One screen: promise, one line about the stable, email capture, Instagram link | No, build it |
| landing | Full page per the spine below | Confirm the one action and the next session date |
| event | One event, one date, one CTA, a map, what to bring | Confirm date, price, capacity |
| sessions | Recurring schedule as a clean table plus one CTA | Confirm schedule |
| swatch | Same hero, three palette and type pairings, side by side on desktop, stacked on phone | No |
| refresh | Existing page reskinned, copy untouched unless asked | Confirm which page |

## Procedure

### 1. The message, before layout (write these five lines into `site/DESIGN.md`)

1. Who is arriving and from where? (Usually Instagram, on a phone, already curious.)
2. What is the one feeling the first screen should give? (For Deep Flow: "this is a real place and real people, and I could be there on Sunday".)
3. What is the single action? One. "Come to the next session" beats "learn more".
4. What is the strongest true thing to show? A real photo of a real session beats any claim. If there are no photos yet, say so plainly and use type and space, never stock.
5. What stops them? Usually: "I am a beginner", "is it far", "how much", "will I be the odd one out". The middle of the page answers those four, in that order.

### 2. Headline

Under ten words, in Sreekar's own register. Pass the swap test: could another stable or studio use it unchanged? Then it is not a headline. Patterns that work for consumer pages: a specific invitation ("Sunday evenings, spin until the light goes"), a place and a feeling ("A stable where the poi come out at six"), a plain definition ("Flow arts, horses and open ground, forty minutes from the city"). The subhead carries the when and where. Cut every intensifier.

### 3. The first screen on a phone

Render at 390 wide. Headline, one line of subhead, the CTA, and one real image or a strong typographic hero must all be visible without scrolling. Nav is one line or a single menu button. No cookie banner (Cloudflare Web Analytics needs none). No announcement bar on launch.

Hero patterns for consumer pages: a full bleed photo with a pine overlay band and type on it; an editorial type only hero on cream (when there are no photos yet); a split with a tall photo and the schedule beside it.

### 4. Spine

```
First screen        the invitation and the one action
Proof strip         three real facts: where, when, how much (or "first session free")
What it is like     two or three photos or one short video, captions in mono
Who it is for       beginners welcome, said plainly, with what to bring
How to come         directions, map embed, parking, what time to arrive
Next dates          a short table, nearest first
One question        the FAQ as three to five plain answers
Close               the same CTA, a photo, hello@ address, Instagram
```

Give each section a different shape: one full bleed, one narrow and centred, one asymmetric two column, one dense table, one quiet large number. Do not repeat "heading, subhead, three cards" down the page. One eyebrow label per three sections at most, and never with a short rule line above it.

### 5. Proof for a brand with no history

Specificity replaces social proof: the exact address, the exact time, the exact price, Sreekar's real name and face, a real phone photo, a real sentence from a real regular with a first name (or nothing). No "trusted by", no stars, no invented testimonials, no logos.

### 6. CTA

One primary action, repeated at natural decision points (after the first screen, after the dates, at the close). Label the outcome: "Save me a place on Sunday". A short line under the button reduces felt cost: "No payment now. Just tell us you are coming." Mobile: sticky CTA once the first screen scrolls past. Forms ask for the minimum: name and WhatsApp number or email, nothing else.

### 7. Build

- Start from `references/page-shell.html`. Keep tokens in `site/css/tokens.css`, components and micro interactions in `site/css/core.css`, motion in `site/js/core.js`. One HTML file per page.
- Full width on wide screens: a 1280 to 1440 content width with full bleed sections, never a narrow centred column with dead space either side.
- Type scale from the brand defaults; sentence case headlines; body max 60 characters per line.
- Images: WebP, under 250 KB, width 1600 max, `loading="lazy"` below the fold, real alt text.
- Motion: one load sequence in the hero (eyebrow, headline words, CTA), quiet reveals on scroll, count ups only for real numbers, everything off under `prefers-reduced-motion`, and a `?static=1` mode for screenshots. Durations 200 to 800 ms, easing `cubic-bezier(.16,1,.3,1)`.
- Micro interactions: every button and link gets one hover, one focus visible state, one touch state (label swap and arrow slide on the primary CTA, a pointer following glow at most on one button, lift on cards). One per element. Source ideas: MicroKit (github.com/henriquegpb/microkit) and 21st.dev when available; port to vanilla CSS and credit in a comment.
- No Tailwind CDN, no framework, no build step. Google Fonts for Instrument Serif, Inter, JetBrains Mono, with `font-display: swap`.
- `_headers` file with cache rules for `css/`, `js/`, `img/` and basic security headers.
- Form posts to Formspree (free) or a Cloudflare Pages Function that emails Sreekar; the thank you state is inline, no redirect.

### 8. Quality gate (mandatory, every mode except swatch)

1. Screenshots at 390, 834 and 1440 (`?static=1`), with the browser tool or `npx playwright screenshot --viewport-size=390,844 <url> shot-390.png`. Look at them. Describe what a stranger sees in the first screen in one sentence; if it is not "what, where, do this", fix.
2. `grep -cP '\xe2\x80[\x93\x94]' site/*.html` prints 0.
3. `no-ai-slop` gate on every line of copy.
4. Phone: no horizontal overflow, tap targets 44 px or more, cards stack cleanly, sticky CTA does not cover content.
5. Zero console errors.
6. Lighthouse or equivalent: performance above 90 on mobile. Images are the usual cause.
7. Full width on 1440: no dead side margins beyond the content width.
8. The headings alone, read top to bottom, tell the story.

### 9. Deploy

```bash
wrangler pages deploy ./site --project-name deepflow --branch preview
```

Send Sreekar the preview URL and the three screenshots with a two line note. Production (the custom domain follows `main`) only after he replies yes to that exact preview:

```bash
wrangler pages deploy ./site --project-name deepflow --branch main
echo "$(date +%FT%T) <preview-url> -> production: <reason>" >> ~/.hermes/deploys.log
git add site && git commit -m "site: <what changed>"
```

The `approvals.deny` list blocks the `--branch main` command outside this skill's gate; that is intended. Rollback: `wrangler pages deployment list` and promote the previous one.

## Pitfalls

- Starting with layout. The five lines in `site/DESIGN.md` come first, every time.
- Purple to blue gradients, 3D blobs, stock photos, feature cards in threes, an eyebrow over every heading, a rule line before a label, section numbers as decoration, fake "live" counters.
- Longevity, health or safety claims in copy. None.
- Em dashes. The gate counts them.
- Deploying to production because the preview "looked fine". Yes from Sreekar, on that preview, or it stays a preview.

## Verification

`site/DESIGN.md` has the five lines. Three screenshots looked at. Gate items 1 to 8 pass. Preview URL sent. Production only after a yes, logged in `~/.hermes/deploys.log`.
