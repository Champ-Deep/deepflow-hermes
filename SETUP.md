# Setup

Forty minutes from a bare Mac to a working assistant on Telegram that runs every day. Every step below was run end to end against Hermes v0.21.6 on 9 October 2026. Sreekar does steps 1 and 2 by hand. From step 3, he can paste one line into Hermes and let it drive:

> Set yourself up from ~/deepflow-hermes/SETUP.md, starting at step 3. Ask me with options when a step needs something from me. Do not wait for permission on anything reversible.

**For Hermes:** run each step, verify it with the check at the end of the step, and only then move on. Where a step says "ask Sreekar", use the clarify tool with a recommended option first. Never print a key back into chat. Mark each finished step in `~/.hermes/setup-progress.md` so a restart resumes where it stopped.

## What you need before starting

- A Mac (this guide assumes macOS; Linux and WSL2 work the same, native Windows does not).
- Git. Everything else is installed by the Hermes installer.
- A Telegram account on your phone (or WhatsApp, see step 5).
- Thirty minutes where you can answer a few questions.
- Accounts you will create in step 3, all free: OpenRouter, Google AI Studio, Cerebras, Groq. One optional one time $10 top up on OpenRouter.

## Step 1. Install Hermes (Sreekar, by hand)

```bash
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
source ~/.zshrc
hermes --version
```

If `hermes` is not found: `export PATH="$HOME/.local/bin:$PATH"` and add that line to `~/.zshrc`.

**Check:** `hermes doctor` prints no errors.

## Step 2. Get this repo onto the Mac (Sreekar, by hand)

```bash
cd ~
git clone https://github.com/Champ-Deep/deepflow-hermes.git deepflow-hermes   # or unzip the archive Champ sent into ~/deepflow-hermes
cd ~/deepflow-hermes
./install.sh
```

`install.sh` does this, and is safe to run again any time:

- backs up anything already in `~/.hermes/SOUL.md` and `~/.hermes/memories/`
- copies `hermes/SOUL.md` and the two memory files into place
- applies the settings in `hermes/config.yaml` with `hermes config set`
- symlinks every folder in `skills/` into `~/.hermes/skills/`
- creates `~/.hermes/parked`, `proposals/`, `site/` if missing
- runs `scripts/check-dashes.sh`

**Check:** `hermes config get approvals.mode` prints `smart`, and `hermes skills list` shows `deepflow-brand`.

Now open Hermes once so it picks up the identity: `hermes --tui`, say "hello", and confirm it introduces itself as Flow. Then paste the line at the top of this file.

## Step 3. Model keys (Hermes drives, Sreekar supplies keys)

Ask Sreekar to create the keys, one at a time, and paste each one into the terminal when prompted. Hermes writes them with `hermes config set`, which puts them in `~/.hermes/.env`.

| Provider | Where | Why |
|---|---|---|
| OpenRouter | openrouter.ai, Keys. Then Credits, add $10 once | Main chat model. The $10 lifts the free pool from 50 to 1,000 requests a day |
| Google AI Studio | aistudio.google.com, Get API key | Runs the scheduled jobs and the cheap background tasks |
| Cerebras | cloud.cerebras.ai | Fallback when the others are rate limited |
| Groq | console.groq.com | Short classification tasks |

```bash
hermes config set OPENROUTER_API_KEY sk-or-...
hermes config set GEMINI_API_KEY ...
hermes config set CEREBRAS_API_KEY ...
hermes config set GROQ_API_KEY ...
chmod 600 ~/.hermes/.env
```

**Check:** `hermes config check` passes and `hermes doctor` no longer lists a missing credential for openrouter.

## Step 4. Verify the models (Hermes)

`install.sh` already wrote the whole routing into the live config: OpenRouter free model for chat, the gemini, cerebras and groq providers (keys referenced by name, read from `.env`), the fallback chain, `cron.provider` and `cron.model` so every scheduled job runs on the free Gemini pool, and the auxiliary tasks. Nothing to add by hand. What remains is checking that the model ids still exist, because they drift.

