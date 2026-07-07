# Operating philosophy

Five principles, kept short on purpose.

**1. A review is a gate, not a conversation.**
Final Review runs once, at the end, and produces a verdict. It is not pair programming, not continuous feedback, not a style discussion. If the deliverable is not at the gate yet, don't run it yet.

**2. Evidence only.**
Every finding must be traceable to a file, a diff, or a command output. "This looks fragile" is not a finding; "install.sh line 12 references a file that does not exist" is.

**3. Short and hard beats long and soft.**
Ten vague observations help less than three precise blockers. The report format is fixed and terse so the verdict — not the prose — carries the weight.

**4. The reviewer does not touch the work.**
Reviewing and fixing are different jobs. The skill never modifies files; fixes happen after the report, on request, and can then be re-reviewed.

**5. Risks are named or they don't exist.**
`PASS WITH RISKS` is not a polite `FAIL` and not a lazy `PASS`. Every accepted risk is listed with its concrete impact, so the decision to ship is informed and owned by a human.
