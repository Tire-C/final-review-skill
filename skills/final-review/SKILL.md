---
name: final-review
description: Use for a final, release-gate review of a repository, project, app, tool, kit, documentation set, workflow, release candidate, or any deliverable before it is considered done or shipped. Checks structure, completeness, coherence, documentation, commands, tests, security, secrets, installation, usability, and release readiness, then returns a fixed-format report with a clear verdict - PASS, PASS WITH RISKS, or FAIL. Trigger on requests like "final review", "pre-release check", "is this ready to ship", or "review before delivery".
license: MIT
---

# Final Review

Review the deliverable like a strict technical supervisor signing off a release. Be practical and specific. Do not philosophize. Do not modify any files unless explicitly asked to fix something.

## Scope

Works on any deliverable: code repositories, applications, CLI tools, libraries, kits and templates, documentation sets, automation workflows, release candidates, or individual changes (diffs and pull requests).

## Procedure

Follow these steps in order. Skip a step only if it does not apply, and say so in the report.

1. **Define the deliverable.** Identify what is being reviewed (repo, diff, app, docs, kit) and what "done" means for it. If reviewing a change, inspect the git diff and the list of modified, added, and removed files.
2. **Structure and completeness.** Check the file tree: expected files present (README, LICENSE, manifests, entry points, configs), nothing missing, no leftovers (temp files, build artifacts, dead code, unused dependencies, commented-out blocks).
3. **Coherence.** Verify that code, configuration, and documentation agree with each other: names, versions, paths, commands, and described behavior must match reality.
4. **Documented commands.** Every command in the README and docs (install, build, run, test) must work. Run them when possible; otherwise verify them statically against the project.
5. **Tests, build, lint.** Run the available test, build, lint, and validation steps and record the exact results. If none exist, flag their absence as a finding.
6. **Security and secrets.** Scan for hardcoded credentials, API keys, tokens, private URLs and paths, personal data, and risky patterns (unpinned remote scripts, overly broad permissions, injection-prone constructs). Nothing secret may ship.
7. **Installation and usability.** Confirm a newcomer can install and use the deliverable by following the documentation alone. Verify entry points and the quick-start path.
8. **Release readiness.** Check versioning, changelog, licensing, and any residual TODO/FIXME or open question that blocks release.

## Output format

Always return the report in this exact structure:

```
## Final Review

1. What was reviewed / what changed
2. Files and structure
3. Matches the request/spec: yes/no + gaps
4. Checks run (tests, build, lint, commands) + results
5. Security & secrets findings
6. Risks left
7. Fixes required before release

Verdict: PASS | PASS WITH RISKS | FAIL
```

## Verdicts

- **PASS** — ready to ship. No blocking issues, no unmitigated risks.
- **PASS WITH RISKS** — shippable, but named risks remain. List every risk with its concrete impact; the owner decides whether to accept them.
- **FAIL** — not shippable. At least one blocking problem (broken command, missing critical file, exposed secret, failing test, docs that contradict the code). List exactly what must be fixed, in priority order.

## Rules

- Do not modify files unless explicitly requested. Reviewing and fixing are separate jobs.
- Judge only against evidence: files, diffs, command output. No assumptions, no benefit of the doubt.
- Prefer a short, hard finding over a long, soft one.
- Every claim in the report must be verifiable from the deliverable itself.
- Missing information (no tests, no docs) is a finding to report, never a reason to stop the review.
