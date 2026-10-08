#!/usr/bin/env bash
# Post setup checks. Green means done, yellow means optional, red means fix it.
set -uo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
H="${HERMES_HOME:-$HOME/.hermes}"
ok()   { printf '\033[1;32m[ok]\033[0m   %s\n' "$*"; }
warn() { printf '\033[1;33m[opt]\033[0m  %s\n' "$*"; }
bad()  { printf '\033[1;31m[fix]\033[0m  %s\n' "$*"; FAIL=1; }
FAIL=0

command -v hermes >/dev/null && ok "hermes installed ($(hermes --version 2>/dev/null | head -1))" || bad "hermes not installed"

grep -q "Deep Flow" "$H/SOUL.md" 2>/dev/null && ok "SOUL.md is Flow" || bad "SOUL.md not installed (run ./install.sh)"

u=$(wc -c < "$H/memories/USER.md" 2>/dev/null || echo 0); m=$(wc -c < "$H/memories/MEMORY.md" 2>/dev/null || echo 0)
[ "$u" -gt 0 ] && [ "$u" -le 1375 ] && ok "USER.md $u chars" || bad "USER.md missing or over 1375 chars ($u)"
[ "$m" -gt 0 ] && [ "$m" -le 2200 ] && ok "MEMORY.md $m chars" || bad "MEMORY.md missing or over 2200 chars ($m)"

[ "$(hermes config get approvals.mode 2>/dev/null | tr -d '[:space:]')" = "smart" ] && ok "approvals.mode smart" || bad "approvals.mode is not smart"
[ "$(hermes config get timezone 2>/dev/null | tr -d '[:space:]')" = "Asia/Kolkata" ] && ok "timezone Asia/Kolkata" || bad "timezone not set (rerun ./install.sh)"
[ "$(hermes config get cron.provider 2>/dev/null | tr -d '[:space:]')" = "gemini" ] && ok "cron jobs routed to gemini" || warn "cron.provider not set (rerun ./install.sh)"
hermes config get providers.gemini 2>/dev/null | grep -q key_env && ok "gemini provider defined" || bad "providers.gemini missing (rerun ./install.sh)"

for s in deepflow-brand deepflow-brand-discovery consumer-landing-page no-ai-slop daily-marketing-loop harness-improver initiative outreach-email image-gen-brief browse-and-fill-forms research-brief calls-on-behalf; do
  [ -e "$H/skills/$s/SKILL.md" ] && ok "skill $s" || bad "skill $s not linked"
done

if grep -q "^OPENROUTER_API_KEY=." "$H/.env" 2>/dev/null; then ok "OpenRouter key"; else bad "OPENROUTER_API_KEY missing"; fi
if grep -q "^GEMINI_API_KEY=." "$H/.env" 2>/dev/null; then ok "Gemini key"; else warn "GEMINI_API_KEY missing (cron jobs will use the main model)"; fi
if grep -q "^CEREBRAS_API_KEY=." "$H/.env" 2>/dev/null; then ok "Cerebras key"; else warn "CEREBRAS_API_KEY missing"; fi
perm=$(stat -c %a "$H/.env" 2>/dev/null || stat -f %Lp "$H/.env" 2>/dev/null); [ "$perm" = "600" ] && ok ".env is 600" || bad ".env permissions are $perm, run chmod 600 $H/.env"

if grep -qE "^(TELEGRAM_BOT_TOKEN|WHATSAPP_ENABLED)=." "$H/.env" 2>/dev/null; then ok "a channel is configured"; else bad "no channel (SETUP.md step 5)"; fi
grep -q "^TELEGRAM_ALLOWED_USERS=[0-9]" "$H/.env" 2>/dev/null && ok "Telegram allowlist set" || warn "Telegram allowlist not set"

gw=$(hermes gateway status 2>&1 || true)
if printf "%s" "$gw" | grep -qi "not running"; then bad "gateway not running (hermes gateway install)"; else ok "gateway running"; fi
cs=$(hermes cron status 2>&1 || true)
if printf "%s" "$cs" | grep -qi "will NOT fire"; then bad "cron scheduler not served (start the gateway)"; else ok "cron scheduler served"; fi

n=$(python3 -c "import json,sys;print(len([j for j in json.load(open(sys.argv[1])).get('jobs',[]) if j.get('enabled',True)]))" "$H/cron/jobs.json" 2>/dev/null || echo 0)
[ "$n" -ge 7 ] && ok "cron jobs: $n" || warn "cron jobs found: $n of 7 (run ./cron/jobs.sh)"

command -v wrangler >/dev/null && wrangler whoami >/dev/null 2>&1 && ok "wrangler logged in" || warn "wrangler not ready (SETUP.md step 8)"
[ -f "$HOME/.config/himalaya/config.toml" ] && ok "himalaya configured" || warn "email not configured (SETUP.md step 9)"
[ -f "$REPO/BACKLOG.md" ] && ok "BACKLOG.md present" || bad "BACKLOG.md missing"
[ -f "$REPO/site/index.html" ] && ok "site/index.html exists" || warn "no site yet (consumer-landing-page skill)"

"$REPO/scripts/check-dashes.sh" "$REPO" >/dev/null 2>&1 && ok "no dashes in repo" || bad "dashes in repo (scripts/check-dashes.sh)"
if git -C "$REPO" rev-parse >/dev/null 2>&1; then
  [ -z "$(git -C "$REPO" status --porcelain)" ] && ok "git clean" || warn "uncommitted changes in repo"
else
  warn "repo is not a git checkout"
fi

echo
[ "$FAIL" = 0 ] && echo "all required checks passed" || { echo "fix the [fix] lines and rerun"; exit 1; }
