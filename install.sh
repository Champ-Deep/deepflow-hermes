#!/usr/bin/env bash
# Deep Flow Hermes installer. Idempotent: run it as often as you like.
# Applies hermes/ to ~/.hermes, symlinks skills/, creates working folders, checks for dashes.
# Secrets are never touched here; see SETUP.md step 3.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
STAMP="$(date +%Y%m%d-%H%M%S)"

say()  { printf '\033[1;32m>>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }
fail() { printf '\033[1;31mxx\033[0m %s\n' "$*"; exit 1; }

command -v hermes >/dev/null 2>&1 || fail "hermes is not installed. Do SETUP.md step 1 first."
mkdir -p "$HERMES_HOME/memories" "$HERMES_HOME/skills" "$HERMES_HOME/parked" "$HERMES_HOME/backups/$STAMP"
mkdir -p "$REPO/proposals" "$REPO/site"

# 1. Identity and memory, with backups of whatever was there
for f in SOUL.md memories/USER.md memories/MEMORY.md; do
  if [ -f "$HERMES_HOME/$f" ] && ! cmp -s "$REPO/hermes/$f" "$HERMES_HOME/$f"; then
    mkdir -p "$HERMES_HOME/backups/$STAMP/$(dirname "$f")"
    cp "$HERMES_HOME/$f" "$HERMES_HOME/backups/$STAMP/$f"
    warn "backed up existing $f to backups/$STAMP"
  fi
  cp "$REPO/hermes/$f" "$HERMES_HOME/$f"
  say "installed $f"
done

# Size guard: Hermes caps USER.md at 1375 chars and MEMORY.md at 2200 chars
u=$(wc -c < "$HERMES_HOME/memories/USER.md"); m=$(wc -c < "$HERMES_HOME/memories/MEMORY.md")
[ "$u" -le 1375 ] || warn "USER.md is $u chars, over the 1375 limit. Trim it."
[ "$m" -le 2200 ] || warn "MEMORY.md is $m chars, over the 2200 limit. Trim it."

# 2. Non secret config, applied through hermes so its own defaults and migrations survive.
#    Provider endpoints and keys are added in SETUP.md step 3 and 4 through `hermes model`.
set_cfg() { hermes config set "$1" "$2" >/dev/null 2>&1 && say "config $1" || warn "could not set $1 (set it in hermes config edit)"; }

set_cfg approvals.mode smart
set_cfg approvals.timeout 3600
set_cfg approvals.cron_mode deny
set_cfg approvals.single_query_mode deny
set_cfg approvals.unattended_mode deny
set_cfg approvals.deny '["git push --force*","git push -f*","wrangler pages deploy * --branch main*","wrangler pages deploy * --branch=main*","wrangler pages project delete*","wrangler dns *","rm -rf ~*","rm -rf /*","rm -rf $HOME*","*~/.hermes/.env*","*~/.hermes/platforms/*"]'
set_cfg agent.clarify_timeout 3600
set_cfg agent.personalities.flow "Wry but warm, short, first two lines carry the message. Zero em dashes and en dashes. Options as a numbered list only when a choice is needed. Act on reversible things, ask with options on public, permanent, expensive or brand changing things."
set_cfg display.personality flow
set_cfg memory.memory_enabled true
set_cfg memory.user_profile_enabled true
set_cfg memory.write_approval false
set_cfg skills.write_approval false
set_cfg skills.guard_agent_created true
set_cfg skills.auto_load '["deepflow-brand","no-ai-slop"]'
set_cfg terminal.backend local
set_cfg terminal.timeout 300
set_cfg terminal.cwd "$REPO"
set_cfg browser.cloud_provider local
set_cfg browser.headed false
set_cfg browser.dialog_policy dismiss
set_cfg image_gen.provider openrouter
set_cfg image_gen.max_parallel_requests 2
set_cfg whatsapp.unauthorized_dm_behavior ignore
set_cfg whatsapp.group_policy pairing
set_cfg whatsapp.require_mention true

# 3. Skills: one symlink per folder so the repo stays the single copy
for d in "$REPO"/skills/*/; do
  name="$(basename "$d")"
  target="$HERMES_HOME/skills/$name"
  if [ -L "$target" ] || [ ! -e "$target" ]; then
    ln -sfn "$d" "$target" && say "skill $name"
  else
    warn "$target exists and is not a symlink; left alone"
  fi
done

# 4. Dash check across the repo
"$REPO/scripts/check-dashes.sh" "$REPO" || fail "dashes found; fix before continuing"

# 5. Progress marker for SETUP.md
touch "$HERMES_HOME/setup-progress.md"
grep -q "install.sh" "$HERMES_HOME/setup-progress.md" 2>/dev/null || echo "- $(date +%F) install.sh ran" >> "$HERMES_HOME/setup-progress.md"

say "done. Next: hermes --tui, say hello, then paste the line at the top of SETUP.md."
