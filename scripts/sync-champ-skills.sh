#!/usr/bin/env bash
# Pulls Champ's public skill bench (github.com/Champ-Deep/champ-skills) and links its design/
# folder into ~/.hermes/skills/design/. Links, not copies: a `git pull` here updates every skill.
# Idempotent. Called by install.sh and by the weekly cron job. Safe to run by hand.
set -euo pipefail

HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
BENCH="${CHAMP_SKILLS_DIR:-$HOME/champ-skills}"
DEST="$HERMES_HOME/skills/design"

if [ -d "$BENCH/.git" ]; then
  git -C "$BENCH" pull --ff-only --quiet || echo "!! champ-skills pull failed, using the copy already on disk"
else
  git clone --quiet --depth 1 https://github.com/Champ-Deep/champ-skills.git "$BENCH"
fi

mkdir -p "$DEST"
n=0
# Top level skills only: design/<x>/SKILL.md and design/<group>/<x>/SKILL.md. Deeper SKILL.md files
# are references inside a skill and load with their parent.
while IFS= read -r skill; do
  dir="$(dirname "$skill")"
  name="$(basename "$dir")"
  target="$DEST/$name"
  if [ -L "$target" ] || [ ! -e "$target" ]; then
    ln -sfn "$dir" "$target"; n=$((n+1))
  else
    echo "!! $target exists and is not a symlink; left alone"
  fi
done < <(find "$BENCH/design" -maxdepth 3 -name SKILL.md | sort)

# Drop links whose source disappeared upstream
find "$DEST" -maxdepth 1 -type l ! -exec test -e {} \; -delete

echo ">> champ-skills design bench: $n skills linked into $DEST"
