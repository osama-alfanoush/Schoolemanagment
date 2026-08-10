# Production runbook — School Management Suite

Scope: deploying the Laravel API and the React frontend, responding to
incidents, and rolling back. Companion documents:
`staging-and-restore-qualification.md` (restore drills),
`production-policy-owners.md` (named owners), `security-exceptions.md`
(accepted findings), `uptime-robot.md` (external liveness checks).

Every named role below is a **placeholder** until
`production-policy-owners.md` records a real person.

---

## 1. Architecture the runbook assumes

| Component | Role | Notes |
|---|---|---|
| nginx | Terminates the container's HTTP port and proxies to php-fpm | `nginx/prod.conf` (compose) or `docker/nginx-railway.conf.template` (single container). TLS terminates upstream. |
| php-fpm | The PHP runtime. **Never `php artisan serve`** | `PM_MAX_CHILDREN` bounds concurrent PHP requests per replica |
| queue worker | `queue:work` — notifications, mail, outbox | **Required.** Without it nothing queued is ever delivered |
| scheduler | `schedule:work` | **Required.** Drives contract checks, reminders, outbox, token pruning, audit retention |
| PgBouncer | Transaction-pooled connections in front of PostgreSQL | `deploy/pgbouncer/`. Application traffic only |
| PostgreSQL 16 | System of record | Reached directly only for migrations and maintenance |
| Redis 7 | Cache, sessions, queue, locks | `maxmemory-policy noeviction` so queued jobs are never evicted |
| S3-compatible object storage | Private documents + public uploads | Local disk is refused in production unless a durable volume is acknowledged |

### 1.1 Why php-fpm and not `artisan serve`

The Railway image previously served production traffic with PHP's built-in
development server. It is single-threaded per worker, has no request queueing,
no slow-client protection and no graceful reload, and both PHP and Laravel
document it as unsuitable for production. Both deployment paths now run the same
php-fpm runtime; the only difference is packaging.

### 1.2 Why PgBouncer, and why not just raise `max_connections`

php-fpm has no persistent connection pool: every request opens a PostgreSQL
connection and closes it, and a PostgreSQL backend is a forked OS process. Under
the 500-VU load run PostgreSQL consumed roughly 7.4 of 16 CPU cores while
serving only ~157 req/s of otherwise cheap queries (10-24 statements, 15-26 ms
of database time per request, 99.999% buffer cache hit ratio). That cost is
connection churn, not query work.

Raising `max_connections` is the wrong lever — it multiplies backend processes
and their memory and scheduler footprint. PgBouncer in transaction mode keeps a
small warm set of server connections and multiplexes every application
connection onto it.

Sizing: `PGB_MAX_CLIENT_CONN` must cover
`(web replicas x PM_MAX_CHILDREN) + queue workers + scheduler + headroom`.
`PGB_DEFAULT_POOL_SIZE` is how many real backends that collapses into and must
stay well below the server's `max_connections`.

Transaction pooling is safe here because nothing depends on session state
across statements: `migrate --isolated` locks through Redis rather than
PostgreSQL advisory locks, and migrations run on the `pgsql_direct` connection
which bypasses the pooler entirely.

### 1.3 One image, three services

Deploy the **same immutable image** three times and set `PROCESS_ROLE`:

| Service | `PROCESS_ROLE` | Config file | Restart policy | Health check |
|---|---|---|---|---|
| API | `web` | `railway.json` | `ON_FAILURE` | `/api/healthz` |
| Worker | `worker` | `railway.worker.json` | `ALWAYS` | none — it serves no HTTP |
| Scheduler | `scheduler` | `railway.scheduler.json` | `ALWAYS` | none |

Only the web role runs migrations, and it runs them under `--isolated` so a
scaled-out service or an overlapping redeploy applies them exactly once.

**Every role must share an identical `REDIS_PREFIX`.** It otherwise defaults to
a slug of `APP_NAME`; if the services' names differ at all, the worker polls a
queue nobody writes to. Nothing errors, nothing is marked failed — mail and
notifications simply stop. This was reproduced during Phase 1 verification.

### 1.4 File storage: what is public and what is not

Two disks, and the split is deliberate.

