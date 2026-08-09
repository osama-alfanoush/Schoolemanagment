# Verification evidence

Machine-readable output from verification runs, copied here so it survives in
version control. `laravel-api/restore-evidence/` and `laravel-api/backups/` are
git-ignored: the dumps contain full copies of school, staff and financial data
and must never be committed.

| File | Produced by |
|---|---|
| `restore-*.json` | `deploy/verify-restore.ps1` — backup checksum, table-count comparison, integrity assertions, migrate idempotency, tenant-index check, `ops:smoke`, duration vs RTO |
| `../../tests/load/results/*.json` | `k6 run --summary-export` for the baseline and peak profiles |

A restore drill that is not recorded here has not been proven.
