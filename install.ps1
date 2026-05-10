$ErrorActionPreference = "Stop"

$SkillUrl = "https://raw.githubusercontent.com/jefuriiij/dev-updates/main/SKILL.md"
$MarkerStart = "<!-- dev-updates:start -->"
$MarkerEnd = "<!-- dev-updates:end -->"

Write-Host "dev-updates installer"
Write-Host "---------------------"

$SkillContent = (Invoke-RestMethod -Uri $SkillUrl)

function Install-Claude {
  $dir = "$env:USERPROFILE\.claude\skills\dev-updates"
  New-Item -ItemType Directory -Force $dir | Out-Null
  Set-Content "$dir\SKILL.md" $SkillContent -Encoding utf8
  Write-Host "✓ Claude Code updated"
}

function Upsert-ToFile {
  param($File, $Tool)
  New-Item -ItemType Directory -Force (Split-Path $File) | Out-Null
  if (-not (Test-Path $File)) { New-Item -ItemType File -Force $File | Out-Null }

  $content = Get-Content $File -Raw -ErrorAction SilentlyContinue
  if ($content -and $content.Contains($MarkerStart)) {
    $escaped_start = [regex]::Escape($MarkerStart)
    $escaped_end = [regex]::Escape($MarkerEnd)
    $content = $content -replace "(?s)\r?\n?$escaped_start.*?$escaped_end\r?\n?", ""
    Set-Content $File $content -Encoding utf8
  }

  Add-Content $File "`n$MarkerStart`n$SkillContent`n$MarkerEnd" -Encoding utf8
  Write-Host "✓ $Tool updated"
}

$found = $false

if (Test-Path "$env:USERPROFILE\.claude") {
  Install-Claude
  $found = $true
}

if ((Test-Path "$env:USERPROFILE\.codex") -or (Get-Command codex -ErrorAction SilentlyContinue)) {
  Upsert-ToFile "$env:USERPROFILE\.codex\instructions.md" "Codex CLI"
  $found = $true
}

if ((Test-Path "$env:USERPROFILE\.gemini") -or (Get-Command gemini -ErrorAction SilentlyContinue)) {
  Upsert-ToFile "$env:USERPROFILE\.gemini\GEMINI.md" "Gemini CLI"
  $found = $true
}

if (-not $found) {
  Write-Host "No supported AI tools found (Claude Code, Codex CLI, or Gemini CLI)."
  Write-Host "Install one first, then re-run this script."
  exit 1
}

Write-Host ""
Write-Host "Done! Say 'what's the update?' in your AI coding tool to try it."
