# dev-updates

Detects uncommitted git changes and generates structured commit messages grouped by feature area. Works with Claude Code, Codex CLI, and Gemini CLI.

## The problem

You've been coding for hours. You can pull up the diff anytime — that part's easy. But when your changes start stacking up, the *why* gets blurry fast.

Why did you add that function? What was that update fixing? How does this new piece connect to the rest of the code? You made those decisions in the moment, but by the time you're ready to commit, that context is already fading. The longer the session, the worse it gets.

Writing a proper commit message means reconstructing all of that — re-reading your own changes, re-tracing your own logic, and then summarizing it clearly. That takes time, and it's easy to just give up and write `"updates"` or `"fix stuff"` instead.

This skill was built to close that gap. It reads your actual diff, figures out what changed and why it matters, groups everything by feature, and generates a commit message that actually describes the work — so you don't have to.

## What it does

When triggered, it scans your working tree for uncommitted changes, groups them by feature or area, and produces:

- A plain-language summary of what changed and why it matters
- A one-line commit message ready to paste into `git commit -m "..."`
- A full detailed commit command with per-change bullet points using multiple `-m` flags

## Installation

Works with **Claude Code**, **Codex CLI**, and **Gemini CLI**. The script auto-detects which tools you have installed.

**macOS / Linux**
```bash
curl -sL https://raw.githubusercontent.com/jefuriiij/dev-updates/main/install.sh | bash
```

**Windows (PowerShell)**
```powershell
irm https://raw.githubusercontent.com/jefuriiij/dev-updates/main/install.ps1 | iex
```

Same command works for updating too — just re-run it anytime to get the latest version.

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
