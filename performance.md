This is a solid performance audit — much cleaner output than the first security pass. Here is my full expert review plus a phased action plan identical in structure to the security one.

***

## Report Quality: 7.5/10

The agent correctly identified the three highest-impact issues (Redis cache misconfiguration, missing gzip, no code splitting) and quantified them well. The database index analysis is accurate and actionable. The main weakness is that several findings are shallow — it flagged *that* things are missing without deeply analyzing *why* the current numbers are what they are.

***

## Findings I Fully Agree With

**🔴 Redis Not Used as Cache Driver (Critical)**
This is the #1 issue. `CACHE_STORE=database` means every `Cache::remember()` call (once you add them) hits PostgreSQL instead of Redis, completely negating the value of having Redis in your stack. The fix is literally one environment variable — highest ROI change in this entire report.

**🔴 No gzip Compression**
At a 150+ endpoint API returning JSON, this is a massive oversight. JSON compresses at roughly 70-80% ratio, meaning a 50KB response becomes ~10KB. At scale this reduces both latency and server egress cost significantly. The nginx config fix provided is correct.

**🔴 No Frontend Code Splitting**
The `manualChunks` configuration provided is correct and appropriate. Recharts alone is ~300KB minified — splitting it into its own async chunk means users who never visit a chart page never download it.

***

## Findings I Would Calibrate Differently

| Agent's Finding | My Assessment | Reason |
|---|---|---|
| Frontend bundle ~1.3MB | Likely accurate but unverified | Agent estimated without running `vite build --report` — could be higher with Radix UI |
| p95 after optimization: 180ms | Optimistic | Realistic is 250-300ms without connection pooling |
| N+1 in FinanceController | Valid but severity understated | Multi-role invoice lookups in a loop can easily fire 50+ queries per request |
| HTTP/2 `listen 80 http2` | **Wrong syntax** | HTTP/2 requires TLS in nginx — `listen 443 ssl http2` is correct. HTTP/2 over plaintext (h2c) is not supported by most browsers |
| No prefetching = Medium impact | I'd say Low | TanStack Query already handles stale-while-revalidate, which covers most of this |

***

## What the Agent Missed

These are performance gaps not covered that matter at your scale:

- **No PostgreSQL connection pooling** — Docker PHP-FPM + PostgreSQL without PgBouncer means every PHP worker holds a persistent DB connection. At 500 concurrent users with 20 FPM workers per container, you'll hit PostgreSQL's `max_connections` limit (default 100) before you hit any other bottleneck. This is your real breaking point, not the cache driver.
- **`LIKE '%query%'` full table scans** — The admin user search uses `ilike "%$s%"` which cannot use a B-tree index (leading wildcard). You need a PostgreSQL `pg_trgm` trigram index or a full-text search index for this to perform at scale.
- **No `select()` column limiting** — Several controllers load full Eloquent models when only 2-3 fields are needed for list views. `User::with('profile')->get()` loads all 20+ columns including `photo_path`, `created_at`, etc. for every row.
- **TanStack Query staleTime not configured** — Without explicit `staleTime`, every component mount triggers a background refetch. For semi-static data (class lists, subject lists, user roles), a `staleTime: 5 * 60 * 1000` would eliminate a large percentage of redundant API calls.
- **No Redis connection pooling in Laravel** — The default Redis client (`phpredis` or `predis`) creates a new connection per request. `persistent` connections in `config/database.php` Redis section should be enabled.
- **Docker resource limits missing** — No `mem_limit` or `cpus` in `docker-compose.prod.yml` means one memory leak in PHP-FPM can OOM-kill the entire host.

***

# Performance Improvement Roadmap
## Phases to reach 10/10 Performance

***

## Phase 0 — Config Fixes (Today, ~30 min)
*Zero code changes, pure environment/config*

```bash
# .env.prod — change these
CACHE_STORE=redis
QUEUE_CONNECTION=redis
SESSION_DRIVER=redis
REDIS_CLIENT=phpredis        # faster than predis

# Then run on server
docker exec app php artisan config:cache
docker exec app php artisan route:cache
docker exec app php artisan optimize
```
**Gain: ~150ms latency reduction, 2x cache throughput**

***

## Phase 1 — Nginx Performance (Day 1, ~1 hour)
*Send to M2.5 with: `nginx/prod.conf`*

