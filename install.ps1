#Requires -Version 5.1
<#
.SYNOPSIS
Installs the Final Review skill for Claude Code or any Agent Skills-compatible client.

.DESCRIPTION
Copies skills/final-review/ from this repository to the chosen skills directory.

.PARAMETER Target
personal (default) -> $HOME/.claude/skills/final-review
project            -> ./.claude/skills/final-review (relative to the current directory)

.PARAMETER Path
Custom destination directory (overrides -Target). Use for other Agent Skills clients.

.EXAMPLE
.\install.ps1
.\install.ps1 -Target project
.\install.ps1 -Path C:\my\agent\skills\final-review
#>
param(
    [ValidateSet('personal', 'project')]
    [string]$Target = 'personal',
    [string]$Path
)

$ErrorActionPreference = 'Stop'

$source = Join-Path $PSScriptRoot 'skills\final-review'
if (-not (Test-Path (Join-Path $source 'SKILL.md'))) {
    Write-Error "Source skill not found at '$source'. Run this script from the repository root."
}

if ($Path) {
    $destination = $Path
}
elseif ($Target -eq 'project') {
    $destination = Join-Path (Get-Location) '.claude\skills\final-review'
}
else {
    $destination = Join-Path $HOME '.claude\skills\final-review'
}

New-Item -ItemType Directory -Force -Path $destination | Out-Null
Copy-Item -Path (Join-Path $source '*') -Destination $destination -Recurse -Force

Write-Host "Final Review skill installed to: $destination"
Write-Host "Start a new agent session to pick up the skill."
