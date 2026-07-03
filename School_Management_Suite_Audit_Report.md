# School Management Suite Audit Report

Audit date: 2026-06-24  
Scope: `laravel-api/` and `school-web/`

## Executive Summary

The application has a strong functional base: broad role coverage, a large automated test suite, Sanctum authentication, parent IDOR tests, payment webhook tests, frontend type safety, frontend smoke tests, route-level role guards, and production-minded pieces such as Redis, Postgres, queues, scheduler, CSP, and security headers.

It is not production-ready yet. The most serious risks are deployment/configuration errors, dependency vulnerabilities, storage serving problems, payment edge cases, and a few security hygiene gaps. The code itself is much healthier than the deployment story.

## Ratings

| Area | Rating | Reason |
| --- | ---: | --- |
| Security | 5.5 / 10 | Good auth/role foundations, but vulnerable dependencies, token storage in `localStorage`, insecure production template defaults, possible audit-log password leakage, missing `.dockerignore`, source-map exposure risk, and deployment secret/config issues. |
| Performance | 7.0 / 10 | Backend tests are fast enough, indexes exist, frontend is code-split, and Vite builds successfully. Main risks are heavy chart bundle, some N+1/over-fetch paths, synchronous PDFs/exports, long immutable caching on `index.html`, and no production load testing gate. |
| Scalability | 6.2 / 10 | Uses Postgres/Redis, two API containers, scheduler, and queue intent. However Horizon is configured without being installed, public uploads are not shared to NGINX, Docker env interpolation is wrong, file storage is local, and there is no clear horizontal file/object-storage plan. |
| Maintainability | 6.8 / 10 | Test coverage is a major plus. Gaps: Pint fails across many files, no PHP static analysis, no ESLint script, large controllers/services, inconsistent response shapes, and generated/archive artifacts in app roots. |
| Overall | 6.4 / 10 | Feature-complete enough to continue, but production hardening should happen before real school data is used. After the critical fixes below, this can move into the 8/10 range. |

## Inventory

`laravel-api/`

- 209 source-listed files from `rg --files`.
- Laravel 11, PHP 8.2, Sanctum, Stripe SDK, DomPDF, Simple Excel.
- 198 API routes from `php artisan route:list --path=api`.
- Domains covered: auth, admin, student, parent, teacher, finance, accounting, HR, warehouse, notifications, messaging, payments, transport, library, medical.

`school-web/`

- 216 source-listed files from `rg --files`.
- Vite, React 19, TypeScript, Tailwind 4, Radix UI, TanStack Query, Wouter, Vitest.
- Role portals for student, parent, teacher, admin, finance, HR, accounting, warehouse.

## Verification Results

| Check | Result |
| --- | --- |
| Backend tests: `php artisan test` | Passed: 156 tests, 430 assertions. PHP emits duplicate extension warnings for `fileinfo`, `curl`, `zip`, `openssl`. |
| Backend manifest: `composer validate --strict` | Passed, with same PHP extension warnings. |
| Backend formatting: `vendor/bin/pint --test` | Failed across many backend files. Mostly style/fixer issues, but CI should enforce this. |
| Backend dependency audit: `composer audit` | Failed security gate: 19 advisories affecting 10 packages, including high-severity Laravel/Symfony mail or email validation issues and medium Guzzle/Symfony issues. |
| Frontend typecheck: `npm.cmd run typecheck` | Passed. |
| Frontend build: `npm.cmd run build` | Passed outside sandbox. Build took about 9.63s. Largest chunk: `vendor-charts`, about 392 KB raw / 106 KB gzip. |
| Frontend tests: `npm.cmd test -- --run` | Passed: 24 files, 112 tests. One jsdom warning: `Not implemented: navigation to another Document`. |
| Frontend dependency audit: `npm.cmd audit --audit-level=moderate` | Failed security gate: 3 vulnerabilities, including high-severity Vite and undici advisories plus a low-severity esbuild Windows dev-server advisory. |
| Docker config: `docker compose -f docker-compose.prod.yml config` | Confirmed Compose interpolation issues: infrastructure credentials are not sourced from `env_file: .env.prod`; local project `.env` or shell values are used instead. |

## Critical Findings

### 1. Production frontend deployment path is broken

Evidence:

