# School Management API

A Laravel 11 backend powering the Private School Management System. Six actor roles
(student, parent, teacher, admin, finance, hr) share a single REST surface with
role-based access enforced by middleware and per-resource ownership checks.

- **Stack**: Laravel 11, PHP 8.2+, PostgreSQL, Sanctum bearer tokens.
- **Run**: `php -S 0.0.0.0:20141 -t public public/index.php` (workflow `artifacts/laravel-api: web`).
- **Reset DB**: `php artisan migrate:fresh --seed`.
- **Seed accounts** (password: `password`): `admin@school.test`, `finance@school.test`,
  `hr@school.test`, `teacher1@school.test` … `teacher5@school.test`,
  `parent1@school.test` … `parent6@school.test`, `ali1@school.test` (student), etc.

## Authentication

Sanctum personal-access tokens with explicit access + refresh grants distinguished
by token abilities. Access tokens expire in 2 hours; refresh tokens in 30 days.

| Method | Path | Purpose |
| ------ | ---- | ------- |
| POST | `/api/auth/login` | Returns `{access_token, refresh_token, token_type, expires_in, user}` |
| POST | `/api/auth/refresh` | Bearer refresh token → new pair (rotates refresh token) |
| POST | `/api/auth/logout` | Revokes ALL tokens for the user |
| GET  | `/api/auth/me` | Current user with profile relations |
| PATCH | `/api/auth/profile` | Update name / phone / locale |
| POST | `/api/auth/profile/photo` | multipart `photo` (image, ≤5 MB) → stored on public disk |
| POST | `/api/auth/change-password` | `current_password`, `new_password`, `new_password_confirmation` |
| POST | `/api/auth/forgot-password` | `email` → emails reset link via Password broker |
| POST | `/api/auth/reset-password` | `token`, `email`, `password`, `password_confirmation` |
| POST | `/api/auth/push-token` | Register FCM device token (`{token, platform}`) |

### Sample login

```bash
curl -X POST http://localhost:20141/api/auth/login \
  -H 'Content-Type: application/json' \
  -d '{"email":"admin@school.test","password":"password"}'
```

```json
{
  "access_token": "9|XG6Gut...",
  "refresh_token": "10|AmhWE...",
  "token_type": "Bearer",
  "expires_in": 7200,
  "user": { "id": 1, "name": "Sara Admin", "role": "admin", ... }
}
```

All authenticated calls send `Authorization: Bearer <access_token>` and
`Accept: application/json`.

## Role-scoped surfaces

Each route group is gated by the `role:<role>` middleware. Within a route the
controller adds object-level scoping (e.g. teachers can only act on classes
they actually teach).

### Student (`/api/student/*`, role `student`)
- `GET /dashboard` — upcoming homework, recent grades, today's attendance
- `GET /timetable` · `GET /assignments` · `POST /assignments/{id}/submit` (multipart)
- `GET /grades` — per-subject weighted breakdown
- `GET /attendance` (paginated) · `GET /report-card` · `GET /report-card/pdf`
- `GET /announcements` · `GET /calendar`

### Parent (`/api/parent/*`, role `parent`)
- `GET /children` — only the parent's linked children
- `GET /children/{id}/{overview|grades|assignments|attendance|invoices|payments|conduct}`
- `GET /announcements`

### Teacher (`/api/teacher/*`, role `teacher`)
- `GET /classes` · `GET /timetable` · `GET /classes/{id}/students`
- `POST /assignments` (multipart, multi-class) · `GET /assignments/{id}/submissions`
- `PATCH /submissions/{id}/grade`
- `POST /attendance` — `{class_room_id, subject_id?, date, records: [{student_user_id, status, note?}]}`
- `GET|POST /grade-components/{classId}/{subjectId}` · `POST /grades`
- `POST /conduct` · `POST /announcements`
- `POST /hr-requests` · `GET /hr-requests`

### Admin (`/api/admin/*`, role `admin`)
- Users: `GET|POST /users`, `PATCH /users/{id}`, `DELETE /users/{id}`,
  `POST /users/link-parent`, `POST /users/import-students` (CSV upload)
- Academics: `GET|POST /classes`, `POST /classes/{id}/assign-subject-teacher`,
  `GET|POST /classes/{id}/timetable`, `GET|POST /subjects`, `GET|POST /exams`,
  `GET|POST /academic-years`, `GET|POST /calendar`
