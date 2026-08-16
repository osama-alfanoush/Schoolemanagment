# Release v1.0.0-rc2 — release notes and database migration review

**Candidate commit:** `a799d4e` on `chore/production-hardening-2026-08`
**Tag:** `v1.0.0-rc2` (annotated, immutable)
**Prepared:** 2026-08-15
**Status:** **NOT APPROVED FOR GENERAL PRODUCTION** — see *Blocking conditions*.

This document is the release record for the general-production candidate. It
describes what the release contains, what the database will do when it is
applied, and what is still unproven. It is written for whoever signs off the
deployment, not only for whoever performs it.

---

## 1. Blocking conditions

Three of the seven preconditions for a general production release are not met.
None of them is a code defect; all three are unfinished verification or unmade
decisions.

| # | Precondition | State | Why it is not met |
|---|---|---|---|
| 1 | A controlled pilot completed successfully | **NOT MET** | Phase 6 ended `PILOT BLOCKED`. The pilot was rehearsed end-to-end against staging, and the rehearsal found four real deployment defects, all now fixed. It was never run with real users at a real school, so no evidence exists of the system under genuine use. |
| 2 | Peak expected load verified | **NOT MET** | 250 concurrent users pass comfortably (p95 622 ms against an 800 ms gate). 500 fail (p95 2.69 s). The ceiling is a property of the single-host test rig as much as of the application, and separating the load generator from the system under test is required before the number means anything. Phase 4 ended `BLOCKED`. |
| 6 | Business and privacy decisions have named owners | **NOT MET** | Ten production-blocking decisions remain open, including the retention schedule, erasure and legal hold, subject-access handling, and who is accountable for breach notification. `php artisan policy:status --stage=production` lists them and exits non-zero. |

The other four preconditions are met with executed evidence — see §6.

**What this means in practice:** the software is in good technical shape. What
is missing is proof that it survives contact with a real school, proof of its
ceiling under real load, and a set of decisions only the school can make. The
first two are work; the third is a conversation.

---

## 2. What this release contains

Consolidation of seven hardening phases, grouped by what an operator would
notice.

### Security and tenant isolation

- Every protected endpoint returned HTTP 500 instead of 401 for unauthenticated
  requests, because Laravel's guest redirect had nowhere to redirect to in an
  API-only application. Fixed at the framework boundary.
- 16 tenant-scoped tables had no index leading on `school_id`. All 99 tables
  carrying `school_id` are now indexed, verified by
  `php artisan tenancy:verify-indexes` — a check that runs, not a claim.
- Personal files moved out of public storage into `PrivateFileVault`: every read
  is authorised by school scope, then ownership, then role. Filenames are ULIDs
  and carry no personal data. SVG is deliberately not an accepted image type.
  31 tests, 74 assertions, including cross-school and IDOR attempts.
- Four high/critical dependency advisories resolved; `composer audit --no-dev`
  and `npm audit` are both clean.
- nginx replaces inherited `add_header` directives the moment a location
  declares one of its own, so uploaded files had been served with no security
  headers at all. Every location now restates them.

### Runtime and infrastructure

- `php artisan serve` replaced with php-fpm + nginx + supervisord;
  `PROCESS_ROLE` selects web, worker or scheduler from one image.
- PgBouncer in transaction pooling mode. Measured against direct connections:
  6.2x less database CPU, 75% more throughput, 29x better p95. Connection
  pressure was solved by pooling rather than by raising `max_connections`,
  which would have hidden the saturation instead of removing it.
- Migrations run with `--isolated` on a dedicated `pgsql_direct` connection, so
  two replicas starting together cannot race.
- The liveness probe no longer shares the API rate-limit zone. It previously
  throttled itself, and the orchestrator restarted healthy containers.
- Rate limits resized for a school behind one public IP. At the old values the
  sixth teacher to sign in during morning registration was rejected: 2 190 of
  2 857 requests refused at 25 users. Credential-stuffing defence is keyed by
  account, not address, so the edge limit could be relaxed without weakening it.

