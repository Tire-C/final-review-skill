# Usage

## Invoking the skill

Two ways:

1. **By intent** — ask for a final check in natural language; the agent selects the skill from its description:
   - "Run a final review of this repository before I tag v2.0.0."
   - "Final review of the docs/ folder — is it ready to publish?"
   - "I think this feature is done. Give me the release verdict."
2. **Explicitly** — in Claude Code, type `/final-review` (optionally followed by what to review).

## Choosing the scope

Tell the agent exactly what "the deliverable" is; the report is only as sharp as the scope:

- a whole repository — "this repo, as a release candidate"
- a change — "the current diff against main"
- a subset — "only the installer and the docs"
- a non-code deliverable — "this documentation kit"

## What to expect

The agent works through the eight steps in [SKILL.md](../skills/final-review/SKILL.md) — scope, structure, coherence, commands, tests/build/lint, security/secrets, installation/usability, release readiness — and returns the seven-section report ending with a verdict.

Two properties are guaranteed by the skill:

- **No modifications.** The review never edits files. If you want fixes, ask for them after reading the report.
- **Stable format.** The report always has the same seven sections and one of three verdicts, so you can compare reviews over time or parse them in automation.

## Acting on the verdict

- `PASS` — ship it.
- `PASS WITH RISKS` — read section 6, decide which risks you accept, fix or document the rest.
- `FAIL` — section 7 is your work list. Fix, then run the review again.

## Tips

- Run it **after** your own tests pass, not instead of them.
- For large repositories, tell the agent what matters most ("focus on the public API and the install path").
- Chain it: let one agent session do the work, then let a **fresh** session run the final review — a reviewer without the builder's assumptions is stricter.
