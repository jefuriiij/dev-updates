# dev-updates

Detects uncommitted git changes and generates structured commit messages grouped by feature area. Works with Claude Code, Codex CLI, and Gemini CLI.

## What it does

When triggered, it scans your working tree for uncommitted changes, groups them by feature or area, and produces:

- A plain-language summary of what changed and why it matters
- A one-line commit message ready to paste into `git commit -m "..."`
- A full detailed commit command with per-change bullet points using multiple `-m` flags

## Installation

### Claude Code

**macOS / Linux**
```bash
mkdir -p ~/.claude/skills/dev-updates && curl -sLo ~/.claude/skills/dev-updates/SKILL.md https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md
```

**Windows (PowerShell)**
```powershell
mkdir -Force "$env:USERPROFILE\.claude\skills\dev-updates"
irm https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md -OutFile "$env:USERPROFILE\.claude\skills\dev-updates\SKILL.md"
```

---

### Codex CLI

Appends the skill to your global Codex instructions so it's always available.

**macOS / Linux**
```bash
curl -sL https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md >> ~/.codex/instructions.md
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md >> "$env:USERPROFILE\.codex\instructions.md"
```

---

### Gemini CLI

Appends the skill to your global Gemini instructions so it's always available.

**macOS / Linux**
```bash
mkdir -p ~/.gemini && curl -sL https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md >> ~/.gemini/GEMINI.md
```

**Windows (PowerShell)**
```powershell
mkdir -Force "$env:USERPROFILE\.gemini"
irm https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md >> "$env:USERPROFILE\.gemini\GEMINI.md"
```

---

## Trigger phrases

Say any of these to activate:

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
git commit -m "feat(landing): add hero section, dark mode toggle, pricing cards, mobile nav" -m "- Add animated hero section with headline, subtext, and CTA button" -m "- Add dark mode toggle with smooth transition and localStorage persistence" -m "- Add responsive pricing cards with highlighted recommended tier" -m "- Fix mobile nav collapsing and add hamburger menu with slide-down animation"
```

## License

MIT