### Correctness and integrity

- `per_page` was uncapped on 13 controllers — a one-request denial of service.
  Now clamped to 100 in the base controller.
- Payment idempotency is a database guarantee (unique index on `reference`)
  rather than an application-level best effort.
- The audit-log cleaner refused to become a data-destruction tool on an
  unapproved default: it now deletes nothing unless a retention period has been
  set *and* explicitly approved.

### Observability

- Error reporting carries environment, release SHA and request ID. Telemetry is
  scrubbed before it leaves the process — 39 tests, 164 assertions, covering
  credentials, card numbers, tokens and pupil names.
- Seven monitor classes with alert routing. Phase 3 proved delivery by injecting
  real failures, not by inspecting configuration.

### Fixed during this release preparation

- **The backup skipped every personal file.** The uploads archive covered
  `storage/app/public` only, while `PrivateFileVault` writes to
  `storage/app/private/uploads`. A restore would have rebuilt a database whose
  file rows pointed at bytes that no longer existed, and nothing would have
  failed at restore time — the loss would have surfaced one pupil at a time.
  Fixed and verified by an executed restore drill (§4).
- **The repository failed its own secret scan.** The redaction tests contained
  literal credential-shaped fixtures. They were never real secrets, but the gate
  matches shape, not provenance. The fixtures are now assembled from fragments;
  an allow-list entry was rejected because it would have become a standing
  exemption that a genuine leak could later hide behind.

---

## 3. Database migration review

**38 migrations. Applied to a clean PostgreSQL 16 inside the production image,
in 6.8 s total.** Longest single migration: 2.0 s
(`2026_08_03_000002_enforce_school_scope_across_modules`); everything else is
under 600 ms.

Resulting schema: **118 tables, 381 indexes, 325 foreign keys, 851 check
constraints, 85 unique constraints.** 99 tables carry `school_id`.

### 3.1 Applicability

General production has never been deployed, so **all 38 migrations apply to an
empty database**. Nothing rewrites existing rows, because there are no existing
rows. This materially reduces the risk of the migration step itself. The dangers
below become relevant only if this release is applied to a populated database —
for example by promoting a pilot environment rather than deploying fresh.

### 3.2 The one migration that destroys data

`2026_06_11_000001_add_unique_payment_reference_index`

Before adding a unique index on `payments.reference`, it deduplicates existing
payments: for each duplicated reference it keeps the earliest row, reverses the
double-counted amount on the invoice, recomputes the invoice status, and
**permanently deletes** the extra payment rows.

- `down()` drops the index. **It does not restore the deleted payments.** This
  migration is not reversible in the way the others are.
- Against an empty database it is a no-op — measured at 11.76 ms, zero rows
  affected.
- **If it is ever applied to a database containing payments, take a backup first
  and confirm it restores** (§4). This is the single migration where rollback
  cannot undo the damage.

### 3.3 Migrations that rewrite columns

Two migrations call `->change()`:
`2026_08_03_000001_harden_school_scoped_hr_payroll` and
`2026_08_03_000002_enforce_school_scope_across_modules`. On PostgreSQL a type or
nullability change takes an `ACCESS EXCLUSIVE` lock and may rewrite the table.
Empty tables make this instant; on a populated database it is a brief outage on
the affected tables and should be scheduled accordingly.

### 3.4 Data backfills

Nine migrations backfill data in `up()`, the heaviest being `2026_08_03_000001`
with 46 `DB::table` operations. All populate newly added columns. Re-running is
not a concern in either case, since Laravel records which migrations have run.

### 3.5 Concurrent index creation

`2026_08_10_000001_add_missing_tenant_scoped_indexes` sets
`$withinTransaction = false` and issues three `CREATE INDEX CONCURRENTLY`
statements, so adding the tenant indexes does not lock writes on a live
database.

