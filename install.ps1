$ErrorActionPreference = "Stop"

$BaseUrl = "https://raw.githubusercontent.com/jefuriiij/dev-updates/main"

Write-Host "dev-updates installer"
Write-Host "---------------------"

function Install-To {
  param($Dir, $Tool)
  New-Item -ItemType Directory -Force "$Dir\agents" | Out-Null
  irm "$BaseUrl/SKILL.md" -OutFile "$Dir\SKILL.md"
  irm "$BaseUrl/agents/openai.yaml" -OutFile "$Dir\agents\openai.yaml"
  Write-Host "✓ $Tool updated"
}

$found = $false

if (Test-Path "$env:USERPROFILE\.claude") {
  Install-To "$env:USERPROFILE\.claude\skills\dev-updates" "Claude Code"
  $found = $true
}

if ((Test-Path "$env:USERPROFILE\.agents\skills") -or (Test-Path "$env:USERPROFILE\.codex") -or (Get-Command codex -ErrorAction SilentlyContinue)) {
  Install-To "$env:USERPROFILE\.agents\skills\dev-updates" "Codex CLI / Gemini CLI"
  $found = $true
}

if (-not $found) {
  Write-Host "No supported AI tools found (Claude Code, Codex CLI, or Gemini CLI)."
  Write-Host "Install one first, then re-run this script."
  exit 1
}

Write-Host ""
Write-Host "Done! Say 'what's the update?' in your AI coding tool to try it."
