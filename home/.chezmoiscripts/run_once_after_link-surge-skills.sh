#!/bin/bash

SURGE_SKILLS="/Applications/Surge.app/Contents/Resources/Skills/surge"
TARGET="$HOME/.config/claude/skills/surge"

if [ ! -d "$SURGE_SKILLS" ]; then
  echo "Surge not found, skipping skills link"
  exit 0
fi

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SURGE_SKILLS" ]; then
  exit 0
fi

rm -rf "$TARGET"
mkdir -p "$(dirname "$TARGET")"
ln -s "$SURGE_SKILLS" "$TARGET"
