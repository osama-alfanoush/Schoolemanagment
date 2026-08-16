# Production deployment plan — awaiting approval

**Release:** `v1.0.0-rc3` (`git rev-parse v1.0.0-rc3^{commit}`)
**Status:** **NOT AUTHORISED.** No external deployment has been performed. This
document exists to be approved or rejected, not to be executed on sight.

Three preconditions are unmet (release notes §1). This plan is written so that
the work is ready the moment they close — not to suggest they can be skipped.

---

## 1. What must be true before this plan may run

| # | Gate | Current | Who closes it |
|---|---|---|---|
| 1 | A controlled pilot completed at a real school | **not met** | School operations owner |
| 2 | Peak load verified on separated infrastructure | **not met** — 250 users proven, 500 fails | Platform owner |
| 3 | Ten production-blocking decisions closed | **not met** | Privacy officer, finance owner, registrar, operations |
| 4 | Six accountable people named, replacing placeholders | **not met** | School operations owner |
| 5 | Backup encryption and off-host storage implemented | decided, **not implemented** | Platform owner |
| 6 | Error-rate and latency monitoring added | **not present** | Platform owner |

Gates 4–6 are not formally preconditions, but deploying without them means an
incident has no owner, a host failure destroys the only backup, and the two
likeliest rollback triggers are invisible.

---

## 2. Environment variables to set (names only — never values here)

Required by `deploy/preflight.sh`, which refuses to deploy if any is blank or
wrong:

```
APP_ENV=production          APP_DEBUG=false          APP_KEY
APP_URL                     APP_RELEASE              (commit SHA)
DB_HOST DB_PORT DB_DATABASE DB_USERNAME DB_PASSWORD
REDIS_HOST REDIS_PORT REDIS_PASSWORD
SESSION_SECURE_COOKIE=true  WEB_AUTH_COOKIE_SECURE=true
CORS_ALLOWED_ORIGINS        (explicit HTTPS origins only)
PM_MAX_CHILDREN PM_START_SERVERS PM_MIN_SPARE PM_MAX_SPARE
ALERT_OWNER_PLATFORM ALERT_OWNER_DATA ALERT_OWNER_FINANCE ALERT_OWNER_SECURITY
POLICY_RPO_MINUTES=1440     POLICY_RTO_MINUTES=240   (approved 2026-08-15)
```

Integrations stay disabled until each is verified against its live provider:
`MAIL_ENABLED`, `PAYMENTS_ENABLED`, `PUSH_ENABLED`, `ERROR_REPORTING_ENABLED`.

Secrets go in the platform's secret store. Nothing above is ever committed.

---

## 3. Deployment sequence

Every step is a command that exists today and has been rehearsed.

**Step 0 — pre-deployment backup.** Not applicable on a first deployment (there
is no data). On any subsequent deployment:

```
docker compose --env-file .env.prod -f docker-compose.prod.yml \
  run --rm backup sh /ops/backup-container.sh once
```

Verify checksums with `/backups` mounted as the writer had it, then confirm a
restore into a scratch database before continuing. A backup that has not been
restored is not a backup.

**Step 1 — check out the exact release.**

```
git fetch --tags
git checkout v1.0.0-rc3
export APP_RELEASE=$(git rev-parse HEAD)
```

**Step 2 — preflight.** Runs automatically inside step 3, but run it alone
first so a configuration failure costs nothing:

```
bash deploy/preflight.sh
```

It verifies no required variable is blank, that both secure-cookie flags are
`true`, that `APP_ENV=production` with `APP_DEBUG=false`, and that every CORS
origin is an explicit HTTPS origin.

**Step 3 — deploy.**

```
APP_RELEASE=$APP_RELEASE ./deploy/update.sh
```

Which performs, in order: preflight → maintenance mode on both API replicas →
image rebuild → `migrate --force --isolated --database=pgsql_direct` (once,
guarded against replica races) → `optimize:clear` and `optimize` → recreate
`api1 api2 queue scheduler` → `queue:restart` → frontend copy → **unconditional
nginx restart** so the edge re-resolves new containers → maintenance mode off →
poll `/api/healthz` up to 30 times, exiting non-zero if it never answers.

A trap lifts maintenance mode even if the script dies mid-way.

**Step 4 — verify the running release.**

```
curl -fsS https://<host>/api/healthz
curl -fsS -H "Authorization: Bearer <admin-token>" https://<host>/api/health | jq .release
```

`.release` must equal `$APP_RELEASE`. If it reports `unknown`, the build did not
receive the build arg and the deployment is not traceable — roll back.

**Step 5 — smoke test.** Run the pilot workflow harness against production with
a small set of named accounts:

```
BASE=https://<host> FIXTURES=<dir> bash pilot-workflows.sh
```

Nine workflow groups: login and MFA, role separation, enrolment and parent
linking, attendance, grades and report cards, invoicing, authorised file
upload and download including cross-user refusal, notifications, and liveness
and limits. Any failure is a rollback.

**Step 6 — first backup and a restore drill,** within one hour of go-live, then
verify it restores. Not "confirm the backup job is scheduled" — restore it.

**Step 7 — watch.** Confirm all seven monitors report green, and keep a person
watching for the first two hours, because error rate and latency are not
monitored (§5.1 of the release notes).

---

## 4. Rollback

Trigger conditions are in release notes §5.1, split by whether anything actually
detects them.

```
APP_RELEASE=<previous-sha> ./deploy/update.sh
```

Rehearsed in Phase 6: rolled back to `0d9bf32`, rolled forward to `66b2e24`,
both returning HTTP 200 with the correct release stamp.

**Rollback does not revert migrations.** If a migration is the problem, restore
from backup instead — and read release notes §3.2 first, because
`add_unique_payment_reference_index` deletes payment rows that its `down()`
cannot restore.

---

## 5. What this plan deliberately does not do

- **No automatic promotion.** Approval is per deployment.
- **No enabling of unverified integrations.** Mail, payments and push stay off
  and fail closed until each is verified against its live provider.
- **No retention or erasure enforcement.** The system keeps everything until a
  retention schedule is approved. `CleanAuditLogs` refuses to delete without
  both an approved flag and an explicit period.
- **No deployment above 250 concurrent users.** That is the measured envelope.
