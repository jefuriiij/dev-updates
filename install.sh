#!/bin/bash
set -e

BASE_URL="https://raw.githubusercontent.com/jefuriiij/dev-updates/main"

echo "dev-updates installer"
echo "---------------------"

install_to() {
  local DIR="$1"
  local TOOL="$2"
  mkdir -p "$DIR/agents"
  curl -sLo "$DIR/SKILL.md" "$BASE_URL/SKILL.md"
  curl -sLo "$DIR/agents/openai.yaml" "$BASE_URL/agents/openai.yaml"
  echo "✓ $TOOL updated"
}

FOUND=0

if [ -d "$HOME/.claude" ]; then
  install_to "$HOME/.claude/skills/dev-updates" "Claude Code"
  FOUND=1
fi

if [ -d "$HOME/.agents/skills" ] || [ -d "$HOME/.codex" ] || command -v codex &>/dev/null; then
  install_to "$HOME/.agents/skills/dev-updates" "Codex CLI / Gemini CLI"
  FOUND=1
fi

if [ "$FOUND" -eq 0 ]; then
  echo "No supported AI tools found (Claude Code, Codex CLI, or Gemini CLI)."
  echo "Install one first, then re-run this script."
  exit 1
fi

echo ""
echo "Done! Say \"what's the update?\" in your AI coding tool to try it."
