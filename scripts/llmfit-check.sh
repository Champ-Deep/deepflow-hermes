#!/usr/bin/env bash
# Scores local models against this Mac. Prints the top picks that fit with a 64K context,
# which is the minimum Hermes accepts. On an older MacBook Air expect few or none; that is fine.
set -euo pipefail

if ! command -v llmfit >/dev/null 2>&1; then
  echo ">> installing llmfit (github.com/AlexsJones/llmfit)"
  if command -v brew >/dev/null 2>&1; then
    brew install AlexsJones/llmfit/llmfit
  else
    curl -fsSL https://llmfit.axjns.dev/install.sh | sh -s -- --local
    export PATH="$HOME/.local/bin:$PATH"
  fi
fi

echo ">> hardware"
llmfit doctor 2>/dev/null | head -20 || true
echo
echo ">> top picks as JSON (fit, speed, quality). Look for context >= 65536 and a quality score you can live with."
llmfit recommend --json 2>/dev/null | head -80 || llmfit fit | head -30

cat <<'EOF'

How to read this:
- If a 7B or larger model fits at 64K context with a decent speed estimate, run `hermes model`, choose Local,
  pick it, and use it for offline captions and rewrites. Keep it out of the cron chain.
- If only tiny models fit, skip local models. The free API pool in context/08-model-strategy.md covers everything.
- `llmfit info "<model>"` explains the estimate behind any single row.
EOF
