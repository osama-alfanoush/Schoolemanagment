# Capacity and performance — measured 2026-08-15

Every number here was measured, not estimated. Where a figure could not be
obtained, it says so rather than being filled in.

---

## 1. The environment these numbers came from, and what it is not

| | |
|---|---|
| Host | One machine: 16 vCPU, 30.9 GB RAM, Docker Desktop |
| Application | 2 × php-fpm replicas behind nginx |
| Database | PostgreSQL 16, `max_connections=100` |
| Pooler | PgBouncer 1.23, transaction mode |
| Cache/queue | Redis 7 |
| Object storage | MinIO |
| Load generator | k6 — **on the same host** |

**This is not production-representative, and the 500-user result must not be
read as if it were.** Every tier — database, cache, object storage, application
and the load generator itself — competes for the same 16 cores. Phase 4 asks for
production-like infrastructure with the generator on separate compute; no second
machine and no remote Docker context exists in this environment, so that
requirement is unmet. See §7.

What the environment *can* establish, and does: relative behaviour between
configurations measured back-to-back on identical hardware. The pooling A/B and
the worker-count experiment are both valid on that basis, because only one
variable changes between runs.

Measurement notes:

- The edge used for load generation is `nginx/loadtest.conf`, a deliberately
  non-deployable copy that raises only the per-IP rate limit. Without it a
  single-source generator measures the rate limiter rather than the application.
- k6 `setup()` authenticates every account in one burst before the measured
  window. Those requests are now tagged `phase:setup` and excluded from
  steady-state percentiles; before that they made p99 report a cold-start
  artefact. Runs at 50/100/250 predate the tag, so their p99 is not comparable —
  their p50/p95 and error rates are unaffected.

---

## 2. The capacity ladder

2 replicas × `pm.max_children=20`, PgBouncer transaction pooling, 20 s ramp then
150 s steady. Errors are the steady-state rate.

| VU | p50 | p95 | Errors | Throughput | Gate p95 < 800 ms |
|---:|---:|---:|---:|---:|:---:|
| 50 | 43 ms | **113 ms** | 0.00% | 42.5 req/s | PASS |
| 100 | 41 ms | **72 ms** | 0.00% | 86.7 req/s | PASS |
| 250 | 159 ms | **622 ms** | 0.00% | 208.8 req/s | PASS |
| 500 | 1.49 s | **2.69 s** | 0.00% | 184.9 req/s | **FAIL** |

Throughput rises to 250 VU and then *falls* at 500 (208.8 → 184.9 req/s) while
latency triples. That shape — throughput flat-to-declining, latency climbing,
errors still zero — is queueing past the saturation point, not failure.

Per-endpoint latency on an idle system, 10 samples each:

| Endpoint | Mean |
|---|---:|
| `/api/healthz` | 27.7 ms |
| `/api/student/attendance` | 47.4 ms |
| `/api/student/grades` | 56.2 ms |
| `/api/student/report-card` | 61.9 ms |
| `/api/student/dashboard` | 65.4 ms |

No endpoint is an outlier and no N+1 pattern was found (10–24 statements,
15–26 ms of database time per request, measured in the previous phase). The
slowness at 500 VU is queueing for a worker, not a slow query.

---

## 3. Where the bottleneck actually is

Resource peaks during the 500 VU run:

| Signal | Peak | Reading |
|---|---:|---|
| php-fpm active workers | **20 / 20** | pool fully occupied |
| `max children reached` | **16** | ceiling hit repeatedly |
| php-fpm listen queue | **153** | 153 requests waiting for a worker |
| Application CPU (2 replicas) | 928% | ~9.3 of 16 cores |
| PostgreSQL CPU | 215% | ~2.2 cores |
| PgBouncer CPU | 96% | ~1 core |
| **PgBouncer `cl_waiting`** | **0** | **nothing ever waited for a connection** |
| **PgBouncer `maxwait`** | **0 µs** | **no pool starvation** |
| PostgreSQL connections | 31 / 100 | 69% headroom |
| Queue depth | 0 | workers kept up throughout |

The database is not the constraint. It has two thirds of its connections free,
the pool never made a single client wait, and it is using a seventh of the
host's CPU. The constraint is the PHP tier: workers all busy, 153 requests
queued behind them, and roughly 12.4 of 16 host cores consumed in total.

This overturns the earlier hypothesis. Before pooling existed, PostgreSQL burned
~7.4 cores and looked like the problem; with pooling it uses ~2.2 and the
pressure has moved to where the work actually happens.

---

## 4. Tuning, from measurement

### 4.1 php-fpm worker memory — measured

`ps` inside a replica while serving: **34 MB average, 38 MB peak** resident per
worker; master ~21 MB.

Memory ceiling for a replica is therefore:

```
max_children ≈ (container memory × 0.8) / 38 MB
            →  512 MB → 10      1 GB → 21      2 GB → 43
```

At the current 20 workers a replica needs ~780 MB for workers alone, so **1 GB
per replica is the practical floor** and 2 GB is comfortable.

### 4.2 Worker count — the experiment that changed the answer

The obvious response to "153 requests queued" is more workers. It was tested
rather than assumed: `pm.max_children` 20 → 40 per replica, same 500 VU profile,
everything else identical.

| Config | p50 | p95 | Throughput | `max children reached` | PgBouncer `cl_waiting` |
|---|---:|---:|---:|---:|---:|
| 20 workers | 1.49 s | **2.69 s** | 184.9 req/s | 16 | 0 |
| 40 workers | 1.32 s | **19.40 s** | 195.7 req/s | 1 | **6** |

