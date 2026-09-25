# Production readiness review — 2026-08-10

Supplements `PRODUCTION-READINESS.md` (2026-08-04). That report described the
state after the school-isolation hardening pass; this one records an independent
re-verification from a cold start, the defects it uncovered, and the fixes.

Repository state at review time: HEAD `fd192d89`, with 444 uncommitted working
tree changes. The knowledge graph in `graphify-out/` was regenerated from the
working tree, not from the commit.

---

## Verdict

**READY FOR CONTROLLED PILOT.** Not ready for unrestricted production.

Two mandatory gates do not pass and neither can be closed from this workstation:

1. **Peak load** — at 500 concurrent readers, p95 read latency is 2.15 s against
   a documented 800 ms threshold. Error rate was 0.00%, and no application
   defect was identified (per-request query counts are 10–24, DB time 15–26 ms,
   unloaded latency 50–67 ms). The rig was CPU-saturated: PostgreSQL alone
   consumed ~7.4 of 16 cores while co-resident with the app, Redis, MinIO and
   the load generator. This must be re-measured on production-like, separated
   infrastructure before the threshold can be judged.
2. **External integrations** — SMTP, Stripe and FCM have never been exercised
   with real provider credentials. Mail is proven only through the `log`
   transport; payments only through the manual/receipt path.

---

## Defects found and fixed

Severity reflects production impact, not effort.

