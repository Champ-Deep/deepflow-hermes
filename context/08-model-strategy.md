# Model strategy

Free tiers carry the daily loops so they never stop. A paid mid tier model does the hard work when Sreekar is waiting or when a free model has failed twice. A local model is a bonus, not a plan, on an older MacBook Air.

Model names and limits change monthly. Everything below was checked on 8 October 2026. The setup verifies each one with `hermes model` and the provider's own model list before writing it to `config.yaml`, and the weekly `harness-improver` run re-checks the limits.

## Hermes constraints that shape the choice

- Hermes rejects any model with under 64K tokens of context. Several free tiers cap tokens per minute well below a full agent turn, so a high daily request quota is not enough; tokens per minute matters more.
- Auxiliary jobs (context compression, title generation, the smart approval classifier, vision) can run on a different, cheaper model than the main one. Use that.
- Switching the main model mid session is `/model <id>`. A one off hard task does not need a config change.
- Every provider is configured as an OpenAI compatible endpoint under `providers:` in `config.yaml`; keys live in `~/.hermes/.env`.

## The free pool (checked 2026-10-08, verify before use)

| Provider | Endpoint | Free limits that matter | Use for | Caveat |
|---|---|---|---|---|
| **OpenRouter free models** | `https://openrouter.ai/api/v1` (native in Hermes) | 20 requests a minute, 50 a day; 1,000 a day after a one time $10 top up. Quota shared across all `:free` models | Main chat model when Sreekar is present. Pick a `:free` model with tool calling and 64K plus context (for example `openai/gpt-oss-20b:free`, Gemma 4 or a Nemotron free variant; verify in `hermes model`) | Free models rotate. The $10 top up is the single best spend in this setup |
| **Google AI Studio** | `https://generativelanguage.googleapis.com/v1beta/openai/` | Flash Lite class: around 500 requests a day, generous tokens per minute, 1M context. Full Flash: only about 20 a day | The cron jobs and all auxiliary tasks | Free tier prompts may be used for training outside the EU and UK. Never pass secrets or private data through it (they are in `.env`, not in prompts, so this holds by default) |
| **Cerebras** | `https://api.cerebras.ai/v1` | 30K tokens a minute, 1M tokens an hour and a day; `gpt-oss-120b`, GLM and Gemma class models | Fast fallback for short cron tasks and research summaries | Tokens per minute is tight for a long agent turn; fine for short jobs |
| **Groq** | `https://api.groq.com/openai/v1` | Llama 3.3 70B about 1,000 requests a day at 12K tokens a minute; `gpt-oss-120b` similar | Quick classification and short rewrites only | 12K tokens a minute cannot carry a full agent turn with skills loaded |
| **Mistral La Plateforme** | `https://api.mistral.ai/v1` | Varies by model; requires phone verification and opting in to data training | Backup only | Opt in to training is a real cost |
| **Cloudflare Workers AI** | `https://api.cloudflare.com/client/v4/accounts/<ACCOUNT_ID>/ai/v1` | 10,000 neurons a day | Image or text classification inside Workers later | Needs the Cloudflare account that will host the site anyway |

Sources: the free LLM API resources list (github.com/cheahjs/free-llm-api-resources) and each provider's pricing page.

## The paid mid tier (Sreekar funds, used on demand)

Through OpenRouter, one account, one key, no new signups:

- A Sonnet class model (`anthropic/claude-sonnet-4.6` or the current Sonnet on OpenRouter) for landing pages, long copy, anything brand facing that must be right first time.
- A Gemini Pro class or DeepSeek V3 class model as the cheaper second choice for research and long reads.
- Rule of thumb: a landing page build costs a few cents to a few tens of cents. Two hard tasks a day is well under $10 a month.

Switch with `/model anthropic/claude-sonnet-4.6` for the session, then `/model` back. The daily brief reports paid usage so Sreekar always knows.

## Routing table (what `config.yaml` implements)

| Job | Model | Fallback chain |
|---|---|---|
| Chat with Sreekar (Telegram, CLI) | OpenRouter `:free` model with tools | Gemini Flash Lite, then Cerebras |
| Cron: daily brief, inbox triage, content ideas, harness review | Gemini Flash Lite | Cerebras, then OpenRouter free |
| Auxiliary: compression, titles, approval classifier | Gemini Flash Lite | Groq |
| Vision (reading screenshots, photos) | Gemini Flash Lite | OpenRouter free vision model |
| Hard tasks on request | Sonnet class on OpenRouter (session switch) | Gemini Pro class |
| Offline or trivial, if llmfit approves | Local model via Ollama | none, it is a bonus |

## Local models on the MacBook Air

Run `scripts/llmfit-check.sh` once. It installs llmfit (github.com/AlexsJones/llmfit), scores models against the machine's RAM and GPU, and prints the top three that fit with a 64K context window. On an older Air with 8 GB, expect only very small models to fit at 64K; they are good for offline captions and rewrites and nothing else. With 16 GB, a 7B to 9B model at 4 bit is workable for drafts.

If something fits: `hermes model`, choose Local (Hermes' managed runtime handles context size), and keep it out of the cron chain. If nothing fits, skip and move on; the free pool covers everything.

## Image generation

Hermes supports FAL, OpenAI, OpenRouter, xAI, Krea and Meta image backends. Cheapest real options: OpenRouter's chat served image models (some free, verify), then FAL's Klein 9B at about $0.006 per megapixel with a small prepaid balance. Set with `hermes tools`, Image Generation. The `image-gen-brief` skill holds the prompting rules.

## When a rate limit hits

1. Retry once after 60 seconds.
2. Move to the next model in the chain and finish the task.
3. Log the provider, the time and the job in `~/.hermes/ratelimits.log`.
4. If the same job hits a limit three days running, the `harness-improver` proposes moving it to the paid model or a different hour, and asks Sreekar.