1. `hermes config get model.default`, `hermes config get providers`, `hermes config get cron.model`: confirm they match `hermes/config.yaml`.
2. Smoke test the main model: `hermes chat -q "Reply with the single word ok."`
3. Smoke test each fallback the same way after `hermes config set model.provider gemini` (then `cerebras`), and set `model.provider` back to `openrouter` at the end. Or use `hermes model` to pick interactively; the custom providers show up there by name.
4. If an id is gone or returns a 404 or "model not found": open the provider's model list, pick the closest current free model with 64K or more context and tool calling, `hermes config set` the new id (for example `hermes config set cron.model <id>` or `hermes config set providers.gemini.default_model <id>`), update `hermes/config.yaml` and `install.sh` in the repo so they stay in step, and note the swap in `CHANGELOG.md`.
5. A test run of a scheduled job on the cron model, without waiting for the schedule: `hermes cron create "in 2m" "Reply with the word ready." --name "Cron smoke test" --deliver local`, wait, then `hermes cron runs` and remove it.

Read `context/08-model-strategy.md` for the routing logic and what to do when a limit hits.

**Check:** the main model and both fallbacks answered the smoke test, and the cron smoke test produced a run. Record the ids and the date in `~/.hermes/setup-progress.md`.

## Step 5. Channel (Hermes asks, Sreekar picks)

Ask: "Telegram or WhatsApp for talking to me? Telegram is recommended: no second number, no ban risk, buttons for my questions. WhatsApp works too but needs care."

**Telegram (recommended).**
1. Sreekar opens @BotFather on Telegram, sends `/newbot`, picks a name ("Flow") and a username ending in `bot`, and copies the token.
2. Sreekar messages @userinfobot to get his numeric id.
3. Run `hermes gateway setup`, choose Telegram, paste the token and the id. Or set them directly:
   ```bash
   hermes config set TELEGRAM_BOT_TOKEN ...
   hermes config set TELEGRAM_ALLOWED_USERS <id>
   hermes config set TELEGRAM_HOME_CHANNEL <id>
   ```
4. `hermes gateway` in the foreground, send the bot "hello" from the phone, confirm a reply, stop it with Ctrl-C.

**WhatsApp (if he prefers).** Self chat mode on his own number is the safe choice: he messages himself and Flow answers there. Bot mode needs a dedicated SIM. Run `hermes whatsapp`, scan the QR, then set `WHATSAPP_ALLOWED_USERS` to his number with country code and no plus. Read the caveats in `context/05-decisions.md` D2. Never send to anyone who has not messaged first. Even with WhatsApp chosen, keep Telegram set up for cron delivery if he is willing; it is the more reliable delivery channel.

**Check:** `hermes gateway status` shows the platform connected and Sreekar's id in the allowlist.

## Step 6. Run the gateway as a service (Hermes)

```bash
hermes gateway install
hermes gateway status
```

This keeps Flow on while the Mac is awake. On a MacBook Air, two settings matter and need Sreekar's hands: System Settings, Battery, "Prevent automatic sleeping on power adapter when the display is off" on, and keep the Mac plugged in overnight if the morning jobs should run. If the lid is closed and unplugged, cron jobs run at the next wake, which is fine for most of them.

**Check:** send a message from the phone with the terminal closed and get a reply.

## Step 7. First conversation: discovery (Hermes)

Read `context/00-READ-ORDER.md`, all ten context files, and `BACKLOG.md`. Then run the `deepflow-brand-discovery` skill. It asks Sreekar the ten questions in `context/03-the-stable-and-the-flow-arts-scene.md` plus the "Sreekar decides" items in `context/02-brand-foundation.md`, in his channel, a few at a time, with buttons. Write the answers back into those files, update `~/.hermes/memories/USER.md`, add a dated entry to `context/05-decisions.md`, and commit.

**Check:** the open items in `context/03` are filled or marked "Sreekar will decide later", and `USER.md` has his hours, practices and six month goal.

## Step 8. Domain and site (Hermes asks, Sreekar logs in)