Doubling the workers bought **5.8% throughput** and made **p95 7× worse**. It
also pushed waiting onto the connection pool for the first time (`cl_waiting`
went from 0 to 6).

That is what CPU saturation looks like: the host had ~3.6 cores of headroom, so
more concurrent workers did not create more capacity — they subdivided the same
CPU into more, slower slices and lengthened every request. **`max_children`
stays at 20 per replica.** The queue is a symptom of insufficient CPU, and the
fix for it is more compute, not more workers.

### 4.3 Connection pooling — measured, not assumed

Same 250 VU profile, only the database host changed:

| Config | p50 | p95 | Throughput | PostgreSQL CPU peak |
|---|---:|---:|---:|---:|
| Through PgBouncer | **159 ms** | **622 ms** | **208.8 req/s** | **146%** |
| Direct to PostgreSQL | 714 ms | 18.10 s | 119.5 req/s | 899% |

Pooling delivers **6.2× less database CPU**, **75% more throughput** and a
**29× better p95**. php-fpm opens a connection per request and a PostgreSQL
backend is a forked process; at ~200 req/s that fork rate is the dominant cost,
and it is why raising `max_connections` makes the problem worse rather than
better. This is the single largest performance change in the project.

### 4.4 Pool sizing

Deliberately left conservative so saturation stays visible:
`default_pool_size=25` against `max_connections=100`, `max_client_conn=200`.
Peak observed use was 13 server connections and 31 total backends — the pool has
not been sized to hide a problem, and `cl_waiting`/`maxwait` are recorded by
`ops:monitor` precisely so starvation would show up rather than be absorbed.

---

## 5. Collection and export limits

Two real defects found and fixed:

- **Uncapped page size.** Thirteen controllers passed `per_page` from the query
  string straight into `paginate()`. `?per_page=1000000` would materialise an
  entire table — a denial of service needing nothing but an ordinary login, and
  one that worsens as a school accumulates data. All page-size reads now go
  through `Controller::perPage()`, which clamps to 100 and floors at the
  default, so `?per_page=0` and negative values cannot produce an unpaginated
  query either.
- **Unbounded reminder sweep.** `POST /api/finance/invoices/send-reminders`
  loaded every unpaid invoice in the school, plus every parent link for them,
  into memory at once. Now chunked at 200 with one parent-link query per chunk,
  so the working set is bounded regardless of the outstanding backlog.

Exports were already bounded by required scope parameters — grade exports need a
class and subject, warehouse and accounting reports need a year and month — so
none can be asked for an unbounded range.

---

## 6. Integrity under concurrency

Checked after every load run, against the database the load ran through:

| Class | Duplicates found |
|---|---:|
| Payment references | 0 |
| Payment idempotency keys | 0 |
| Attendance (student, date, subject) | 0 |
| Grades (student, component) | 0 |
| Payroll records (run, staff) | 0 |
| Unbalanced journal batches | 0 |
| Webhook events (provider, event id) | 0 |

The PostgreSQL concurrency suite passes: one winner for a concurrent grade
compare-and-swap, a single row from concurrent attendance upserts, overlapping
enrolments rejected by an exclusion constraint, and exactly one active payroll
record from two concurrent writers. Queue depth stayed at 0 throughout every
run, with no failed-job growth.

---

## 7. Supported concurrency and safety margin

On the hardware described in §1:

| | |
|---|---|
| **Supported concurrent users** | **250** (p95 622 ms, 0% errors, 208.8 req/s) |
| Comfortable operating point | 100 (p95 72 ms — 11× inside the gate) |
| Safety margin at 100 users | ~2.5× headroom to the supported limit |
| First failing level | 500 (p95 2.69 s) |
| Binding constraint | Host CPU; php-fpm workers queue behind it |

For a school of ~1 000 pupils, 250 genuinely concurrent in-flight users is a
large fraction of the whole population active at the same instant, so this is
adequate for a controlled pilot. It is **not** validated for the report-card-day
peak that motivated the 500 VU profile.

**What would raise it.** The tier is CPU-bound, so capacity scales with cores
and replicas, not with configuration:

- More replicas on separate compute. Throughput per replica was ~104 req/s at
  250 VU; four replicas on dedicated hosts should reach the 500 VU profile.
- Move PostgreSQL, Redis and object storage off the application host. They took
  ~3.2 cores that the application could otherwise use.
- Keep `pm.max_children` at 20 per replica and add replicas instead (§4.2).
- Give each replica ≥1 GB, ideally 2 GB (§4.1).

**Re-measure before relying on any of this.** The numbers above are a floor
measured under adverse conditions, not a production capacity statement.

---

## 8. Reproducing

```bash
# Load-generation edge (non-deployable; relaxes only the per-IP rate limit)
docker run -d --name school-loadtest-nginx --network school-staging_staging_net \
  -p 127.0.0.1:8090:80 \
  -v "$PWD/nginx/loadtest.conf:/etc/nginx/conf.d/default.conf:ro" \
  -v "$PWD/public:/var/www/public:ro" nginx:1.27-alpine

# One level, with full metric capture
bash run-level.sh vu250 250 150

# Worker count and pool bypass are both overridable without a rebuild
PM_MAX_CHILDREN=40 docker compose --env-file .env.staging \
  -f docker-compose.staging.yml up -d --no-deps --force-recreate api1 api2
DB_APP_HOST=postgres DB_APP_PORT=5432 docker compose --env-file .env.staging \
  -f docker-compose.staging.yml up -d --no-deps --force-recreate api1 api2
```

`/fpm-status` exposes pool occupancy and listen-queue depth to the compose
network only. Without it, "is the worker pool saturated?" can only be guessed at
from latency — which is exactly the guess that produced the wrong answer in §4.2.
