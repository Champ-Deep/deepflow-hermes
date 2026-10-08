---
name: image-gen-brief
description: Generate images for Deep Flow and other consumer work with a written brief first, brand rules applied, the right provider picked by cost, and a review step before anything is used publicly. Use for "make an image", "poster", "story background", "hero photo", "thumbnail", "illustration", "mock a flyer".
version: 1.0.0
author: Champ (Sreedeep Surapaneni) for Sreekar
license: MIT
metadata:
  hermes:
    tags: [images, design, deepflow]
    related_skills: [deepflow-brand, consumer-landing-page]
    requires_toolsets: [image_gen]
---

# Image generation brief

Real photos of real sessions beat any generated image for Deep Flow. Generated images are for the gap before photos exist, for backgrounds, posters and type led graphics, and for mockups. Never present a generated image as a photo of the stable.

## When to use

Story backgrounds, poster art, event flyers, hero textures, illustrated marks, mockups of merch, placeholder heroes on a page until real photos arrive.

## Quick reference

**Provider by cost.** OpenRouter image models first (some are free or near free; check with `hermes tools`, Image Generation). FAL Klein 9B at about $0.006 per megapixel when quality is short. Never switch providers silently; propose and log it.

**Always in the prompt.** Subject, setting, light, lens or medium, palette, mood, what to exclude. Golden hour, warm shadows, film grain, asymmetric framing, open ground, dust in the light. Palette words from the brand: deep pine green, parchment cream, pale lilac, terracotta accents, charcoal ink.

**Always excluded.** Text in the image (type is added in the page or in a design tool), logos, mandalas, lotus flowers, gradient sunsets, neon, purple to blue gradients, 3D blobs, stock photo smiles, faces presented as real people, horses in unsafe positions, fire near horses.

**Sizes.** Instagram feed 1080x1350 (4:5), story and reel cover 1080x1920 (9:16), site hero 1600x1000 (16:10) then convert to WebP under 250 KB, poster A3 at 300 dpi only when printing is confirmed.

## Procedure

1. Write the brief in five lines before generating: purpose and placement, subject, mood and light, palette, exclusions. Show it to Sreekar only if the image is for public use and the brief is ambiguous; otherwise proceed.
2. Generate two variants, not six. Prompt for consistency: same lens, same light, same palette words across a set.
3. Review each against the brand's golden hour test and the exclusion list. Discard anything that reads as stock or as a fake photo of real people.
4. Deliver the better one in chat with the brief under it, plus the file path. For site use, convert to WebP and drop into `site/img/`.
5. Log provider, model and cost per image in `~/.hermes/images.log`.

## Illustration and marks

For the hand drawn mark set (horse, poi, sun, leaf, sprig): prompt for "single line ink drawing, slightly imperfect, on cream paper, no shading, no text". Generate, then trace or redraw as SVG for the site. These marks are a Sreekar decision; propose, do not publish.

## Pitfalls

- Generating a "photo" of a session that never happened and posting it. The brand is built on real people in a real place.
- Prompts with brand words only and no concrete subject. "Flow state vibes" produces slop.
- Many variants. Two, then adjust the brief.
- Burning paid credits on drafts. Draft on the free or cheapest model, finish on the better one.

## Verification

Brief written, two variants, one chosen, exclusions respected, size right for the placement, cost logged.