| Disk | Contents | Reachable how |
|---|---|---|
| `uploads` (public) | **School logo only.** Institutional branding, rendered by the login screen before anyone authenticates, identifies no person | Direct storage URL |
| `private_uploads` (private) | Profile photos, assignment submissions, teacher attachments, and any generated personal document | `GET /api/files/*` only, after authorization |

Nothing on the private disk has a storage URL. `visibility: private` means an S3
object carries no public ACL, so learning the key is not enough; the local
driver keeps files under `storage/app/private/uploads`, which nginx never maps.

Storage keys are `{schoolId}/{category}/{ULID}.{ext}` and are generated, never
derived from client input:

- no original filename — that is where personal data hides
  ("ahmed-al-fulani-medical.pdf");
- no database id — an incrementing id in a URL invites enumeration;
- the extension comes from the **detected** MIME type, so "photo.php" cannot
  become a `.php` object;
- SVG is refused everywhere, including for the logo: it is an XML document that
  can carry script, and a stored SVG served from an origin is stored XSS.

Every download is `Content-Disposition: attachment` with
`Content-Security-Policy: default-src 'none'; sandbox` and `nosniff`, so stored
bytes can never execute in the application's origin even if validation is one
day bypassed.

Authorization for `/api/files/*`:

| Category | Who may read it |
|---|---|
| Profile photo | The owner; an admin or HR member of the same school; a teacher who teaches that pupil; a parent of that pupil |
| Assignment attachment | Pupils in the class and their parents; the assigning teacher or a teacher of that class; admins |
| Submission | The submitting pupil and their parents; the assigning teacher or a teacher of that class; admins. **Not classmates** |

Two independent checks apply: the tenant global scope on the record, and a
re-check of the storage key's tenant prefix inside the vault. A row that somehow
carries another school's key — a pre-tenancy record, a bad import — still cannot
be read.

### 1.5 Failure behaviour, by design

| Condition | Behaviour |
|---|---|
| Redis unavailable | Requests that touch cache or the rate limiter return 500. The limiter **fails closed** — it cannot be disabled by knocking Redis out |
| Redis unavailable, worker | Worker exits non-zero so the platform restarts it, rather than idling silently |
| Redis unavailable, migrations | `migrate --isolated` refuses to run without its lock |
| Liveness probe | `/api/healthz` stays 200 while the process is alive. It deliberately does **not** flap on dependency loss — that is what the authenticated `/api/health` and `ops:smoke` are for |
| php-fpm or nginx dies | supervisord brings the container down so the platform replaces it, rather than serving 502s |
| SIGTERM | supervisord stops both children gracefully (verified: ~0.9 s, exit 0). The worker traps SIGTERM itself and finishes the job in flight (verified: ~0.55 s, exit 0) |

## 2. Deploy

### 2.1 Preconditions (all must hold)

1. CI is green on the exact commit being deployed.
2. A backup newer than the last write has been taken **and** a restore drill has
   passed within the retention window (§5).
3. `php artisan hr-payroll:school-scope-preflight` reports zero ambiguous rows.
4. The previous image SHA and frontend build are recorded for rollback.
5. Migrations in the release have been reviewed for destructive operations
   (column drops, type narrowing, non-concurrent index builds on large tables).

### 2.2 Platform deploy (GitHub Actions)

`Deploy API` (`.github/workflows/deploy-api.yml`), run manually with the
confirmation input. It refuses to proceed unless CI passed for the same commit,
builds an image tagged with the commit SHA only, runs `ops:preflight-env`, then
`migrate --force --isolated` exactly once, then promotes and verifies liveness.

### 2.3 Self-hosted deploy (docker compose)

```bash
cd laravel-api
cp .env.prod.example .env.prod            # fill in real values OUT of git
bash deploy/preflight.sh                  # blocks debug/HTTP/wildcard CORS/placeholders
docker compose --env-file .env.prod -f docker-compose.prod.yml config --quiet
docker compose --env-file .env.prod -f docker-compose.prod.yml build
bash deploy/first-run.sh                  # first deploy only
bash deploy/update.sh                     # subsequent deploys
```

Frontend:

```bash
cd school-web && npm ci && npm run build
```

### 2.4 Post-deploy verification (do not skip)

```bash
curl -fsS https://<api-host>/api/healthz                    # must be 200, fast
docker compose ... exec api1 php artisan ops:smoke --json   # all checks "ok"
docker compose ... exec api1 php artisan tenancy:verify-indexes
docker compose ... exec api1 php artisan queue:failed       # expect none new
```

