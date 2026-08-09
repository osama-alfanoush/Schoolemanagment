# GPT handoff — School Management Suite

## Included projects

- `laravel-api`: Laravel backend.
- `school-web`: React/Vite frontend.
- `AGENTS.md`: repository instructions, including Graphify usage.

Dependencies, local `.env` files, databases, backups, user uploads, logs, build outputs, and Graphify generated output are intentionally excluded.

## Work completed in the current pass

- HR/Payroll resources are scoped by the authenticated user's single active `school_user_roles` assignment.
- Client-provided `school_id` is ignored for payroll creation and is not present in the frontend request type.
- School scoping covers staff, contracts, attendance, leave/HR requests, warnings, advances/installments, payroll settings/components/insurance, runs, records/components, payslips, reports, reconciliation, and generated journals.
- Added a safe preflight command: `php artisan hr-payroll:school-scope-preflight`.
- Added migration `2026_08_03_000001_harden_school_scoped_hr_payroll.php` with conflict-first backfill, guarded rollback, and partial unique indexes for active payroll runs/records.
- Legacy payroll reads remain school-scoped. Legacy write endpoints return HTTP 410 with `LEGACY_PAYROLL_WRITE_DISABLED`.
- Payroll transitions are centralized and protected by transactions, row locks, state checks, closed-period checks, DB uniqueness, and journal idempotency.
- Frontend legacy payroll route now opens the run workflow. Mutating buttons disable while requests are pending.

## Validation completed

- Laravel: 310 tests, 1009 assertions passed.
- HR/Payroll P0 isolation suite: 12 tests passed.
- PostgreSQL 16 migrations passed.
- PostgreSQL concurrency: 4 tests, 17 assertions passed, including two concurrent payroll writers producing exactly one active record.
- Migration qualification on the testing database: fresh -> migrate -> rollback -> migrate passed.
- Web Vitest: 26 files, 124 tests passed.
- TypeScript typecheck passed.
- ESLint exited successfully; the repository still has pre-existing warnings.
- Vite production build passed.
- Playwright critical flows: 7 passed.
- `git diff --check` passed apart from Windows CRLF notices.
- Graphify was updated after code changes.

## Important remaining decisions / follow-up

- The existing rule preventing the payroll run creator from approving the same run was preserved, not invented here. Obtain explicit business confirmation and document it.
- Users with multiple active school assignments are currently denied HR/Payroll access until an explicit, authorised school-selection context is designed.
- Payroll has no real `cancelled` state; only `reversed` is implemented. Do not invent cancellation semantics without a business decision.
- Before any deployment, run the preflight command and resolve every reported row manually. Do not auto-merge, auto-delete, clone global settings across schools, or guess ownership.
- Do not run migrations on production without a reviewed backup, conflict report, maintenance/deployment plan, and restore rehearsal.

## Useful commands

```bash
cd laravel-api
composer install
php artisan hr-payroll:school-scope-preflight
php artisan test --compact

cd ../school-web
npm ci
npm test -- --run
npm run typecheck
npm run lint
npm run build
npx playwright test --grep "critical|smoke"
```

The workspace was already heavily modified before this P0 pass. Preserve unrelated existing changes and inspect overlapping files carefully.