| # | Sev | Defect | Evidence | Fix |
|---|-----|--------|----------|-----|
| 1 | **High** | Every unauthenticated request that did not send `Accept: application/json` returned **HTTP 500** with a logged stack trace instead of 401, on **every** protected endpoint. Laravel 12's `withMiddleware()` installs a default guest redirect to `route('login')`, which this API-only app does not define, so `Authenticate` threw `RouteNotFoundException` before the JSON exception renderer ran. | Reproduced live: `GET /api/health` on staging returned 500. Reverting the fix turns all 6 new regression tests red. | `bootstrap/app.php`: `redirectGuestsTo(fn () => null)`. Verified live: 401 with a clean body. |
| 2 | **High** | Two `league/commonmark` advisories (CVE-2026-71488 quadratic-time DoS, high; CVE-2026-71478 link-filter bypass, medium) plus 2 further high advisories. | `composer audit` at baseline. | Upgraded to 2.9.1. `composer audit --no-dev` now clean. |
| 3 | **High** | Two high npm advisories (`js-yaml` quadratic CPU, `nanoid` infinite loop). | `npm audit` at baseline. | Lockfile updated; `npm audit` reports 0. |
| 4 | **High** | The public liveness probe `/api/healthz` shared the per-IP `/api/` rate-limit zone. Under load — or simply when a platform health checker, an uptime monitor and normal traffic share an egress IP — it returned 429 and an orchestrator would restart a healthy container. | Load run: `healthz 200` check failed 59% of the time at 5 VUs. | Dedicated unrated `location = /api/healthz` in `nginx/prod.conf` and `nginx/staging.conf`. Verified: 200/200 rapid requests succeed. |
| 5 | **Medium** | nginx replaces inherited `add_header` directives as soon as a location declares one of its own. `/storage/`, `/assets/` and `= /index.html` each declared a `Cache-Control` header, silently dropping **all** security headers — including X-Frame-Options and HSTS on the SPA shell, and nosniff on user uploads. | Config review; confirmed by nginx semantics. | Headers restated in each location; uploads additionally get a locked-down CSP with `sandbox` and `Cross-Origin-Resource-Policy`. |
| 6 | **Medium** | `APP_DEBUG=true` in production was only a health-check *warning*; nothing prevented stack traces, SQL and env dumps from being rendered. | Code review of `HealthController::checkEnvironment`. | `AppServiceProvider::register()` forces `app.debug` off in production and logs critical; `ops:preflight-env` fails the boot. 15 data-driven tests. |
| 7 | **Medium** | No environment validation on platform deployments. `deploy/preflight.sh` validates a `.env.prod` file for the compose path only; Railway/Fly inject variables at container start where nothing checked them. | `docker/railway-entrypoint.sh` review. | New `ops:preflight-env` command (APP_KEY strength, HTTPS APP_URL, secure cookies, SameSite, CORS shape, non-sqlite, lock-capable cache, uploads durability, Stripe webhook secret). Wired into the entrypoint; fails closed. |
| 8 | **Medium** | 16 of 99 tenant tables had **no index leading on `school_id`**, the predicate every global scope appends. Includes `class_rooms`, `student_enrollments`, `staff_attendance`, `gradebooks`, `academic_years`, `hr_requests`. Degrades to a full tenant-table scan once a second school exists. | Direct catalogue query against a migrated PostgreSQL 16 database. | Migration `2026_08_10_000001`, using `CREATE INDEX CONCURRENTLY` outside a transaction so it is safe on a populated table. New `tenancy:verify-indexes` command guards this in CI. Now 99/99. |
| 9 | **Medium** | The queue worker and the scheduler had no place to run in the Railway deployment. Queued mail, notifications, outbox delivery, contract-renewal checks, installment reminders, token pruning and audit retention would all silently never execute. | `docker/railway-entrypoint.sh` review. | `PROCESS_ROLE=web\|worker\|scheduler` in the entrypoint so one image deploys as three services; documented in the runbook and `.env.prod.example`. |
| 10 | **Medium** | `php artisan migrate --force` ran on **every** container start. Two replicas or an overlapping redeploy race the same migration set. | Same. | `migrate --force --isolated` (cache lock). `ops:preflight-env` rejects a lockless cache store so the lock cannot silently no-op. |
| 11 | **Medium** | Audit events were mirrored to the `daily` file channel by default. In a container with `LOG_CHANNEL=stderr` that writes to an ephemeral path no collector reads and a redeploy destroys. The authoritative `audit_logs` table was unaffected. | Staging: `storage/logs/` empty, no `Audit:` lines in the collected stream. | `config/audit.php` now defaults to the app's own `LOG_CHANNEL`. Verified live — audit lines now appear in the container log stream. |
| 12 | **Medium** | `X-Powered-By: PHP/8.2.33` disclosed the exact patch level. | `curl -I` against staging. | `expose_php=Off` (plus `display_errors=Off`) in both production images. Verified absent. |
| 13 | **Medium** | No request correlation. A user-reported error could not be tied to a log line, a tenant or a queued job. | Grep: no request-id concept existed. | `AssignRequestId` middleware, first in the API chain so even rate-limited and 401 responses carry one. Echoed as `X-Request-Id`, shared into log context with `release`. Hostile inbound values are rejected (log-injection defence). 5 tests. |
| 14 | **Medium** | Audit redaction did not cover MFA recovery codes, one-time codes, cookies or CSRF values. No call site logged them today, but nothing prevented it. | `AuditLogger::REDACTED_KEYS` review. | 12 key patterns added; test asserts each is redacted. |
| 15 | **Medium** | **CI did not exist.** `.github/workflows/` was absent from the working tree. Nothing gated a merge. | `ls .github` → no such directory. | `ci.yml` with six required jobs; `deploy-api.yml` with SHA-pinned images, CI-green precondition, preflight, and migrations run once. |
| 16 | **Medium** | The load scripts could not pass their own thresholds: they re-authenticated on every iteration against 6 shared accounts, colliding with the 8/min per-account login limit; they asserted 200 on the now admin-only `/api/health`; and they used the removed `accounting` role. | First k6 run. | Rewritten to authenticate once per account in `setup()`, use the public liveness probe, and exercise real per-role read paths. |
| 17 | **Low** | `deploy/verify-restore.ps1` and `deploy/staging.ps1` abort under Windows PowerShell 5.1 whenever native stderr is redirected (CI logs, transcripts): a harmless `NOTICE` from docker/psql becomes a terminating error. The documented restore drill could not complete non-interactively. | Reproduced. | Native calls now run with `ErrorActionPreference = 'Continue'` and are judged by exit code. |

Not changed, deliberately: the `uploads` disk keeps `public` visibility. Profile
photos and the school logo are served from unguessable random paths and are now
sandboxed by CSP. Making them private requires a signed-URL delivery path — a
design change beyond a hardening pass, recorded in §Risks.

---

## What was verified, and how

All commands were executed; results are the actual output.

### Backend

| Check | Command | Result |
|---|---|---|
| Dependencies from lockfile | `composer install --no-interaction --prefer-dist` | PASS |
| Formatting / static | `vendor/bin/pint --test` | PASS |
| Unit + feature | `php artisan test` | **PASS — 347 tests, 1094 assertions** (baseline was 314/1029; +33 new) |
| PostgreSQL concurrency | `php artisan test --configuration phpunit.postgres.xml` | PASS — 4 tests, 17 assertions |
| Migrate a clean PG 16 database | `php artisan migrate --force` | PASS |
| Rollback 1 step, re-apply | `migrate:rollback --step=1` → `migrate` | PASS |
| Migrate an already-populated staging database | `migrate --force` on the live staging DB | PASS (new index migration applied to populated data) |
| Tenant index invariant | `php artisan tenancy:verify-indexes` | PASS — 99/99 |
| Dependency audit | `composer audit --no-dev` | PASS — no advisories |

### Frontend