- `school-web/vite.config.ts:62` builds to `dist/public`.
- `laravel-api/deploy/copy-frontend.sh:5` copies `../school-web/dist`.
- `laravel-api/nginx/prod.conf:55` serves frontend root from `/var/www/html`.
- `laravel-api/deploy/copy-frontend.sh:17` writes to `school_api_frontend_dist`.
- `laravel-api/docker-compose.prod.yml:159` defines the actual Compose volume as `frontend_dist`, which resolves to `laravel-api_frontend_dist` by default.

Impact:

- The deploy script can copy the wrong directory shape, placing `public/index.html` under the web root instead of `index.html`.
- It can also write into a volume that NGINX does not mount.
- Result: API may run, but the frontend can serve 404 or stale content in production.

Recommendation:

- Change `DIST_PATH` to `../school-web/dist/public`.
- Use `docker compose` volume names, not hard-coded `school_api_frontend_dist`.
- Or build the frontend into a dedicated NGINX image instead of copying into a named volume.

### 2. Queue worker deployment is misconfigured

Evidence:

- `laravel-api/docker-compose.prod.yml:60` runs `php artisan horizon`.
- `laravel-api/composer.json` does not include `laravel/horizon`.
- `laravel-api/app/Http/Controllers/Api/HealthController.php:20` checks Horizon but treats missing Horizon as a warning.

Impact:

- The `horizon` container will fail unless Horizon is installed later outside the manifest.
- Queued jobs, notifications, mail, and async work may not process in production.

Recommendation:

- Either install/configure `laravel/horizon`, publish its config, and protect the Horizon dashboard, or replace the container command with `php artisan queue:work redis --sleep=3 --tries=3 --timeout=90`.

### 3. Docker Compose production secrets are resolved from the wrong source

Evidence:

- `laravel-api/docker-compose.prod.yml:101`, `:118`, `:126`, `:139`, and `:140` use `${DB_PASSWORD}`, `${REDIS_PASSWORD}`, `${MINIO_KEY}`, and `${MINIO_SECRET}`.
- These values are not read from `env_file: .env.prod` for Compose interpolation.
- Local `docker compose config` confirmed blank/development infrastructure values without repeating secrets here.

Impact:

- Postgres, Redis, and MinIO can start with blank, `null`, or unrelated local values while API containers receive different `.env.prod` values.
- This causes broken database/cache connectivity or insecure infrastructure credentials.

Recommendation:

- Create a root `.env` used only by Compose, pass `--env-file .env.prod`, or rewrite compose to use `environment` values consistently.
- Add a preflight script that fails if any production secret is blank, `null`, `CHANGE_THIS`, or `GENERATE_WITH_ARTISAN`.

### 4. Backend Docker image can include secrets and artifacts

Evidence:

- `laravel-api/Dockerfile.prod:30` does `COPY . .`.
- `laravel-api/` has no `.dockerignore`.
- `laravel-api/.env.prod` exists locally and is ignored by git, but Docker does not use `.gitignore`.

Impact:

- A Docker build context can include `.env`, `.env.prod`, local caches, test files, archives, and other sensitive or bulky files.
- Secrets may be baked into image layers.

Recommendation:

- Add `laravel-api/.dockerignore` excluding `.env*`, `vendor`, `node_modules`, `storage/logs`, `storage/framework/*`, `tests`, `.git`, `*.zip`, `.phpunit.cache`, and local artifacts.
- Prefer multi-stage builds with explicit copy lists.

### 5. Public uploads may upload successfully but fail to serve

Evidence:

- `laravel-api/app/Http/Controllers/Api/AuthController.php:143` stores profile photos on the `public` disk.
- `laravel-api/app/Services/UserManagementService.php:268` stores school logos on the `public` disk.
- `laravel-api/config/filesystems.php:43` maps the public disk to `storage/app/public`.
- `laravel-api/docker-compose.prod.yml:10` mounts only `./public` into NGINX.
- `laravel-api/docker-compose.prod.yml:26` and `:44` mount `storage_data` only into API containers.

Impact:

- User photos and school logos can be stored inside API container storage, but NGINX has no shared path to serve them.
- `APP_URL` and `/storage/...` URLs can return 404 in production.

Recommendation:

- Mount `storage_data` into NGINX read-only at `/var/www/storage`, add a `/storage/` alias to NGINX, and run/ensure `storage:link`.
- Better: move uploaded files to S3/MinIO and generate signed or public URLs intentionally.

### 6. Dependency advisories require immediate patching

Backend:

- `composer audit` found 19 advisories affecting 10 packages.
- Notable categories: Laravel framework email-rule/path issues, Symfony mailer/mime/routing/http issues, Guzzle/PSR-7 issues.

Frontend:

