#Requires -Version 5.1
# Validates the repository structure and the Final Review skill definition.
# Usage: pwsh -File scripts/validate.ps1   (or powershell -File scripts/validate.ps1)
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path -Parent $PSScriptRoot)

$script:Errors = 0
function Fail([string]$Message) { Write-Host "FAIL: $Message"; $script:Errors++ }
function Ok([string]$Message)   { Write-Host "ok:   $Message" }

Write-Host "== Required files =="
$required = @(
    'README.md', 'LICENSE', 'CHANGELOG.md', 'CONTRIBUTING.md', 'CODE_OF_CONDUCT.md', 'SECURITY.md',
    '.gitignore', 'install.sh', 'install.ps1', '.github/workflows/ci.yml',
    'skills/final-review/SKILL.md', 'scripts/validate.sh', 'scripts/validate.ps1'
)
foreach ($f in $required) {
    if (Test-Path $f -PathType Leaf) { Ok $f } else { Fail "missing required file: $f" }
}

Write-Host ""
Write-Host "== SKILL.md frontmatter =="
$skillPath = 'skills/final-review/SKILL.md'
if (Test-Path $skillPath) {
    $lines = @(Get-Content $skillPath)
    if ($lines[0] -eq '---') { Ok "frontmatter delimiter present" }
    else { Fail "SKILL.md must start with '---' YAML frontmatter" }

    $fmEnd = [Array]::IndexOf($lines, '---', 1)
    if ($fmEnd -lt 1) {
        Fail "frontmatter is not closed with '---'"
    }
    else {
        $fm = $lines[1..($fmEnd - 1)]
        if ($fm -contains 'name: final-review') { Ok "name: final-review" }
        else { Fail "frontmatter must declare 'name: final-review'" }

        $descLine = $fm | Where-Object { $_ -match '^description:\s*\S' } | Select-Object -First 1
        if ($descLine) {
            $desc = $descLine -replace '^description:\s*', ''
            Ok "description present ($($desc.Length) chars)"
            if ($desc.Length -gt 1024) { Fail "description exceeds 1024 characters" }
        }
        else {
            Fail "frontmatter must declare a non-empty single-line 'description'"
        }
    }
}

Write-Host ""
Write-Host "== Secret scan =="
$secretPattern = 'ghp_[A-Za-z0-9]{20,}|gho_[A-Za-z0-9]{20,}|ghu_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|BEGIN[A-Z ]*PRIVATE KEY'
$hits = Get-ChildItem -Recurse -File |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' } |
    Select-String -Pattern $secretPattern -AllMatches -ErrorAction SilentlyContinue
if ($hits) {
    $hits | ForEach-Object { Write-Host "  $($_.Path):$($_.LineNumber)" }
    Fail "potential secrets found"
}
else {
    Ok "no secret patterns detected"
}

Write-Host ""
Write-Host "== Relative markdown links =="
$broken = @()
Get-ChildItem -Recurse -Filter *.md -File |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' } |
    ForEach-Object {
        $mdFile = $_
        $content = Get-Content $mdFile.FullName -Raw
        foreach ($m in [regex]::Matches($content, '\]\(([^)]+)\)')) {
            $target = $m.Groups[1].Value
            if ($target -match '^(https?://|mailto:|#)') { continue }
            $clean = $target.Split('#')[0]
            if (-not $clean) { continue }
            $resolved = Join-Path $mdFile.DirectoryName $clean
            if (-not (Test-Path $resolved)) { $broken += "$($mdFile.FullName) -> $target" }
        }
    }
if ($broken.Count -gt 0) {
    $broken | ForEach-Object { Fail "broken relative link: $_" }
}
else {
    Ok "all relative markdown links resolve"
}

Write-Host ""
if ($script:Errors -gt 0) {
    Write-Host "Validation FAILED: $($script:Errors) error(s)."
    exit 1
}
Write-Host "Validation PASSED."
exit 0