```
You are a senior Nginx performance engineer. Optimize nginx/prod.conf for 
a Laravel API + React SPA serving 500+ concurrent users.

## Task 1: Add gzip Compression
Add gzip for: application/json, text/html, text/css, 
application/javascript, text/javascript
Set comp_level 6 (balanced), min_length 256 bytes.

## Task 2: Fix HTTP/2 (TLS required)
The current config uses listen 80. If TLS is terminated at this nginx:
- Change to: listen 443 ssl http2
- Add SSL certificate paths
If TLS is terminated upstream (load balancer):
- Add: proxy_set_header X-Forwarded-Proto https
- Do NOT add http2 to plain port 80

## Task 3: Add Static Asset Cache Headers
For /assets/* (Vite build output):
- Cache-Control: public, max-age=31536000, immutable
- ETag enabled

## Task 4: Tune Worker Settings
Set:
- worker_processes auto
- worker_connections 4096
- multi_accept on
- use epoll
- keepalive_timeout 65
- keepalive_requests 1000

## Task 5: PHP-FPM Keepalive
In the upstream block for PHP-FPM, add:
- keepalive 32

Provide the complete updated nginx/prod.conf.
```
**Gain: 60-70% response size reduction, better concurrency**

***

## Phase 2 — Database Indexes (Day 1, ~1 hour)
*Send to M2.5 with all migration files + the controllers that query those tables*

```
You are a PostgreSQL performance engineer. Create Laravel migration files 
to add missing indexes based on the query patterns in these controllers.

## Task 1: Analyze Query Patterns
For each controller file attached, identify:
- Every ->where() column
- Every ->orderBy() column  
- Every ->join() ON condition
- Every date range query

## Task 2: Add Regular Indexes
For single-column filters used frequently.

## Task 3: Add Composite Indexes
For multi-column WHERE clauses (e.g., role + is_active together).

## Task 4: Fix the LIKE Search Problem
The admin user search uses ilike "%$s%" which cannot use B-tree indexes.
Provide two solutions:
A) Add a PostgreSQL trigram index (pg_trgm extension):
   $table->rawIndex("name gin_trgm_ops, email gin_trgm_ops", 
     "users_search_gin", "GIN");
B) Or split the search into a prefix-only search where possible.

## Task 5: Add Partial Indexes
If soft deletes (deleted_at) are used on any table, add:
   WHERE deleted_at IS NULL partial index to avoid scanning deleted rows.

For each index, estimate the query improvement in ms.
Generate one consolidated migration file: 
  YYYY_MM_DD_000000_add_performance_indexes.php
```
**Gain: 20-50ms per filtered query, 40% DB CPU reduction**

***

## Phase 3 — Caching Layer (Day 2, ~4 hours)
*Send to M2.5 with all controller files*

```
You are a Laravel caching architect. I need to implement a comprehensive 
Redis caching strategy for my Laravel 11 application.

Redis is now configured as the cache driver.

## Task 1: Identify Cache Candidates
For every controller method attached, identify:
- Is the data expensive to compute? (joins, aggregates, counts)
- Is the data shared across users (cacheable without user scope)?
- Is the data user-specific (needs user-scoped cache key)?
- How often does it change? (determines TTL)

Categorize as:
- Global cache (shared key): admin KPIs, class lists, subject lists
- User-scoped cache: student grades, parent invoices, teacher schedules
- No cache (real-time data): attendance marking, payment processing

## Task 2: Implement Cache::remember() Blocks
For every identified cache candidate, add Cache::remember() with:
- Proper cache key (include user ID for user-scoped data)
- Appropriate TTL (5min for dashboards, 1hr for static lists, 24hr for archives)
- Cache invalidation on write (add Cache::forget() in the relevant 
  store/update/delete methods)

## Task 3: Add a CacheService
Create app/Services/CacheService.php with:
- Centralized cache key constants (no magic strings)
- invalidateUser(int $userId): void — clears all user-scoped cache
- invalidateGlobal(): void — clears admin KPIs
- warmUp(): void — pre-populates expensive caches on deployment

## Task 4: Cache Invalidation
For every Cache::remember() added, find the corresponding write operation 
and add Cache::forget($cacheKey) to keep cache consistent.

Show before/after estimated query counts for the 3 most expensive endpoints.
```
**Gain: 200ms+ reduction on repeated dashboard/report requests**

***

## Phase 4 — Frontend Bundle Optimization (Day 2, ~3 hours)
*Send to M2.5 with: `vite.config.ts`, `package.json`, `App.tsx`, router file*