- `npm audit` found 3 advisories.
- Notable packages: Vite, undici, esbuild.

Impact:

- The backend handles student, HR, payment, and medical data. Dependency patch lag is a production blocker.
- The Vite/esbuild issues matter more because `school-web/vite.config.ts:113-114` and `:129-130` bind dev/preview to `0.0.0.0` with `allowedHosts: true`.

Recommendation:

- Run `composer update laravel/framework symfony/* guzzlehttp/* --with-all-dependencies` carefully and rerun tests.
- Run `npm audit fix`, then rerun typecheck/build/tests.
- Avoid exposing Vite dev/preview servers outside trusted local networks.

### 7. Stripe/system payments conflict with non-null `recorded_by`

Evidence:

- `laravel-api/app/Services/PaymentGatewayService.php:166` creates a payment with `recorded_by => null`.
- `laravel-api/database/migrations/2026_04_17_100000_create_school_schema.php:218` makes `payments.recorded_by` a required foreign key.

Impact:

- Successful Stripe payment confirmations or webhooks can fail at database insert time.
- The existing tests do not cover a fully successful Stripe confirmation path.

Recommendation:

- Make `recorded_by` nullable with `nullOnDelete`, or create a dedicated system user for gateway-recorded payments.
- Add a feature test for a successful mocked Stripe confirmation and webhook.

### 8. Audit logging can store sensitive raw fields

Evidence:

- `laravel-api/app/Services/UserManagementService.php:78` logs `$data` during `update_user`.
- `$data` can include `password`.
- `laravel-api/app/Services/AuditLogger.php:14-24` stores and file-logs `changes` without redaction.

Impact:

- If an admin updates a password, the plaintext submitted password can be written to audit storage/log files before hashing.

Recommendation:

- Add centralized redaction in `AuditLogger` for keys like `password`, `token`, `secret`, `authorization`, `client_secret`, `reference`, and personal medical notes where appropriate.
- Avoid logging full payloads for sensitive HR/medical/payment changes.

## High Priority Bugs and Logic Gaps

### Finance payment rules are too loose

Evidence:

- `laravel-api/app/Http/Controllers/Api/FinanceController.php:99` validates manual payment amount as `min:0`.
- `laravel-api/app/Http/Controllers/Api/FinanceController.php:104-113` updates invoice totals without locking the invoice row.

Problems:

- Zero-value payments are accepted.
- Overpayments are not prevented or explicitly modeled as credit.
- Concurrent manual payments can race and overwrite totals.

Recommendation:

- Use `gt:0`.
- Lock the invoice row with `lockForUpdate()`.
- Reject overpayment or record the extra amount as credit/refund workflow.

### Parent/student linking does not validate roles

Evidence:

- `laravel-api/app/Services/UserManagementService.php:92-96` validates only that IDs exist.

Impact:

- Admins can accidentally link non-parent users to non-student users, creating confusing authorization and data-quality problems.

Recommendation:

- Validate `parent_user_id` has role `parent`.
- Validate `student_user_id` has role `student`.
- Add a test for invalid-role linking.

### Parent invoices page expects the wrong response shape

Evidence:

- `laravel-api/app/Http/Controllers/Api/ParentController.php:76-80` returns `{ invoices, outstanding_total }`.
- `school-web/src/lib/api.ts:553` types `Parent.childInvoices` as `Promise<Invoice[]>`.
- `school-web/src/pages/parent/Invoices.tsx:31` reads `invoicesData?.data`, not `invoicesData?.invoices`.

Impact:

- The standalone parent invoice page can show no invoices even when the API returned them.

Recommendation:

- Update the API client type to `{ invoices: Invoice[]; outstanding_total: number }`.
- Update `ParentInvoices` to read `invoicesData.invoices`.
- Add a frontend test for this response shape.

### PDF/download requests do not refresh tokens

Evidence:

- `school-web/src/lib/api.ts:459-491` implements `apiDownload`.
- Normal `apiFetch` refreshes tokens on 401, but `apiDownload` does not.

Impact:

- Report cards, receipts, accounting PDFs, and warehouse PDFs can fail after access-token expiry while normal API calls continue working.

Recommendation:

- Reuse the same refresh/retry path for downloads.

### Environment examples miss required payment variables

Evidence:

- `laravel-api/config/services.php:39-44` expects `STRIPE_SECRET_KEY`, `STRIPE_PUBLIC_KEY`, and `STRIPE_WEBHOOK_SECRET`.
- These are not documented in `laravel-api/.env.example` or `laravel-api/.env.prod.example`.

