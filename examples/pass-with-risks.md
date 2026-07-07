# Example report — PASS WITH RISKS

**Prompt:** "Final review of the orders dashboard before we hand it to the client on Friday."
**Deliverable:** `orders-dashboard`, a React + Express web app. Client delivery, not a public release.

---

## Final Review

1. **What was reviewed** — Full repository at commit `8c04d7e`, as the client-delivery candidate. Spec: the six dashboard views listed in `docs/scope.md`.

2. **Files and structure** — Coherent monorepo (`client/`, `server/`, `docs/`). One leftover: `server/routes/reports.bak.js` (unused backup file, not imported anywhere).

3. **Matches the request/spec** — Yes. All six views implemented and reachable; export-to-CSV works on the three views where the spec requires it.

4. **Checks run**
   - `npm ci && npm run build` (client and server) — ok
   - `npm test` (server) — 28 passed
   - Client: **no test suite exists**
   - `npm run lint` — clean
   - Manual smoke test of the six views against the seeded database — ok

5. **Security & secrets** — `.env.example` only; the real `.env` is correctly gitignored. `npm audit`: one **high** advisory in a transitive dependency of the spreadsheet-export library, no fixed version released upstream yet. JWT secret is read from the environment, but tokens are issued without an expiry (`expiresIn` missing).

6. **Risks left**
   - No client-side tests: UI regressions will only be caught manually. Impact: medium, recurring.
   - Transitive dependency advisory with no upstream fix. Impact: low in this deployment (export input is server-generated, not user-supplied), but must be tracked.
   - JWT tokens never expire. Impact: medium — a leaked token stays valid forever.
   - `reports.bak.js` leftover. Impact: cosmetic.

7. **Fixes required before release** — None blocking for a client demo delivery. Recommended within the next iteration: set `expiresIn` on the JWT (one line), delete the `.bak` file, open a tracking issue for the dependency advisory.

**Verdict: PASS WITH RISKS**
