# dev-updates

A Claude Code skill that detects uncommitted git changes and generates structured commit messages grouped by feature area.

## What it does

When triggered, the skill scans your working tree for uncommitted changes, groups them by feature or area, and produces:

- A plain-language summary of what changed and why it matters
- A one-line commit message ready to paste into `git commit -m "..."`
- A full detailed commit command with per-change bullet points using multiple `-m` flags

## Prerequisites

- [Claude Code](https://claude.ai/code) installed and running

## Installation

### macOS / Linux

```bash
mkdir -p ~/.claude/skills/dev-updates
curl -o ~/.claude/skills/dev-updates/SKILL.md \
  https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md
```

Or manually:
1. Create the folder `~/.claude/skills/dev-updates/`
2. Copy `SKILL.md` into it

### Windows

```powershell
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\skills\dev-updates"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md" `
  -OutFile "$env:USERPROFILE\.claude\skills\dev-updates\SKILL.md"
```

Or manually:
1. Create the folder `%USERPROFILE%\.claude\skills\dev-updates\`
2. Copy `SKILL.md` into it

## Trigger phrases

Say any of these inside Claude Code to activate the skill:

- `what's the update?`
- `what changed?`
- `what have I done?`
- `summarize my changes`
- `what did I update?`

## How it works

1. **Finds your repo** — checks memory for a saved path, or asks you if not found
2. **Validates git** — confirms the directory is a git repository
3. **Collects changes** — runs `git status`, `git diff`, `git diff --cached`, and checks for untracked files
4. **Summarizes** — groups changes by feature or area and explains each in plain language
5. **Generates commit messages** — produces both a one-liner and a detailed multi-line command

## Output format

**Summary block:**
```
[Feature/area name]
- What changed and why it matters
- Files involved
```

**One-line commit message:**
```
feat(scope): change one, change two, change three
```

**Detailed commit command** (copy-paste ready):
```
git commit -m "feat(scope): short summary" -m "- Change one detail" -m "- Change two detail"
```

**Example:**
```
git commit -m "feat(notes): add heatmap, toggle pill, ZentraToggle, heatmap_calendar dep" \
  -m "- Add 30-day activity heatmap to home screen to track writing streaks" \
  -m "- Replace flat layout with animated toggle pill + swipe gesture for cleaner navigation" \
  -m "- Add activityDataProvider to compute daily note activity from timestamps" \
  -m "- Replace Flutter Switch with custom ZentraToggle matching design system" \
  -m "- Add flutter_heatmap_calendar dependency"
```

## License

MIT
