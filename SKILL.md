---
name: dev-updates
description: Detect and summarize uncommitted git changes grouped by feature area, then generate a structured commit message. Use when the user says "what's the update?", "what changed?", "summarize my changes", "what have I done?", or "what did I update?".
user-invocable: true
argument-hint: "[repo path]"
---

# dev-updates

Detect and summarize uncommitted working tree changes in a git repository. Use this to generate feature update notes and commit messages.

## Trigger phrases
Activate when the user says things like:
- "what's the update?"
- "what changed?"
- "what have I done?"
- "summarize my changes"
- "what did I update?"

## Steps

### 1. Find the repo path
- Check memory for a saved repo path for the current project
- If not in memory, ask: "Which project directory should I check for changes?"
- Save the path to memory for future use

### 2. Get the changes
Run these commands:
```
git -C "<repo_path>" status --short
git -C "<repo_path>" diff --stat
git -C "<repo_path>" diff
git -C "<repo_path>" diff --cached --stat
git -C "<repo_path>" diff --cached
git -C "<repo_path>" ls-files --others --exclude-standard
```
If `git status --short` fails with an error → show the **No git repo** response below and stop.

### 3. Check if anything changed
If `git status --short` succeeds but is empty → respond: "Working tree is clean — nothing to commit."

### 4. Summarize and present
- Group changes by feature or area (not just by file)
- Explain in plain language what each change does
- List new files, modified files, and deleted files separately
- End with a suggested commit message

## No git repo response
If git is not initialized, respond with:

```
⚠️ This project doesn't have git initialized yet.

To start tracking changes, run these 3 commands in your project folder:

  1. git init
  2. git add .
  3. git commit -m "initial"

Once done, ask again and I'll detect your changes.
```

## Output format

**[Feature/area name]**
- What changed and why it matters (plain language)
- Files involved

**Suggested commit message:**
One single line, suitable for pasting directly into `git commit -m "..."`:
```
<type>(<optional scope>): <concise summary of all key changes, comma-separated>
```

Rules:
- Must be one line — no newlines
- Use commas to separate multiple changes
- Keep it under ~72 characters if possible, but don't omit important changes
- Prefer clarity over brevity — don't cut details that matter

Example:
```
feat(notes): add heatmap, notebooks/notes toggle pill, ZentraToggle widget, heatmap_calendar dep
```

**Detailed commit command** (copy-paste the whole thing and run it directly):
```
git commit -m "<type>(<optional scope>): <short summary>" -m "- <change 1>" -m "- <change 2>" -m "- <change 3>"
```

Rules:
- First `-m` = the one-liner summary (same as above)
- Each additional `-m` = one logical change, starting with `- `
- Each bullet covers one logical change — what it is and why it matters
- Keep bullets concise but meaningful, not just file names
- The whole thing must be one single runnable command — no line breaks

Example:
```
git commit -m "feat(notes): add heatmap, toggle pill, ZentraToggle, heatmap_calendar dep" -m "- Add 30-day activity heatmap to home screen to track writing streaks" -m "- Replace flat layout with animated toggle pill + swipe gesture for cleaner navigation" -m "- Add activityDataProvider to compute daily note activity from timestamps" -m "- Replace Flutter Switch with custom ZentraToggle matching Zentra design system" -m "- Add flutter_heatmap_calendar dependency"
```
