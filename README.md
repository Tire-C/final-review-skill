# Final Review Skill

A strict, final-gate review skill for AI agents. Point it at a repository, app, tool, kit, documentation set, workflow, or release candidate and it returns a structured report that ends with one of three verdicts: **PASS**, **PASS WITH RISKS**, or **FAIL**.

Compatible with [Claude Code](https://claude.com/claude-code) and any client that supports the Agent Skills format (a `SKILL.md` file with YAML frontmatter).

## What it is

Final Review is the last gate before you call something *done*. It turns "looks good to me" into a repeatable procedure with a stable output format, executed by your AI agent acting as a strict technical supervisor. It reviews; it never modifies files unless you explicitly ask for fixes.

## When to use it

- Before tagging a release or publishing a package
- Before delivering a project, kit, or tool to someone else
- Before merging a large change or closing a milestone
- After an AI agent finishes a task and you want an independent final check
- Before archiving work as "complete"

## What it checks

| Area | Examples |
|------|----------|
| Structure & completeness | expected files present, no leftovers, no dead code |
| Coherence | code, config, and docs agree on names, versions, commands |
| Documented commands | install/build/run/test instructions actually work |
| Tests, build, lint | run what exists, flag what is missing |
| Security & secrets | hardcoded keys, tokens, credentials, risky patterns |
| Installation & usability | a newcomer can install and use it from the docs alone |
| Release readiness | versioning, changelog, license, blocking TODOs |

## Verdicts

| Verdict | Meaning |
|---------|---------|
| `PASS` | Ready to ship. No blocking issues, no unmitigated risks. |
| `PASS WITH RISKS` | Shippable, but named risks remain; each one is listed with its impact. |
| `FAIL` | Not shippable. At least one blocking problem, with the exact fixes required. |

## Quick install

From the repository root:

**Windows (PowerShell):**

```powershell
.\install.ps1                  # personal skill -> ~/.claude/skills/final-review
.\install.ps1 -Target project  # project skill  -> ./.claude/skills/final-review
```

**macOS / Linux:**

```sh
./install.sh            # personal skill -> ~/.claude/skills/final-review
./install.sh project    # project skill  -> ./.claude/skills/final-review
```

**Manual (any Agent Skills client):** copy `skills/final-review/` into the skills directory supported by your client.

Details and other clients: [docs/installation.md](docs/installation.md).

## Quick usage

With the skill installed, ask your agent for a final review:

> Run a final review of this repository before I tag v1.0.0.

In Claude Code you can also invoke it explicitly:

```
/final-review
```

The agent follows the skill's eight-step procedure and returns the fixed-format report. More patterns: [docs/usage.md](docs/usage.md).

## Example output

```
## Final Review

1. What was reviewed: csvlint v2.1.0 release candidate (full repository)
2. Files and structure: complete; src/, tests/, docs/ consistent with README
3. Matches the request/spec: yes
4. Checks run: pytest (41 passed), ruff (clean), pip install -e . (ok)
5. Security & secrets: no findings
6. Risks left: none
7. Fixes required before release: none

Verdict: PASS
```

Full, realistic reports for each verdict: [examples/pass.md](examples/pass.md), [examples/pass-with-risks.md](examples/pass-with-risks.md), [examples/fail.md](examples/fail.md).

## Repository structure

```
final-review-skill/
├── skills/final-review/SKILL.md   # the skill (this is what gets installed)
├── install.ps1 / install.sh       # one-command installation
├── scripts/                       # structure validation (also used by CI)
├── examples/                      # one realistic report per verdict
├── docs/                          # installation, usage, customization, philosophy
└── .github/workflows/ci.yml      # validates the skill on every push and PR
```

## Compatibility

- **Claude Code** — as a personal skill (`~/.claude/skills/`) or a project skill (`.claude/skills/`)
- **Any Agent Skills-compatible agent** — the skill is a single self-contained `SKILL.md`: no dependencies, no runtime, no network access required

## Security notes

- The skill is plain markdown: it executes nothing by itself.
- It instructs the agent to *review* — it never modifies files unless explicitly asked.
- The install and validation scripts only copy and read files; review them before running, as with any script.
- The skill's own checklist includes scanning the reviewed deliverable for committed secrets and API keys.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Please run `scripts/validate.sh` (or `scripts/validate.ps1`) before opening a PR — the same check runs in CI.

## License

[MIT](LICENSE)
