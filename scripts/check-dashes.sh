#!/usr/bin/env bash
# Fails if an em dash or en dash appears anywhere in the given path (default: repo).
# Skips .git, node_modules, binary files and the slop linter's own pattern table.
set -euo pipefail
ROOT="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
hits=$(grep -rIlP '\xe2\x80[\x93\x94]' "$ROOT" \
  --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.wrangler \
  --exclude=slop_lint.py 2>/dev/null || true)
if [ -n "$hits" ]; then
  echo "em or en dash found in:"
  echo "$hits" | sed 's/^/  /'
  echo "fix with commas, periods, colons, parentheses, or restructure the sentence."
  exit 1
fi
echo "no dashes in $ROOT"
