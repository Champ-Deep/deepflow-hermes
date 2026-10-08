# Decisions

One entry per decision, newest at the bottom. Each has the decision, the reasoning, and what would change it. Hermes adds entries when Sreekar decides something; it never deletes one.

## D1. Hermes is the harness, not Paperclip (2026-10-08, Champ)

**Decision.** Sreekar's assistant runs on Hermes Agent (Nous Research) on his own MacBook, with the messaging gateway and cron for the always on parts. Paperclip is not installed.

**Reasoning.** Paperclip is an org chart for many agents with budgets, heartbeats and tickets. It earns its keep when there are several distinct agent roles, real per agent spend, and a team reviewing a queue. Deep Flow today is one person and one assistant on free tiers. Paperclip would add a server, a database, per agent budgets and a dashboard to supervise, with nothing to orchestrate yet. Hermes already has what the version 1 Paperclip design wanted: scheduled runs (cron), skills that improve over time, memory, approval gates, Telegram and WhatsApp delivery, a browser, and delegation to subagents for bigger jobs.

**What would change it.** Three or more agent roles that need separate budgets and a ticket queue, or a second human reviewing work. At that point Hermes becomes one Paperclip worker; nothing in this repo is thrown away.

## D2. Telegram first, WhatsApp optional (2026-10-08, Champ)

**Decision.** The setup walks Sreekar through Telegram as the default channel. WhatsApp is offered as a second step if he prefers it.

**Reasoning.** Telegram needs no second phone number, has no ban risk, supports inline buttons for the agent's questions, and the Hermes wizard sets it up in two minutes. WhatsApp through Hermes uses an unofficial bridge; it needs a dedicated number in bot mode, can be restricted by WhatsApp, and must never send cold outbound messages. Sreekar's preference wins; the setup asks.

**What would change it.** Sreekar lives in WhatsApp and wants the agent there. Then: self chat mode on his own number for talking to the agent, Telegram still used for cron delivery, no outbound WhatsApp to strangers.

## D3. Free tiers run the daily loops, a mid tier model does the hard work (2026-10-08, Champ)

**Decision.** Scheduled and autonomous runs (daily brief, content ideas, inbox triage, harness review) use free API tiers. Landing pages, long research, anything Sreekar is waiting on, and anything that failed twice on a free model use a paid mid tier model. Local models on the MacBook Air are a fallback for trivial tasks, if llmfit says one fits.

**Reasoning.** The loops must survive with zero spend so they never stop. The hard tasks are rare and worth a few cents each. The MacBook Air is older, so local models are a nice to have, not a plan. Details and the routing table are in `08-model-strategy.md`.

**What would change it.** A rate limit that keeps blocking a daily job (move that job to the paid model and log it), or a budget line from Sreekar.

## D4. Fresh brand under the Deep Flow name (2026-10-08, Champ)

**Decision.** Sreekar inherits the Deep Flow name, promise, manifesto and voice rules. He does not inherit the Forest Forager palette, the Editorial Ranch look, or the dingbats as a lock; they are the recommended default until he picks.

**Reasoning.** The stable is his project and the identity should feel like his. The May 2026 design work is good enough to be the default, which means nothing stalls while he decides.

**What would change it.** Nothing; this is his call to make through the discovery skill.

## D5. Act, ask, never (2026-10-08, Champ)

**Decision.** Hermes acts on its own for drafts, research, scheduling, page previews, internal notes and anything reversible. It asks Sreekar, with a specific question and options, before anything that is hard to reverse or changes what the public sees. It never does the items on the never list. Full policy in `06-operating-policy.md`.

**Reasoning.** Champ's words: ask for input instead of always waiting for permission, unless it is dangerous or will have massive impact, like website changes that may break the site, or anything that may change the brand.

## D6. Site builds are static pages on Cloudflare Pages, previews before production (2026-10-08, Champ, pending Sreekar's confirmation of where the domain lives)

**Decision.** Landing pages are single file HTML with the shared tokens, built with the `consumer-landing-page` skill, deployed to a preview URL first, promoted to deepf1ow.com only after Sreekar replies yes to the preview link.

**Reasoning.** Zero hosting cost, a preview URL on every change, rollbacks in one command, and the domain is believed to be on Namecheap with DNS on Cloudflare already. Details and the verification step in `07-domain-site-and-stack.md`.

## D7. Email goes out only after a shown draft, until Sreekar grants standing approval per class (2026-10-08, Champ)

**Decision.** Every outbound email is drafted, shown in chat, and sent on "yes". Sreekar can grant standing approval for a class ("replies to people who asked about open sessions") and Hermes then sends those without asking, reporting what went out in the daily brief.

**Reasoning.** Email is the channel that embarrasses fastest and is hardest to recall. Standing approvals per class keep autonomy growing without a blanket switch.

## D8. Calls on Sreekar's behalf are phase 2 and need a paid provider (2026-10-08, Champ)

**Decision.** Hermes does not place phone calls until Sreekar picks and funds a voice provider. The `calls-on-behalf` skill holds the options and the script rules so the day he does, it is a one hour setup.

**Reasoning.** Hermes has voice mode for talking to the agent, not telephony. Outbound calls need Twilio plus a voice engine, or a hosted calling agent. The group's own standard (chosen for ChampHarbinger in October 2026) is Dial (getdial.ai) for ease of setup, with ElevenLabs plus Twilio as the alternative. Both cost money per minute.