1. Ask Sreekar for the exact domain spelling and which registrar account holds it. Champ's note says deepf1ow.com on Namecheap; it resolved to nothing on 8 October 2026.
2. `dig +short NS <domain>`. If nameservers are Cloudflare's, skip to 4.
3. Sreekar creates a free Cloudflare account (or uses an existing one), adds the site, and sets the two Cloudflare nameservers in Namecheap. This is on the ask list; Hermes guides, Sreekar clicks, or hands Hermes a real profile browser session for this one task.
4. Sreekar creates a Cloudflare API token (Pages edit, DNS edit, one zone) and the account id. `hermes config set CLOUDFLARE_API_TOKEN ...` and `hermes config set CLOUDFLARE_ACCOUNT_ID ...`.
5. `npm install -g wrangler`, then `wrangler whoami` to confirm the token.
6. Run the `consumer-landing-page` skill in "holding page" mode: a single page with the promise, one line about the stable, and an email capture. Deploy to preview, send the preview link and screenshots, deploy to production only on a yes.
7. Turn on Cloudflare Email Routing for hello@<domain> forwarding to Sreekar's inbox, with his yes.

**Check:** `https://<domain>` serves the holding page over HTTPS. `~/.hermes/deploys.log` has one line.

## Step 9. Email (Hermes guides, Sreekar supplies an app password)

Hermes sends and reads mail through the himalaya CLI.

1. Ask which address Flow should send from: Sreekar's Gmail, or a new address on the domain. Gmail is fastest.
2. Sreekar turns on 2 step verification and creates an app password at myaccount.google.com/apppasswords. It goes into `~/.config/himalaya/app-password` with `chmod 600`, never into chat.
3. Write `~/.config/himalaya/config.toml` with IMAP `imap.gmail.com:993` and SMTP `smtp.gmail.com:587` (start TLS), login as the Gmail address, auth command `cat ~/.config/himalaya/app-password`.
4. `himalaya envelope list` shows the inbox.

The `outreach-email` skill holds the rules: draft, show, send on yes, standing approvals per class.

**Check:** Flow sends Sreekar one test email from the account and he confirms receipt.

## Step 10. Browser, images, local models (Hermes)

- Browser: `hermes pm install agent-browser`, then `hermes tools` and enable Browser Automation on local. Test: "open deepflow.pages.dev and tell me the headline".
- Images: `hermes tools`, Image Generation, OpenRouter. If the free or cheap models look weak after three tries, propose a $5 FAL balance and switch. The `image-gen-brief` skill carries the prompting rules.
- Local models (optional): `scripts/llmfit-check.sh`. If a 7B or larger model fits at 64K context, `hermes model`, Local, pick it, and keep it out of the cron chain. On an 8 GB Air, expect "nothing worth it" and move on.

**Check:** the browser test returns a headline; one test image lands in Telegram.

## Step 11. Scheduled jobs (Hermes)

```bash
./cron/jobs.sh
hermes cron list
hermes cron status
```

Seven jobs: morning brief, inbox triage, content ideas, Instagram and community check, a 2 pm initiative slot that works through `BACKLOG.md` when there is spare quota, nightly harness review, weekly model and skill check. Every job replies `[SILENT]` when there is nothing to say. Delivery is the Telegram home channel.

**Check:** `hermes cron list` shows seven jobs and the next run times.

## Step 12. Verify everything

```bash
./scripts/verify.sh
```

It checks: SOUL.md in place, memory files under the size limits, config keys applied, skills symlinked, at least one channel configured, gateway service running, cron jobs present, wrangler logged in, himalaya configured, no dashes in the repo, git clean. Fix anything red, rerun.

## Step 13. Hand over (Hermes to Sreekar, in chat)

Send Sreekar this, in your own words, under ten lines: what runs each morning, how to ask for a page, how to grant a standing approval, how to switch to the paid model for a hard task (`/model`), where to see what you did (`~/.hermes/cron/output/` and the brief), how the 2 pm initiative slot works and how he adds to `BACKLOG.md` by chat, and the three things you will always ask about (production site, brand, money).

Then suggest the first three jobs, as options: the holding page already up, the Instagram bio and first nine posts, or outreach to IndieFlow.