- HR review: `GET /hr-requests`, `PATCH /hr-requests/{id}/review`
- Reporting: `GET /dashboard/kpis`, `GET /attendance/dashboard`,
  `GET /reports/monthly`, `GET /audit-logs`
- `POST /announcements` (audience: `all`, `role:<role>`, or `class:<id>`)

### Finance (`/api/finance/*`, role `finance` or `admin`)
- Fee structures: `GET|POST /fee-structures`
- Invoices: `GET /invoices`, `POST /invoices/generate`, `POST /invoices/{id}/payments`,
  `GET /invoices/{id}/receipt-pdf`, `POST /invoices/send-reminders`,
  `GET /outstanding`
- Payroll: `GET /payroll`, `POST /payroll/process`
- Reports: `GET /reports`

### HR (`/api/hr/*`, role `hr` or `admin`)
- `GET /staff`, `GET /staff/{id}`, `PATCH /staff/{id}`
- `GET /leave-requests`, `GET /leave-balances`
- `GET|POST /staff-attendance`, `GET /staff-attendance/report`

### Messaging & notifications (all authenticated roles)
- `GET /messages/threads` · `GET /messages/conversation/{otherId}`
- `POST /messages` — body: `{recipient_user_id, body, about_student_user_id?}`
  Recipient is checked against role-specific messaging policy (e.g. teachers
  may only message students in their classes and those students' parents).
- `GET /notifications` · `GET /notifications/unread-count` · `PATCH /notifications/{id}/read`

## Push notifications

Whenever an in-app notification is created via `App\Services\Notifier::send()`, the
service also POSTs to FCM HTTP API `https://fcm.googleapis.com/fcm/send` for every
device token registered for that user, when `FCM_SERVER_KEY` is set in `.env`.
Failures are logged but never block the in-app record.

## Audit log

`App\Services\AuditLogger::log()` writes a row to `audit_logs` for every
state-changing administrative action (create/update/delete user, payment,
HR review, etc.). Visible to admins via `GET /api/admin/audit-logs`.

## Attendance edit window

Teachers can only create or modify attendance records within
`ATTENDANCE_EDIT_WINDOW_HOURS` (default `48`, configured in `config/school.php`).
After the cutoff `POST /api/teacher/attendance` returns `422` and the records
must be amended by an administrator (admin updates go through the user/class
mutation endpoints, which bypass the teacher window).

## Audit log coverage

`App\Services\AuditLogger::log()` is invoked for every state-changing
administrative or financial action, including:

| Surface | Actions logged |
| ------- | -------------- |
| Auth | `login` |
| Admin users | `create_user`, `update_user`, `deactivate_user`, `bulk_import_students`, `link_parent_student` |
| Admin academics | `create_class`, `assign_subject_teacher`, `create_timetable_entry` |
| Admin HR | `review_hr_request` |
| Teacher | `mark_attendance` |
| Finance | `create_fee_structure`, `generate_invoices`, `record_payment`, `send_fee_reminders`, `process_payroll` |
| HR | `update_staff_profile`, `mark_staff_attendance` |

Visible to admins via `GET /api/admin/audit-logs` (paginated, with relations).

## Package choices (deviations from initial plan)

A few packages from the original wish-list were intentionally skipped to keep
the dependency surface minimal — equivalent functionality is delivered by
first-party Laravel facilities:

| Initially considered | Replacement | Rationale |
| -------------------- | ----------- | --------- |
| `tymon/jwt-auth` | Sanctum personal-access tokens with explicit `*` (access) and `refresh` abilities | Sanctum is Laravel's first-party recommendation for SPA + mobile and provides equivalent semantics; one less moving part. |
| `intervention/image` | Laravel Storage + native `image` validation (`POST /api/auth/profile/photo`) | Uploads are validated, deduplicated per-user, and persisted on the public disk. No on-the-fly transformation is required by the SRS. |
| `brozot/laravel-fcm` | Direct HTTP POST to FCM HTTP API in `App\Services\Notifier` | The package targets a deprecated Firebase Admin SDK; a single `Http::post()` is leaner and easier to swap to FCM v1 later. |

## Database

PostgreSQL is the default connection (`config/database.php` →
`env('DB_CONNECTION','pgsql')`). The `.env.example` wires `DB_*` to the
`PG*` env vars Replit injects automatically.

Schema lives in `database/migrations/2026_04_17_100000_create_school_schema.php`
(30+ tables) plus the personal access tokens migration.
