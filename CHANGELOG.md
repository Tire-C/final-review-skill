# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
