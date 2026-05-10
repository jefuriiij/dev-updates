#!/bin/bash
set -e

SKILL_URL="https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md"
MARKER_START="<!-- dev-updates:start -->"
MARKER_END="<!-- dev-updates:end -->"

echo "dev-updates installer"
echo "---------------------"

SKILL_CONTENT=$(curl -sL "$SKILL_URL")

install_claude() {
  local DIR="$HOME/.claude/skills/dev-updates"
  mkdir -p "$DIR"
  echo "$SKILL_CONTENT" > "$DIR/SKILL.md"
  echo "✓ Claude Code updated"
}

upsert_to_file() {
  local FILE="$1"
  local TOOL="$2"
  mkdir -p "$(dirname "$FILE")"
  touch "$FILE"

  if grep -q "$MARKER_START" "$FILE" 2>/dev/null; then
    awk "/$MARKER_START/{found=1} !found{print} /$MARKER_END/{found=0}" "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
  fi

  printf "\n%s\n%s\n%s\n" "$MARKER_START" "$SKILL_CONTENT" "$MARKER_END" >> "$FILE"
  echo "✓ $TOOL updated"
}

FOUND=0

if [ -d "$HOME/.claude" ]; then
  install_claude
  FOUND=1
fi

if [ -d "$HOME/.codex" ] || command -v codex &>/dev/null; then
  upsert_to_file "$HOME/.codex/instructions.md" "Codex CLI"
  FOUND=1
fi

if [ -d "$HOME/.gemini" ] || command -v gemini &>/dev/null; then
  upsert_to_file "$HOME/.gemini/GEMINI.md" "Gemini CLI"
  FOUND=1
fi

if [ "$FOUND" -eq 0 ]; then
  echo "No supported AI tools found (Claude Code, Codex CLI, or Gemini CLI)."
  echo "Install one first, then re-run this script."
  exit 1
fi

echo ""
echo "Done! Say \"what's the update?\" in your AI coding tool to try it."
