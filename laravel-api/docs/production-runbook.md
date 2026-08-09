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
| nginx | TLS termination is upstream; nginx serves the SPA and proxies `/api/` to php-fpm | `nginx/prod.conf` |
| api1, api2 | php-fpm application replicas | `Dockerfile.prod` |
| queue worker | `queue:work` — notifications, mail, outbox | **Required.** Without it, nothing queued is ever delivered |
| scheduler | `schedule:work` / `schedule:run` every minute | **Required.** Drives contract checks, reminders, outbox, token pruning, audit retention |
| PostgreSQL 16 | System of record | `max_connections` default 100 |
| Redis 7 | Cache, sessions, queue, locks | `maxmemory-policy noeviction` so queued jobs are never evicted |
| S3-compatible object storage | Private documents + public uploads | Local disk must not be used in production |

On a platform that runs one process per service (Railway, Fly, Render), deploy
the **same image three times** and set `PROCESS_ROLE`:

```
PROCESS_ROLE=web        # default; runs migrations then serves HTTP
PROCESS_ROLE=worker     # queue:work
PROCESS_ROLE=scheduler  # schedule:work
```

A deployment with only the `web` service is incomplete: reminders, contract
alerts, outbox delivery and queued mail will silently never run.

---

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

### 6.3 Alert thresholds

| Signal | Warning | Critical |
|---|---|---|
| Liveness failures | 1 check | 2 consecutive checks |
| API 5xx rate | > 0.5% over 5 min | > 2% over 5 min |
| API read p95 | > 750 ms over 10 min | > 1.5 s over 10 min |
| Critical write p95 | > 1.5 s over 10 min | > 3 s over 10 min |
| Failed jobs | any new | > 10 in 15 min, or sustained growth |
| Outbox pending | > 100 for 15 min | > 500, or growing for 30 min |
| Scheduler | no run in 5 min | no run in 15 min |
| PostgreSQL connections | > 70% of `max_connections` | > 90% |
| Redis memory | > 70% of `maxmemory` | > 90% (`noeviction` ⇒ writes start failing) |
| Disk / object storage | > 75% | > 90% |
| Backup | no success in 26 h | no success in 48 h, or checksum mismatch |
| Restore drill | none in 30 days | none in 45 days |
| Payment webhooks | any `failed` row in `payment_webhook_events` | > 3 in 1 h |
| Release stamp | `/api/health` reports `release: unknown` | — |

### 6.4 What must never reach logs or an error reporter

Student personal data, names in message bodies, passwords, tokens, MFA recovery
codes, cookies, CSRF values, payment instrument data. `AuditLogger::redact()`
enforces this for the audit trail; keep any error-reporter integration to
`request_id`, `release`, user id, school id and exception class/stack only.

### 6.5 Error reporting

`APP_RELEASE` is stamped at build time and attached to every log line alongside
`request_id`. To add Sentry (or equivalent): install the SDK, set `SENTRY_DSN`
as a platform secret, set `release` to `config('app.release')`, and enable the
default PII scrubbing **plus** an explicit deny-list matching §6.4. No DSN is
committed to this repository.

---

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