| Check | Command | Result |
|---|---|---|
| Dependencies from lockfile | `npm ci` | PASS |
| Lint | `npm run lint` | PASS — 0 errors, 2803 pre-existing `any` warnings |
| Types | `npm run typecheck` | PASS |
| Unit + integration | `npm test -- --run` | PASS — 26 files, 124 tests |
| Production build | `npm run build` | PASS |
| Critical flows | `npm run test:e2e` | PASS — 7/7 Playwright |
| Dependency audit | `npm audit` | PASS — 0 vulnerabilities |

### Staging (production-like: nginx, 2 php-fpm replicas, 2 queue workers, scheduler, PostgreSQL 16, Redis 7, MinIO)

| Check | Result |
|---|---|
| All 10 containers healthy | PASS |
| `/api/healthz` | PASS — 200 in 20 ms, body `{"status":"ok"}`, no operational detail |
| `/api/healthz` under burst | PASS — 200/200 rapid requests, no 429 |
| `/api/health` unauthenticated | PASS — 401 (was 500) |
| Security headers | PASS — nosniff, DENY, Referrer-Policy, Permissions-Policy, CSP, COOP, CORP |
| `X-Powered-By` | PASS — absent |
| `ops:smoke --json` | PASS — database, cache+lock, queue, private S3, public S3 all ok |
| `ops:qualify-integrations` | PASS — both buckets, queued mail delivered, in-app notification delivered |
| Queue workers | PASS — `App\Mail\NotificationEmail` processed; `queue:failed` empty |
| Scheduler | PASS — `notifications:process-scheduled` and `outbox:work` executing every minute |
| Correlation IDs | PASS — present on 200 and 401; well-formed inbound id preserved; audit line carries `request_id` + `release`, no credential material |

### Backup and restore — executed, not asserted

Source: staging PostgreSQL, 2 schools, 37 users, 18 invoices, 5 payments,
48 grades, 120 attendance records, 6 audit logs.

| Step | Result |
|---|---|
| Backup taken (`backup-container.sh once`) | PASS — `school_20260809T220237Z.dump` |
| SHA-256 verified | PASS — `8849d4b7…30532c` |
| Restored into a **separate empty** database | PASS — 6 s |
| Table counts vs source manifest | PASS — **119/119 tables identical** |
| Integrity assertions (new `deploy/sql/restore-assertions.sql`) | PASS — tenant ownership, cross-school payment/grade/attendance joins, orphaned memberships, parent-link boundaries, double-entry balance, payment ceilings, payroll ownership, audit attributability |
| Both tenants present after restore | PASS — school 1: 29 memberships/18 invoices/5 payments/48 grades/120 attendance; school 2: 8 memberships |
| Application reads restored schema | PASS — `migrate:status` |
| `migrate` on restored DB | PASS — "Nothing to migrate" (idempotent) |
| Tenant indexes on restored DB | PASS — 99/99 |
| `ops:smoke` against restored environment | PASS — all checks ok |
| **Total drill duration** | **73 s** against a 7200 s RTO |

Evidence: `laravel-api/restore-evidence/restore-20260809T220748Z.json`.

### Load — k6 against the staging stack

The per-IP nginx limiter is the correct production control but makes a
single-host generator measure the limiter rather than the application. A clearly
labelled, non-deployable `nginx/loadtest.conf` raises only the `/api/` zone so
the app tier can be measured. Both runs used pre-authenticated sessions.

| Profile | Requests | Throughput | Error rate | p95 | Verdict |
|---|---|---|---|---|---|
| Baseline — 50 VUs, 4.5 min | 20 994 | 73.9 req/s | **0.00%** (threshold <1%) | **81.6 ms** (threshold <500 ms); login p95 368 ms (<800); dashboard p95 92 ms (<400) | **PASS** |
| Peak — 500 VUs, 5.5 min | 51 192 | 156.8 req/s | **0.00%** (threshold <2%) | **2.15 s** (threshold <800 ms) | **FAIL** |

Peak diagnosis — CPU sampled during the run: `postgres` ~7.4 cores, `api1`
~3.7, `api2` ~3.7, of 16 total. The host was saturated with the database, cache,
object storage, application and load generator co-resident. Per-endpoint query
profiling found no N+1 hotspot:

| Endpoint | Queries | DB time |
|---|---|---|
| `/api/student/dashboard` | 10 | 20.3 ms |
| `/api/student/grades` | 12 | 15.5 ms |
| `/api/student/report-card` | 24 | 25.6 ms |
| `/api/student/attendance` | 12 | 14.6 ms |

Buffer cache hit ratio was 99.999% (129 M hits / 1 790 reads), so this is CPU,
not I/O. Before re-testing on real infrastructure, address:

