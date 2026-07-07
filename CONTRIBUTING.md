# Contributing

Thanks for considering a contribution to the Final Review skill.

## Ground rules

- Keep the skill **universal**: no company-, person-, or project-specific references.
- Keep it **practical and terse**: the skill is an operating procedure, not an essay.
- The output format and the three verdicts (`PASS` / `PASS WITH RISKS` / `FAIL`) are the stable public contract. Changing them requires a strong justification and a major version bump.

## How to contribute

1. Open an issue describing the problem or the proposal.
2. Fork the repository and create a branch.
3. Make the change and run the validation locally:
   - Unix/macOS/Linux: `bash scripts/validate.sh`
   - Windows: `pwsh -File scripts/validate.ps1`
4. Update `CHANGELOG.md` if the change is user-visible.
5. Open a pull request. CI must pass.

## What makes a good change

- New checks that catch real release blockers.
- Clearer wording that shortens the skill without losing checks.
- Fixes to the installation or validation scripts.
- Better examples or documentation.

## Versioning

This project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **Major** — changes to the report format, the verdicts, or the skill's core rules.
- **Minor** — new checks, new documentation, new tooling.
- **Patch** — fixes and wording improvements.
