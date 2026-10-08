# Connectors and tools

What Flow is wired to on day one, what to add as the work grows, and how. In Hermes terms a connector is either a toolset (built in, switched on with `hermes tools`), a CLI the agent drives from the terminal, or an MCP server declared under `mcp_servers:` in `~/.hermes/config.yaml`.

## Wired in setup (SETUP.md)

| Need | How | Toolset or tool |
|---|---|---|
| Talk to Sreekar, deliver cron output | Telegram bot (or WhatsApp self chat) | gateway |
| Ask with buttons | built in | `clarify` |
| Schedule and loops | built in cron | `cronjob` |
| Browse, read pages, fill forms | packaged Chromium via agent-browser | `browser` |
| Search the web | built in | `web` (`web_search`, `web_extract`) |
| Email, read and send | himalaya CLI with a Gmail app password | `terminal` |
| Site deploys | wrangler CLI, Cloudflare Pages | `terminal` |
| Images | OpenRouter image models, FAL if needed | `image_gen` |
| Files and the repo | built in | `file`, `terminal` |
| Memory | built in MEMORY.md and USER.md | `memory` |
| Self improvement | built in skill writing, curator | `skills` |

## Add when the need appears (Flow proposes, Sreekar says yes, Flow installs)

| Trigger | Add | How |
|---|---|---|
| First booking comes in through the site form | A bookings store: a Google Sheet (simplest for Sreekar to look at) or a Cloudflare D1 table behind a Pages Function | Sheet: a Google Sheets MCP server or the `gog` CLI with a service account. D1: `wrangler d1 create deepflow` and a Pages Function that inserts rows |
| Sreekar wants session dates on his calendar and reminders | Google Calendar | An MCP server for Google Calendar under `mcp_servers:`, read and create only on his own calendar |
| Posting cadence is steady and Sreekar wants Flow to post | Instagram | Stays manual until an Instagram Business or Creator account exists; then the Meta Graph API for scheduled posts. Never a third party auto poster on a personal account |
| Enquiries arrive on WhatsApp and need templated replies | WhatsApp inbound | Already possible in self chat mode; replies to people who messaged first only, under a standing approval |
| Paid workshops | Payments | Razorpay payment links, created by Sreekar, pasted into the event page. Flow never creates payment links or touches payouts |
| Scene monitoring gets noisy | A feeds and alerts skill | `hermes skills search rss` or a small script in `scripts/` reading public pages, no accounts |
| Phone calls | Dial, or Twilio plus ElevenLabs | `calls-on-behalf` skill, phase 2, funded by Sreekar |
| Group work for Champions Ranch or 100X | The relevant brand skill and any shared docs | From Champ, never guessed |

## How to add an MCP server

```yaml
# ~/.hermes/config.yaml
mcp_servers:
  gcal:
    command: npx
    args: ["-y", "<the calendar server package>"]
    env:
      GOOGLE_OAUTH_CREDENTIALS: "~/.hermes/credentials/gcal.json"
```

Then `/reload-mcp` in the CLI (it asks first) or restart the gateway. Credentials go under `~/.hermes/credentials/` with `chmod 600`, never in the repo. Record the addition in `context/05-decisions.md` and `CHANGELOG.md`.

## Rules

- Propose a connector only when a real task needs it twice. One off needs are done with the browser.
- Prefer read only scopes, Sreekar's own accounts, and free tiers.
- Every new connector gets one line in the "Wired" table above and one line in `MEMORY.md` if it changes how a routine job runs.
- No connector that posts publicly, pays, or signs is switched on without a yes and a standing rule in `MEMORY.md`.
