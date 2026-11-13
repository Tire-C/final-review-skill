# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2] - 2026-11-13

### Changed

- Hardened `.github/workflows/ci.yml` with explicit `contents: read` permissions, `actions/checkout@v5`, and native PowerShell validation (`pwsh -NoProfile -File scripts/validate.ps1`) alongside `bash scripts/validate.sh`.
- Updated `README.md` version badge to `1.0.2` and aligned CI documentation with both validation scripts.

### Fixed

- `install.sh`: added `-h`/`--help` usage output, rejected extra arguments and unknown `-*` flags, validated `skills/final-review/SKILL.md` before creating destinations, added `--` option termination to `mkdir -p`, and copied `skills/final-review/.` so existing installations update without nested subdirectories.
- `install.ps1`: disabled positional parameter binding (`[CmdletBinding(PositionalBinding = $false)]`) so unexpected positional arguments fail cleanly, and checked `SKILL.md` with `-PathType Leaf`.
- `docs/installation.md`: updated manual copy commands on Unix and Windows to copy directory contents cleanly without nesting inside existing `final-review` targets.
- `scripts/validate.sh`: normalized CRLF line endings before YAML frontmatter checks and explicitly verified a closing `---` delimiter.
- `scripts/validate.ps1`: restored caller working directory via `Push-Location`/`Pop-Location`, guarded `SKILL.md` line-count bounds before indexing, and added `-Force` to `Get-ChildItem` scans so hidden files and dotfiles are checked for secrets and broken links.

## [1.0.1] - 2026-07-07

### Changed

- Expanded the README into a full product page: badges, table of contents, flow diagram, at-a-glance table, report contract, use cases, compatibility matrix, FAQ.

### Fixed

- Executable bit set on `install.sh` and `scripts/validate.sh`, so `./install.sh` works out of the box on a fresh Unix clone.

## [1.0.0] - 2026-07-07

### Added

- Initial public release of the Final Review skill (`skills/final-review/SKILL.md`).
- Eight-step review procedure with a stable seven-section report format and `PASS` / `PASS WITH RISKS` / `FAIL` verdicts.
- Installation scripts for Windows (`install.ps1`) and Unix/macOS/Linux (`install.sh`).
- Structure validation scripts (`scripts/validate.sh`, `scripts/validate.ps1`) and a CI workflow that runs them on every push and pull request.
- Documentation: installation, usage, customization, operating philosophy.
- One realistic example report per verdict in `examples/`.