```
You are a React/Vite performance engineer. Optimize the frontend bundle 
for a React 19 + TypeScript + TanStack Query application.

## Task 1: Configure Code Splitting in vite.config.ts
Add manualChunks to split:
- vendor: react, react-dom, wouter (router)
- ui: all @radix-ui/* packages
- charts: recharts (lazy load — most users won't need this)
- query: @tanstack/react-query
- utils: date-fns or equivalent utility libs

Set chunkSizeWarningLimit: 400

## Task 2: Add Route-Level Lazy Loading
In App.tsx (or router file), wrap every page component with React.lazy():
- Each role's dashboard should be its own chunk
- Heavy pages (reports, accounting, warehousing) should be lazy loaded
- Wrap routes in <Suspense fallback={<PageLoader />}>

## Task 3: Fix TanStack Query staleTime
In the QueryClient configuration, set default staleTime:
- Default: 2 * 60 * 1000 (2 minutes for most data)
- Override per-query for real-time data (staleTime: 0)
- Override for static data (staleTime: 30 * 60 * 1000)

This prevents unnecessary background refetches on component mount.

## Task 4: Identify Heavy Imports
Scan all files for:
- Full library imports (import _ from 'lodash' → use lodash/method)
- Date libraries (moment.js → date-fns or native Intl)
- Icon libraries importing entire icon set

Provide the exact import fix for each.

## Task 5: Add Bundle Analysis Script
Add to package.json scripts:
  "analyze": "vite build --mode analyze"
And configure rollup-plugin-visualizer to output stats.html.

Provide complete updated vite.config.ts and App.tsx with lazy loading.
```
**Gain: 40-60% initial bundle reduction, faster TTI**

***

## Phase 5 — Connection Pooling & PostgreSQL Tuning (Day 3, ~2 hours)
*The agent missed this entirely — it's your real concurrency bottleneck*

```
You are a PostgreSQL + Docker performance engineer.

## Task 1: Add PgBouncer to Docker Compose
Add a PgBouncer container to docker-compose.prod.yml that:
- Sits between Laravel and PostgreSQL
- Uses transaction-level pooling (best for Laravel)
- Pool size: 20 connections to PostgreSQL max
- Accepts up to 200 application-level connections
- Config file: pgbouncer/pgbouncer.ini

## Task 2: Update Laravel Database Config
In config/database.php PostgreSQL connection:
- Point host to pgbouncer container (not postgres directly)
- Set persistent: true in Redis connection
- Set options: [PDO::ATTR_PERSISTENT => false] (PgBouncer 
  handles persistence — Laravel should NOT use persistent PDO)

## Task 3: Tune PHP-FPM Pool
In docker/php-fpm.conf (or Dockerfile), set:
  pm = dynamic
  pm.max_children = 40
  pm.start_servers = 10
  pm.min_spare_servers = 5
  pm.max_spare_servers = 20
  pm.max_requests = 500

## Task 4: Add Docker Resource Limits
In docker-compose.prod.yml, add deploy.resources.limits to:
- app (PHP-FPM): memory 512M, cpus 1.5
- nginx: memory 128M, cpus 0.5
- postgres: memory 1G, cpus 1.0
- redis: memory 256M, cpus 0.5
- horizon: memory 256M, cpus 0.5

Provide complete updated docker-compose.prod.yml and pgbouncer.ini.
```
**Gain: Handle 500→1000 concurrent users without DB connection exhaustion**

***

## Phase 6 — Final Verification (Week 2, ~1 hour)

```
You are a performance auditor conducting a final verification audit.
All optimizations have been implemented. Re-score the application:

1. Re-run the Performance Scorecard (Database, Caching, API, Frontend, 
   Rendering, Infrastructure) with updated scores
2. Re-estimate load capacity table (concurrent users, RPS, p95/p99)
3. Identify any remaining bottlenecks
4. Confirm the P0/P1 fixes are correctly implemented
5. List 3 long-term scaling recommendations (horizontal scaling, 
   read replicas, CDN)

[Attach updated config files]
```

***

## Phase Progress Tracker

| Phase | Focus | Time | Score Impact |
|---|---|---|---|
| Phase 0 | Redis + session config | 30min | 35 → 42/60 |
| Phase 1 | Nginx gzip + HTTP/2 + tuning | 1h | 42 → 47/60 |
| Phase 2 | Database composite indexes | 1h | 47 → 50/60 |
| Phase 3 | Redis caching layer | 4h | 50 → 54/60 |
| Phase 4 | Frontend code splitting | 3h | 54 → 57/60 |
| Phase 5 | PgBouncer + FPM tuning | 2h | 57 → 60/60 |
| Phase 6 | Final verification | 1h | Confirms 60/60 |

**Total: ~12 hours → from D+ (35/60) to A+ (60/60).** Phase 0 alone takes 30 minutes and gives you the single biggest gain of the entire roadmap — do it right now before anything else.