Impact:

- Payment deployment and webhook setup are easy to misconfigure.

Recommendation:

- Add all payment, CORS, Sanctum, mail, object storage, and queue variables to environment examples with safe placeholder values.

### NGINX caches the SPA shell for one year

Evidence:

- `laravel-api/nginx/prod.conf:55-58` applies `expires 1y` and `Cache-Control: public, immutable` to the `/` location.

Impact:

- `index.html` can be cached for a year. Users may keep loading old JS asset references after deployment.

Recommendation:

- Cache hashed assets for one year.
- Serve `index.html` with `Cache-Control: no-cache` or short `max-age`.

### Source maps may be deployed publicly

Evidence:

- `school-web/vite.config.ts:65` sets `sourcemap: 'hidden'`.

Impact:

- Hidden maps are not referenced by JS, but if copied to the public NGINX root they can expose readable source.

Recommendation:

- Upload maps to Sentry/private storage only, or block `*.map` in NGINX.

### Audit cleanup and scheduled notifications are incomplete

Evidence:

- `laravel-api/config/audit.php:13` references an `audit:clean` artisan command.
- Search found no `audit:clean` command implementation.
- `NotificationService::processScheduled()` exists, but `laravel-api/routes/console.php` schedules only `hr:check-contracts`.

Impact:

- Audit retention may never run.
- Scheduled notifications may never process.

Recommendation:

- Add and schedule `audit:clean`.
- Add and schedule `notifications:process-scheduled`.
- Test both commands.

## Security Review

Strengths:

- Sanctum authentication with short access-token TTL and refresh-token rotation.
- Login throttling and account lockout.
- Parent ownership middleware and IDOR tests.
- Role middleware across portals.
- Payment webhook signature validation.
- CORS is environment-driven.
- Security headers and CSP exist on both backend/NGINX/frontend.
- Password reset and change-password flows exist.

Risks:

- Dependency advisories are currently the top security blocker.
- Tokens are stored in `localStorage` in `school-web/src/lib/api.ts:286-326`; XSS can steal both access and refresh tokens.
- `laravel-api/.env.prod.example:5` documents HTTP `APP_URL`.
- `laravel-api/.env.prod.example:20` sets `SESSION_SECURE_COOKIE=false`.
- No `.dockerignore` means secrets can enter Docker build contexts.
- Audit logs need redaction.
- Hidden source maps can expose source if deployed.
- Vite dev/preview servers bind to all interfaces with permissive hosts.
- MinIO console is exposed on `9001` in `laravel-api/docker-compose.prod.yml:144-145`.
- Docker images use floating tags such as `nginx:alpine`, `redis:7-alpine`, and `minio/minio`, which reduces reproducibility.

Security recommendations:

1. Patch Composer and npm advisories first.
2. Add `.dockerignore` and rebuild images.
3. Change production defaults to HTTPS and secure cookies.
4. Prefer HttpOnly secure cookies for refresh tokens, or at least reduce refresh-token exposure and harden CSP further.
5. Add audit redaction.
6. Block public source maps.
7. Restrict MinIO console to VPN/admin IPs or remove the public port.
8. Pin production images by version/digest.
9. Add security checks to CI: `composer audit`, `npm audit`, tests, and secret scanning.

## Performance Review

Strengths:

- Frontend lazy-loads portal pages.
- Manual Vite chunks keep most pages small.
- Backend has a performance-index migration.
- Many list endpoints paginate.
- QueryClient disables noisy refetches and sets a reasonable stale time.
- Backend test suite covers many business paths.

Performance risks:

- `vendor-charts` is the largest frontend chunk at about 392 KB raw / 106 KB gzip.
- `MessagingController::threads()` performs an unread-count query per thread.
- `MessagingController::recipients()` fetches 100 users and then filters authorization in PHP.
- Health checks write/read/delete a storage file each request.
- PDFs and Excel exports are generated synchronously inside HTTP requests.
- Some endpoints return full collections without pagination, such as classes, subjects, fee structures, and some HR/transport lists.
- NGINX static caching is currently too broad and can cache `index.html`.

Performance recommendations:

1. Split chart-heavy pages or lazy-load chart libraries only where used.
2. Replace per-thread unread counts with grouped aggregate queries.
3. Push message recipient authorization into SQL where possible.
4. Move large PDF/Excel exports to queued jobs with notification/download links.
5. Add pagination to every unbounded admin/HR/transport/finance list.
6. Add application-level caching for stable reference data.
7. Add k6/load-test thresholds to CI using the existing `tests/load` scripts.

