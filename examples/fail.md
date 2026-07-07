# Example report — FAIL

**Prompt:** "Final review of the starter kit repo — I want to publish it today."
**Deliverable:** `api-starter-kit`, a template repository meant to be cloned by other developers.

---

## Final Review

1. **What was reviewed** — Full repository at commit `41b2e90`, as a public template release candidate.

2. **Files and structure** — `template/`, `scripts/`, `README.md` present. **Missing:** `LICENSE` (the README claims MIT, but no license file exists). `docs/getting-started.md` is referenced from the README but does not exist.

3. **Matches the request/spec** — Partially. The kit scaffolds a working API, but the "one-command setup" promised in the README is broken (see below).

4. **Checks run**
   - `./scripts/setup.sh` — **fails at line 23**: copies `config/default.yaml`, which was renamed to `config/base.yaml` two commits ago
   - `npm test` inside `template/` — 12 passed
   - README quick start followed verbatim on a clean clone — **blocked** by the setup failure

5. **Security & secrets** — **Blocking:** `template/.env` is committed and contains a real-looking payment-provider live secret key and a database connection string with password. Even if the key has already been revoked, a template repository must never ship a populated `.env`.

6. **Risks left** — Not applicable until the blockers are fixed.

7. **Fixes required before release**
   1. Remove `template/.env` from the repository **and from git history**; revoke the exposed key and rotate the database password; commit a `.env.example` instead.
   2. Fix `scripts/setup.sh` line 23 (`default.yaml` → `base.yaml`) and re-test the quick start on a clean clone.
   3. Add the `LICENSE` file (MIT, per the README's claim).
   4. Add `docs/getting-started.md` or remove the dangling README link.

**Verdict: FAIL**