Then sign in once per role on the real deployment and confirm the release stamp:

```bash
curl -s -H "Authorization: Bearer <admin token>" https://<api-host>/api/health | jq .release
```

`release` must equal the deployed commit SHA. `unknown` means the pipeline did
not stamp the build — treat as a failed deploy.

---

## 3. Rollback

**Decide fast.** If error rate or p95 breaches the alert thresholds in §6 for
more than 5 minutes after a deploy, roll back rather than debug forward.

### 3.1 Application-only rollback (no migration in the release)

1. Enable maintenance mode: `php artisan down --render="errors::503"`.
2. Redeploy the **previous image SHA** (never a moving tag) and the previous
   frontend build.
3. `php artisan up`.
4. Re-run §2.4 verification.

Expected duration: minutes. No data loss.

### 3.2 Release contained a migration

`migrate:rollback` is only safe when the migration is additive and the previous
code can run against the new schema. The migrations in this repository that add
`school_id` ownership columns are **not** safely reversible once multi-school
data exists: dropping the column destroys tenant ownership even though the rows
survive.

Decision rule:

| Situation | Action |
|---|---|
| Migration additive, previous code tolerates it | Roll back the app only (§3.1); leave the schema forward |
| Migration destructive or tenant-structural | Do **not** roll back the schema. Restore the synchronised database backup (§5.4) and redeploy the matching previous image |
| Bad data written by the new release | Fix forward (§3.3) |

### 3.3 Fix-forward for data

Never edit historical financial rows. Use the reversal paths the application
provides (`reverseJournalBatch`, `reverseReceipt`, `reverseAdjustment`,
`reverseRun`). Each writes an auditable compensating entry and is blocked inside
a `closed` or `audited` financial period — which is the intended behaviour, not
an obstacle to work around.

---

## 4. Incident response

### 4.1 Severity

| Sev | Definition | Response |
|---|---|---|
| 1 | Data exposed across schools, financial corruption, or total outage | Page owner immediately; freeze deploys; start incident log |
| 2 | A core workflow broken (login, attendance, invoicing, payroll) | Respond within 30 min in business hours |
| 3 | Degraded performance, one module impaired, backlog growing | Next business day |

### 4.2 First five minutes

1. `curl https://<api-host>/api/healthz` — is the service alive at all?
2. Authenticated `GET /api/health` — which dependency is `error`/`warning`?
3. `php artisan ops:smoke --json` — database, cache/lock, queue, both storages.
4. `php artisan queue:failed` — failed-job growth points at a bad release.
5. Take the **correlation id** from the user's report (`X-Request-Id`, returned
   on every response including errors) and grep the logs for it. Every line
   emitted during that request carries `request_id` and `release`.

### 4.3 Suspected cross-school data exposure (Sev 1)

1. Freeze deploys. Do not "fix and push".
2. Preserve evidence: copy the relevant `audit_logs` rows and application logs
   before any remediation.
3. Establish scope with the restore-drill assertions, which are safe read-only
   queries and can be run against production:
   `psql -f deploy/sql/restore-assertions.sql`.