## Scalability Review

Strengths:

- Postgres and Redis are the right foundation.
- Two API containers and NGINX upstream are already modeled.
- Sessions/cache/queue are configured for Redis in production examples.
- Scheduler container exists.
- OPcache is configured in the production Dockerfile.

Scalability blockers:

- Queue worker/Horizon setup is broken.
- Uploaded files are local and not shared to the web tier.
- Compose secrets can diverge between API and infrastructure services.
- Single NGINX, Postgres, Redis, and MinIO instances are modeled without backup/restore or HA plans.
- Public file storage and generated exports need an object-storage strategy.
- Deployment scripts do not include rollback or release directories.

Scalability recommendations:

1. Fix queue worker first; background work is essential for mail, notifications, exports, imports, and reminders.
2. Move uploads and generated files to S3/MinIO with a clear URL/signing policy.
3. Add DB backup/restore scripts and test restores.
4. Add health-based deployment checks before switching traffic.
5. Separate build and runtime images; do not build mutable source on production hosts.
6. Add metrics: queue depth, failed jobs, request latency, DB connection count, Redis memory, disk usage.

## App Logic and Product Completeness

Strong areas:

- The domain model is broad and coherent for a school suite.
- Role portals exist for major user groups.
- Parent/student data isolation is actively tested.
- Accounting, warehouse, HR, notifications, payment, and reporting modules are present.
- Frontend has good reusable UI primitives and test coverage.

Missing or incomplete areas:

- Payment methods and setup intents return placeholders.
- Student import generates random passwords but does not clearly return or deliver onboarding credentials.
- Parent invoice page response handling is inconsistent.
- Admin user/class assignment should validate role compatibility.
- Scheduled notification processing is not wired to the scheduler.
- Audit cleanup is referenced but not implemented.
- Production upload serving is incomplete.
- No documented backup/restore process.
- No explicit privacy/data-retention policy for medical, HR, audit, notification, and message data.

## Repository Hygiene

Findings:

- `laravel-api/nginx.zip` is about 34 MB and appears as untracked.
- `school-web/src.zip` is about 2.1 MB and sits inside the frontend root.
- Root `.gitignore` does not ignore `*.zip`.
- Backend `.gitignore` correctly ignores `.env.prod`, but Docker still needs `.dockerignore`.
- Worktree was already dirty before this report was created, with many modified files and a few untracked files.

Recommendations:

- Remove accidental archives from app roots unless they are intentionally documented release artifacts.
- Add `*.zip` or a narrower artifact rule to `.gitignore`.
- Keep generated build output out of commits.
- Add CI checks for formatting and audits.

## Suggested Improvement Roadmap

### Immediate: production blockers

1. Patch Composer and npm advisories.
2. Fix Docker Compose env interpolation.
3. Add `.dockerignore`.
4. Fix frontend deployment path and volume name.
5. Fix queue worker/Horizon deployment.
6. Fix public upload serving or move files to object storage.
7. Fix `recorded_by` for gateway payments.
8. Redact audit logs.

### Short term: reliability and correctness

1. Add tests for successful Stripe confirmation/webhook.
2. Add tests for zero/overpayment and concurrent manual payment.
3. Add tests for parent invoice page response shape.
4. Validate parent/student roles and teacher assignment roles.
5. Implement and schedule audit cleanup plus scheduled-notification processing.
6. Add `composer audit`, `npm audit`, Pint, typecheck, backend tests, frontend tests, and frontend build to CI.

### Medium term: performance and scale

1. Queue heavy exports/imports/notification sends.
2. Add pagination and aggregate-query improvements.
3. Reduce chart bundle cost.
4. Add object storage and signed URL policy.
5. Add load-test thresholds.
6. Add observability dashboards and alerts.

### Long term: governance

1. Document data retention for HR, medical, messages, audit logs, and notifications.
2. Add backup/restore runbooks.
3. Add role-permission matrix documentation.
4. Add release rollback process.
5. Add periodic dependency update cadence.

## Final Assessment

This is a promising and fairly comprehensive school management suite with good test momentum. The backend business coverage and frontend role portals are much better than an early prototype. The biggest problem is not that the app is thin; it is that production operations, dependency patching, secrets handling, file serving, and a few finance/security edge cases need to catch up with the feature surface.

Recommended status: continue development, but do not onboard real school data until the immediate production blockers are resolved and the dependency audits pass.
