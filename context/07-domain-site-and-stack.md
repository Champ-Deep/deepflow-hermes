# Domain, site and stack

## The domain

- Champ believes the domain is **deepf1ow.com** (with the digit one), registered on Namecheap, with DNS possibly on Cloudflare.
- On 8 October 2026 the name resolved to nothing: no nameservers, no A record, no HTTP response. So one of these is true: the spelling is different, the domain is registered but DNS was never pointed anywhere, or it lapsed.
- Related names that exist and are not ours: deepflow.com (someone else's, on Cloudflare) and deepflow.in (someone else's, on Vercel). Do not confuse them with Deep Flow.

**First task on this topic (setup step 7 in `SETUP.md`):** confirm with Sreekar which registrar account holds the domain and what the exact spelling is. Then:

1. Log in to Namecheap (Sreekar does this, or hands Hermes a session in real profile browser mode).
2. Check the exact domain, its expiry, and whether its nameservers are Namecheap's or Cloudflare's.
3. If not on Cloudflare: add the site to a Cloudflare account owned by Sreekar (free plan), copy the two Cloudflare nameservers into Namecheap. Propagation takes minutes to a day.
4. Turn on Cloudflare's free features that matter: Always Use HTTPS, Email Routing (gives hello@deepf1ow.com forwarding to Sreekar's Gmail for free), and AI bot settings as Sreekar prefers.

Hermes asks before any DNS or nameserver change (see `06-operating-policy.md`).

## The site

**What it is.** A small, beautiful consumer site. One landing page that does one job (get a person to come to the next session), plus pages as the stable grows: a sessions page, a workshops page, a story page, a contact page. No blog until there are regulars.

**Stack (locked by Champ, confirm with Sreekar).**

| Layer | Choice | Why |
|---|---|---|
| Pages | Single file HTML per page, shared CSS tokens, vanilla JS for motion | No build step, no framework to break, Hermes can edit any page in one shot |
| Fonts | Instrument Serif (display), Inter (body), JetBrains Mono (captions) from Google Fonts, or self hosted if Sreekar buys GT Alpina | Free, fast, matches the brand default |
| Hosting | Cloudflare Pages, free plan | Preview URL on every deploy, instant rollback, same account as DNS |
| Deploy | `wrangler pages deploy ./site --project-name deepflow` | One command; preview branches deploy to `*.deepflow.pages.dev`, production to the custom domain |
| Forms | Cloudflare Pages Functions plus a free form endpoint (Formspree free tier or a Worker that emails Sreekar) | No backend to run |
| Analytics | Cloudflare Web Analytics (free, no cookie banner) | Enough to see which page and which reel brought people |
| Images | WebP, max 1600px wide, under 250 KB each, in `site/img/` | Speed on phones, where most visitors arrive |

**Repo layout for the site** (created by the first `consumer-landing-page` run):

```
site/
  index.html           the landing page
  sessions.html        when, where, how much (once sessions exist)
  css/tokens.css       colours, type, spacing, motion tokens
  css/core.css         components and micro interactions
  js/core.js           reveals, count ups, reduced motion handling
  img/                 WebP only
  _headers             cache and security headers for Cloudflare Pages
```

## Deploy rules

1. Every build goes to a **preview** first: `wrangler pages deploy ./site --project-name deepflow --branch preview`. Send Sreekar the preview URL and three screenshots (390, 834, 1440 wide).
2. **Production** (`--branch main`, which the custom domain follows) only after Sreekar replies yes to that exact preview. This is on the ask list and the `approvals.deny` list blocks the command without the gate.
3. Keep the last three production deploys listed in `~/.hermes/deploys.log` with the preview URL they came from, so a rollback is one `wrangler pages deployment` command away.
4. Never deploy with a dash character in the HTML, a console error, horizontal overflow at 390px, or a tap target under 44px. The `consumer-landing-page` quality gate checks all four.

## Credentials this needs (in `~/.hermes/.env`, never in the repo)

- `CLOUDFLARE_API_TOKEN` scoped to Pages edit and DNS edit on the one zone.
- `CLOUDFLARE_ACCOUNT_ID`.
- Namecheap: no API (it needs a balance and whitelisted IPs). Sreekar logs in himself, or hands Hermes a real profile browser session for that one task.