4. If a leak is confirmed, revoke sessions for affected users
   (`php artisan sanctum:prune-expired --hours=0` is **not** sufficient — delete
   the affected users' tokens) and follow the notification duties recorded in
   `production-policy-owners.md`.

### 4.4 Queue backlog / dead letters

```bash
php artisan queue:failed                    # inspect
php artisan queue:retry <id>                # retry one after fixing the cause
php artisan outbox:work --limit=100         # drain the transactional outbox
php artisan outbox:retry <eventId>          # replay one dead-lettered event
```

Never `queue:flush` during an incident: it deletes evidence.

### 4.5 Scheduler stopped

Symptoms: no reminders, contract alerts or outbox delivery; `outbox_events`
pending count climbing. Confirm the scheduler process is running, then check its
log for the last `Running ['artisan' ...]` line.

---

## 5. Backup and restore

### 5.1 Schedule and retention

| Property | Value | Source |
|---|---|---|
| Frequency | Every `BACKUP_INTERVAL_SECONDS` (default 86 400 = daily) | `deploy/backup-container.sh` |
| Contents | PostgreSQL custom-format dump + SHA-256 + per-table count manifest + uploads archive | same |
| Retention | `BACKUP_RETENTION_DAYS` (default 14) | same |
| Location | `laravel-api/backups` volume | **Must also be copied off-host to encrypted, versioned storage** |
| RPO | Up to 24 h with daily dumps. For a lower RPO enable continuous archiving (WAL) or a managed provider's PITR | Business decision — see §8 |
| RTO target | `RESTORE_RTO_SECONDS` (default 7 200) | `.env.staging` |

Backups are **not** encrypted at rest by the script. The volume and any off-host
copy must provide encryption and access control. Restrict read access to the
backup location to the database owner role only — a dump is a full copy of every
student, staff and financial record.

### 5.2 Take a backup on demand

```bash
docker compose --env-file .env.prod -f docker-compose.prod.yml \
  --profile operations run --rm --entrypoint sh backup -c "/ops/backup-container.sh once"
```

### 5.3 Prove a restore (run at least monthly)

```powershell
./deploy/verify-restore.ps1              # newest backup, drops the temp DB after
./deploy/verify-restore.ps1 -KeepDatabase # keep it for further testing
```

The drill verifies the checksum, restores into a **separate empty** database,
compares every table count to the manifest, runs
`deploy/sql/restore-assertions.sql` (tenant ownership, cross-school joins,
double-entry balance, payment ceilings, payroll ownership, audit
attributability), confirms the application can read the schema, confirms
`migrate` is a no-op, verifies tenant indexes, and runs `ops:smoke`. Evidence is
written to `restore-evidence/`.

A backup that has never been restored is not a backup.

### 5.4 Restore into production (disaster)

1. Stop the web, worker and scheduler processes. Do not let writes continue.
2. Record the exact dump file and its SHA-256 in the incident log.
3. Restore into a **new** database, never over the live one:
   `pg_restore --exit-on-error --no-owner --no-privileges -d <new_db> <dump>`.
4. Run `deploy/sql/restore-assertions.sql` against it.
5. Point the application at the restored database, run
   `php artisan migrate --force --isolated`, then `ops:smoke`.
6. Restore the uploads archive to the object-storage bucket.
7. Bring workers back last, after confirming the queue is not replaying stale
   jobs from before the restore point.

---

## 6. Monitoring and alerts

### 6.1 External (uptime)

`GET /api/healthz` — public, constant JSON, deliberately exempt from the
per-IP `/api/` rate limit so a monitor is never throttled into a false alarm.
Configure per `uptime-robot.md`. Alert if two consecutive checks fail.

### 6.2 Internal (authenticated)

`GET /api/health` requires an admin token and reports database, Redis, storage,
cache, queue and environment. Never expose it publicly.

### 6.3 Alert thresholds and monitors

`php artisan ops:monitor` evaluates seven monitors every five minutes (see
`routes/console.php`) and dispatches on breach. Thresholds live in
`config/alerting.php` so they can be tuned without a deploy. Every monitor is
fail-safe: a monitor that cannot run reports **critical**, because "the monitor
is broken" and "the thing being monitored is broken" must not look the same.

| Monitor | Warning | Critical | Owner |
|---|---|---|---|
| `dependencies` | — | database, cache or private storage unreachable | platform |
| `queue` | 1 failed job, or 100 pending outbox | 10 failed jobs, or 500 pending outbox | platform |
| `scheduler` | no heartbeat for 5 min | no heartbeat for 15 min | platform |
| `database` | >70% of `max_connections` | >90% | data |
| `redis` | >70% of `maxmemory` | >90% (policy is `noeviction`, so writes start failing) | platform |
| `backup` | last success >26 h | >48 h, or never | data |
| `payments` | 1 webhook failure in an hour | 3 failures, or any stuck >15 min | finance |

Run it by hand during an incident:

```bash
php artisan ops:monitor --json            # all monitors, machine readable
php artisan ops:monitor --only=queue      # one monitor
php artisan ops:monitor --no-alert        # evaluate without paging anyone
```

Exit status is non-zero only on **critical**, so a warning does not fail a cron
wrapper or a deploy gate.

The scheduler heartbeat is written every minute by a scheduled closure. If the
scheduler dies, nothing else notices — reminders, contract checks and outbox
delivery simply stop — so this monitor is the only thing standing between that
and a parent complaint weeks later.

### 6.3.1 Alert delivery

Alerts go to, in order: the collected log stream (**always**, so a dead
monitoring tool cannot take the record of the incident with it), the webhook in
`ALERT_WEBHOOK_URL`, and the addresses in `ALERT_MAIL_TO` when mail is enabled.
Delivery failure is logged and never fatal.

Owners are placeholders until real rotas are recorded in
`production-policy-owners.md`. **Alerts fire regardless** — a placeholder is a
routing gap, not a silence.

### 6.4 What must never reach logs or an error reporter

Student personal data, names in message bodies, passwords, tokens, MFA recovery
codes, cookies, CSRF values, payment instrument data. `AuditLogger::redact()`
enforces this for the audit trail; keep any error-reporter integration to
`request_id`, `release`, user id, school id and exception class/stack only.

### 6.5 Error reporting

Backend (`App\Services\ErrorReporter`) and frontend
(`school-web/src/lib/errorReporting.ts`) are provider-agnostic and **off by
default**. Every event carries `environment`, `release` (the commit SHA) and
`request_id` — the same correlation id the API echoes in `X-Request-Id` — so a
support ticket quoting that id lands on the exact request, and a browser error
joins to the API error that caused it.

With no DSN configured the event still reaches the collected log stream, so
nothing is lost. To enable a provider: set `ERROR_REPORTING_ENABLED=true` and
`ERROR_REPORTING_DSN` (backend) and `VITE_ERROR_REPORTING_ENABLED` /
`VITE_ERROR_REPORTING_DSN` (frontend). The payload shape is Sentry-compatible.

Both sides scrub before sending, and both are built from an allow-list rather
than by serialising whatever is to hand: never the request body, never headers,
never cookies, identity by user id and role only — never a name or an email.

### 6.6 Integration switches

Every external provider is off until somebody has verified it end to end.

| Integration | Default | Fails | Why |
|---|---|---|---|
| `MAIL_ENABLED` | on | open | In-app notifications still work; a bounced message must not break a request |
| `PAYMENTS_ENABLED` | **off** | **closed** | A payment path that silently no-ops can record money that was never taken. Manual receipts work without it |
| `PUSH_ENABLED` | **off** | open | Push is an enhancement over in-app and email, never the only channel |
| `ERROR_REPORTING_ENABLED` | **off** | open | Sending telemetry to a third party is a data-protection decision |

`MAIL_ALLOWED_RECIPIENTS` is a comma-separated allow-list that prevents a pilot
deployment from mailing real families. Leave it empty in full production.

Enabled-but-unconfigured is **always** an error, never a silent skip: somebody
switched it on believing it worked. `php artisan ops:smoke` and
`ops:preflight-env` both report integration status without printing secrets.

## 7. Launch-day checklist

- [ ] Backup taken and a restore drill passed within the last 7 days
- [ ] `bash deploy/preflight.sh` (compose) or `ops:preflight-env` (platform) passes
- [ ] `hr-payroll:school-scope-preflight` reports zero ambiguous rows
- [ ] Web, worker and scheduler processes all running
- [ ] `/api/healthz` green from the external monitor
- [ ] Authenticated `/api/health` all-ok and `release` equals the deployed SHA
- [ ] `ops:smoke --json` all-ok
- [ ] One real login per role on the production deployment
- [ ] Payment webhook delivered end-to-end with a real provider signature
- [ ] Outbound mail delivered to a real inbox
- [ ] File upload and download verified against object storage
- [ ] Alerts firing to a channel someone is actually watching
- [ ] Previous image SHA and frontend build recorded for rollback
- [ ] Deploy freeze window agreed and communicated
- [ ] On-call owner named for the first 48 hours

---

## 8. Open business decisions

These are **not** engineering defaults to be invented. Each needs an owner and a
recorded decision in `production-policy-owners.md`:

- Recovery point objective. Daily dumps imply up to 24 h of loss; PITR costs more.
- Backup encryption and off-host destination, and who may read a dump.
- Retention periods for student records, audit logs, financial documents and
  backups, under the applicable education and privacy regulations.
- Whether the payroll rule "the creator of a run may not approve it" is the
  organisation's intended segregation of duty (it is currently enforced).
- Payroll cancellation semantics — only `reversed` exists today.
- Grading rules, attendance correction windows, and who may reissue a report card.
- Behaviour for a user assigned to more than one school; the system currently
  fails closed and denies access.
- Breach notification duties and timelines.