The consequence is worth stating: because it runs outside a transaction, a
failure part-way leaves some indexes created. Re-running is safe, but this is
the one migration where partial application is possible by design. It also
hashes long index names rather than letting PostgreSQL truncate them at 63
bytes, which would have silently collided two tables onto one identifier.

### 3.6 Reversibility

Every migration except §3.2 implements a `down()` that restores the prior schema.
`migrate:rollback --step=1` followed by `migrate` was executed against a clean
PostgreSQL 16 and completed cleanly.

**Rolling back schema is not the same as rolling back a release.** For the
deployment rollback procedure — which does not roll back migrations — see §5.

---

## 4. Final backup and verified restore

Executed 2026-08-15 against the release candidate, using
`deploy/backup-container.sh` as it ships.

| Step | Result |
|---|---|
| Backup taken (`pg_dump --format=custom`) | `school_release_20260814T234734Z.dump`, 561 677 bytes |
| Dump checksum | `sha256sum -c` **OK** |
| Uploads archive | `.uploads.tar.gz`, 6 641 bytes |
| Uploads checksum | `sha256sum -c` **OK** |
| Archive contents | 1 public file, **2 private files** — private coverage is the fix in §2 |
| Restore into a new database | `pg_restore` completed without error |
| Row counts, source vs restored | **identical across 119 tables**, 292 rows |
| Schema objects, source vs restored | tables 118=118, indexes 381=381, FKs 325=325, checks 851=851, uniques 85=85 |
| File restore | all 3 files byte-identical by sha256 |

**This is a restore that was executed, not a backup that was configured.**

Two limitations, stated plainly:

1. **There is no production data to back up yet**, because general production has
   never been deployed. This drill proves the *mechanism* against the release
   candidate's own schema and representative data. It does not prove a
   production restore, which cannot exist until production does.
2. **Backups are still local and unencrypted.** Encryption and off-host storage
   were decided on 2026-08-15 (decision register §2) but are not implemented. A
   backup sitting on the same host as the database it protects does not survive
   the failure most likely to destroy that host.

One operational note: the checksum files record absolute container paths, so
`sha256sum -c` must be run with `/backups` mounted the way the writer had it.
Verifying from the host with a different layout reports a false failure.

---

## 5. Rollback thresholds and responsible people

### 5.1 Trigger a rollback immediately if

| Condition | Threshold | Source |
|---|---|---|
| Health endpoint failing | `/api/healthz` non-200 for 3 consecutive checks | `MonitorOperations` |
| Error rate | >2% of requests returning 5xx over 5 minutes | `config/alerting.php` |
| Latency | p95 >2 s sustained over 10 minutes | `docs/capacity-and-performance.md` |
| Queue backlog | >1 000 pending, or any job failing repeatedly | `MonitorOperations` |
| Authentication | login success rate below 80% | `MonitorOperations` |
| Tenant isolation | **any** cross-school data exposure | zero tolerance — roll back first, diagnose after |
| Financial correctness | **any** duplicated or misapplied payment | zero tolerance |
| Data loss | any report of missing records or files | zero tolerance |

The three zero-tolerance rows are deliberately not expressed as rates. One
occurrence is the threshold.

### 5.2 Rollback procedure

Rehearsed in Phase 6: rolled back to `0d9bf32`, rolled forward to `66b2e24`,
both returning HTTP 200 with the correct release stamp.

```
APP_RELEASE=<previous-sha> ./deploy/update.sh
```

`update.sh` restarts nginx unconditionally — a conditional restart was one of the
four defects the pilot rehearsal exposed, leaving nginx holding stale upstreams —
and then polls `/api/healthz` up to 30 times, exiting non-zero if the service
does not come back.

**Rollback does not revert migrations.** The schema is forward-compatible with
the immediately preceding release. If a migration is itself the problem, restore
from backup (§4) instead — and note §3.2.

