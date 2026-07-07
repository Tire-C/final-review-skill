# Customization

`SKILL.md` is plain markdown — adapt it by editing your installed copy, or fork this repository and keep your variant under version control.

## Safe to change

- **Add checks** — append domain-specific steps to the procedure: "verify database migrations are reversible", "check accessibility of UI changes", licensing audits, compliance checks.
- **Tighten verdict rules** — e.g. "missing tests is always FAIL, never PASS WITH RISKS" for projects where that is policy.
- **Report language** — the report *structure* must stay, but you can instruct the agent to write the content in your language.
- **Project defaults** — in a project-level install, add the exact build/test commands of that project so the agent runs the right ones without guessing.

## Keep stable (the public contract)

- `name: final-review` in the frontmatter (rename it only if you also rename the directory).
- The seven-section report and the three verdicts `PASS`, `PASS WITH RISKS`, `FAIL`. Habits and automation build on this format; changing it silently defeats the purpose of a fixed gate.
- The "do not modify files" rule. A reviewer that edits what it reviews is not a reviewer.

## Per-project vs personal variants

- Keep the generic skill as a **personal** skill.
- Put stricter or domain-specific variants in each project's `.claude/skills/final-review/` — project skills apply inside that project and travel with the repository to your collaborators.

## Validating your changes

After editing, run the repository validation to make sure the frontmatter is still well-formed:

```sh
bash scripts/validate.sh
```

```powershell
pwsh -File scripts/validate.ps1
```