- **No connection pooler.** php-fpm opens a new PostgreSQL backend per request;
  at ~157 req/s that is a large share of the observed database CPU. Add
  PgBouncer in transaction mode.
- `pm.max_children = 20` per replica (40 workers total) is low for 500
  concurrent users.
- `max_connections = 100` leaves no room to raise worker counts without a pooler.

### Security scans

| Scan | Result |
|---|---|
| Working-tree secret scan (AWS keys, Stripe live/test, webhook secrets, private keys, GitHub/Slack tokens) | PASS — none |
| Full git history (13 commits, all refs) | PASS — none; no `.env`, `.pem` or `.key` was ever committed |
| `.env*.example` files | PASS — placeholders only |
| `.gitignore` coverage | PASS — `.env`, `.env.prod`, `.env.staging` all ignored |

---

## Release gates

| Gate | Status | Evidence |
|---|---|---|
| Clean backend build | **PASS** | Composer install, Pint, production images build |
| Clean frontend production build | **PASS** | `npm run build` |
| All automated tests pass | **PASS** | 347 PHP + 4 PG concurrency + 124 Vitest + 7 Playwright |
| PG migrations on a clean database | **PASS** | Full run on empty PG 16 |
| PG migrations on a populated database | **PASS** | New index migration applied to live staging data |
| Cross-school isolation proven by tests | **PASS** | `SchoolWideIsolationTest`, `HrPayrollP0IsolationTest`, `Security/IdorTest`, `OriginalBypassRegressionTest`, plus restore-time SQL assertions |
| Auth, CSRF, MFA, authorization, session revocation | **PASS** | `Security/*` suites + new `ProductionHardeningTest` |
| No unresolved critical/high dependency or secret findings | **PASS** | `composer audit` clean, `npm audit` 0, history clean |
| Financial/academic workflows transactional and idempotent | **PASS** | PG concurrency suite: single grade CAS winner, single attendance row, overlap rejection, single active payroll record; webhook idempotency table with row locks |
| Queue workers and scheduled jobs work in staging | **PASS** | Mail processed, notifications delivered, scheduler firing, zero failed jobs |
| A backup has been restored successfully | **PASS** | 73 s drill, 119/119 tables, all integrity assertions |
| Operational smoke against the restored environment | **PASS** | `ops:smoke` all ok on the restored DB |
| Baseline load meets thresholds | **PASS** | 0.00% errors, p95 81.6 ms |
| Peak load meets thresholds | **FAIL** | p95 2.15 s vs 800 ms; host CPU-saturated; no application defect found |
| Production monitoring and alerts configured | **BLOCKED** | Thresholds, endpoints and runbook defined; wiring needs a real monitoring account |
| Deployment and rollback documented and tested where possible | **PASS** | `production-runbook.md`; restore path executed; platform promotion step needs wiring |
| External integrations (SMTP, Stripe, FCM) proven | **BLOCKED** | No provider credentials available |
| Remaining business/privacy/retention decisions listed and assigned | **PASS (listed)** / **BLOCKED (assignment)** | Runbook §8; owners still placeholders |

---

## Risks and open decisions

**Engineering**

1. **`php artisan serve` in production (Railway).** `Dockerfile.railway` serves
   traffic with PHP's built-in development server. It is not designed for
   production. The compose path uses php-fpm behind nginx and is preferred; if
   Railway remains the target, move to php-fpm/FrankenPHP before real load.
2. **No connection pooler** — see peak diagnosis.
3. **Ephemeral uploads on Railway.** `UPLOADS_DRIVER` must be `s3` in
   production; `ops:preflight-env` warns, it does not block, because a mounted
   persistent volume is also a valid answer.
4. **Public upload visibility.** Profile photos and the school logo are world-
   readable at unguessable URLs. Signed URLs would be stronger; that is a design
   change, not a hardening fix.
5. **`trustProxies` lists `*.fly.dev`** and RFC1918 ranges. Confirm it matches
   the actual edge before relying on `isSecure()` or client IPs.
6. **2803 ESLint `any` warnings.** Not build-breaking; concentrated in finance
   and warehouse pages. Real type debt.

**Business decisions — none of these may be invented by engineering.** Recorded
in `laravel-api/docs/production-runbook.md` §8 and still unassigned in
`docs/production-policy-owners.md`: recovery point objective; backup encryption,
destination and who may read a dump; retention periods for student, audit and
financial records; whether the payroll creator-cannot-approve rule is the
intended segregation of duty; payroll cancellation semantics (only `reversed`
exists); grading rules, attendance correction windows and report-card reissue
authority; behaviour for users assigned to more than one school (currently
fail-closed); breach notification duties.