### 5.3 Responsible people

**Every name below is a placeholder. No real person is currently accountable for
any of these.** This is decision register §13, and it blocks production.

| Role | Config key | Placeholder | Owns during a rollback |
|---|---|---|---|
| Platform owner | `ALERT_OWNER_PLATFORM` | `PLACEHOLDER-platform-on-call` | Executes the rollback; owns runtime and deployment alerts |
| Data owner | `ALERT_OWNER_DATA` | `PLACEHOLDER-database-owner` | Decides restore-from-backup; owns restore integrity |
| Finance systems owner | `ALERT_OWNER_FINANCE` | `PLACEHOLDER-finance-systems-owner` | Judges financial-correctness triggers |
| Security owner | `ALERT_OWNER_SECURITY` | `PLACEHOLDER-security-owner` | Incident command for isolation or exposure triggers |
| Privacy officer | *(no alert route)* | **unassigned** | Breach notification — no route exists at all |
| School operations owner | *(no alert route)* | **unassigned** | Declares the incident; authorises the rollback |

An unnamed owner is a routing gap, not a silence: alerts still fire and still
land in the configured channel. But at 07:40 on a school morning, "the platform
on-call" is not a person who can be telephoned. **Naming these six people is the
single cheapest item on the critical path to production.**

---

## 6. Release gate evidence

All executed at the candidate commit. Nothing in this table is inferred from
configuration.

| Check | Command | Result |
|---|---|---|
| Backend style | `vendor/bin/pint --test` | PASS |
| Backend tests | `php artisan test` | **467 passed**, 1 459 assertions |
| PostgreSQL concurrency | `php artisan test --testsuite=Postgres` | 4 passed, 17 assertions |
| Migration qualification | `migrate` → `rollback --step=1` → `migrate` | clean on PostgreSQL 16 |
| Tenant indexes | `php artisan tenancy:verify-indexes` | 99 tables, all indexed |
| PHP dependencies | `composer audit --no-dev` | no advisories |
| JS dependencies | `npm audit` | 0 vulnerabilities |
| Frontend types | `npm run typecheck` | PASS |
| Frontend tests | `npm test -- --run` | 124 passed |
| Frontend build | `npm run build` | built in 27.70 s |
| End-to-end | `npm run test:e2e` | 7 passed |
| Secret scan | working tree + all 51 commits | clean |
| Image build | `Dockerfile.prod`, `Dockerfile.railway` | both build from a clean checkout |
| Backup and restore | executed drill | PASS — §4 |

Frontend lint reports 0 errors and 2 808 warnings. The warnings are pre-existing
and were left alone: a lint sweep across the whole frontend is a large diff with
no verification value at release time.

---

## 7. Supported operating envelope

Deploy to at most **250 concurrent users**, which is measured rather than assumed
(p95 622 ms, error rate 0%). 500 concurrent users is measured to fail.

Sizing is derived from measurement, not habit: `PM_MAX_CHILDREN=20` per replica,
with the PgBouncer client pool sized against it. Method and raw numbers in
`docs/capacity-and-performance.md`.

---

## 8. Known risks carried by this release

| Risk | Severity | Position |
|---|---|---|
| No real-world pilot evidence | **High** | Blocking. Rehearsal is not use. |
| Ceiling above 250 users unproven | **Medium** | Blocking for larger schools; acceptable below 250 with margin. |
| Backups unencrypted and on-host | **High** | Decided, not implemented. Must precede any real personal data. |
| No named accountable people | **High** | Blocking. Cheapest item to close. |
| Retention and erasure undecided | **High** | Blocking. The system currently keeps everything — a deliberate holding position, not a policy. |
| External providers unverified | **Medium** | Mail, payments and push are disabled and fail closed. Each needs live verification before enabling. |
| Expo advisories EX-2026-001 | **Low** | Exception **expired 2026-08-15**. Re-approve or remediate. |
