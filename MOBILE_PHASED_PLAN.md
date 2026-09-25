# School Suite Mobile — Phased Build Plan
## Parent · Teacher · Student

**App:** `school-mobile/` · Flutter · Android only · Arabic-first
**API:** `laravel-api/` · contract at `laravel-api/openapi.yaml`
**Branch:** `mobile/wave-0`

---

## How to use this document

A **phase** is a group of **orders**. Send **one order per agent session** — not a
whole phase. An agent given several orders at once will half-finish most of them
and report success on all.

Every order below is written as a complete, copy-pasteable prompt. Prepend the
**Standing Rules** block to each one.

After every order: run the verification block yourself, read the diff, commit,
then start a fresh session. Never continue a session after an order completes.

---

## STANDING RULES — paste at the top of every order

```
# STANDING RULES (violating any of these fails the task)

1. NEVER modify web authentication: `web-auth.php`,
   `WebCookieAuthenticationTest`, or cookie/CSRF handling in
   `school-web/src/lib/api.ts`. Mobile uses bearer tokens only.
2. NEVER add a route under /api/mobile/v1/* without an authorization test.
   A route without a test is incomplete, not done.
3. NEVER weaken, bypass, or add an exception to: EnsureParentOwnsChild,
   EnsureAccountIsActive, EnsurePasswordChanged, EnsureTokenIsUsable,
   PermissionMiddleware, RoleMiddleware, StudentPolicy.
   If a guard blocks you: STOP and report. Do not route around it.
4. NEVER resolve tenant/school id from a request parameter, header, or any
   client-supplied field. Server-side, from the authenticated token, always.
5. Money is INTEGER MINOR UNITS. JOD has THREE decimals (1 JOD = 1000 fils).
   No double, no float, no decimal(x,2). Use the existing `Money` type in
   `lib/core/i18n/money.dart` — it has no double constructor by design.
6. Every write endpoint accepts an `Idempotency-Key` header and is idempotent.
7. NEVER hand-edit `lib/generated/`. Regenerate from openapi.yaml.
8. NEVER reintroduce `sqlcipher_flutter_libs` or `sqlite3_flutter_libs`.
   Both are end-of-life and inert; adding them yields a build that LOOKS
   encrypted and is not. SQLCipher comes from the package:sqlite3 native-asset
   hook already configured in pubspec.yaml.
9. RTL: `EdgeInsetsDirectional` and `AlignmentDirectional` only. Raw
   `left:`/`right:` is a task failure — invisible in English, broken in Arabic.
10. NEVER log or include in an error: a token, a database key, a payload body,
    or any personal data. Assert it in a test.
11. Do not write a test that asserts `true`, mocks the thing under test, or is
    skipped. A weak test is worse than none: it hides the gap behind a green run.
12. For any concurrency or safety guard, run a NEGATIVE CONTROL: break the
    guard, show the test failing, restore it, show it passing. Report both.
13. No new dependency without stating why in the report.
14. Do not refactor outside scope. Note it and move on.
15. If the order is impossible or the codebase contradicts it, STOP and report
    the contradiction. Do not improvise a substitute.
16. Stop when this order is complete. Begin no other work.

# VERIFICATION — run and paste real output
    cd school-mobile
    flutter analyze --fatal-infos --fatal-warnings
    flutter test
    flutter build apk --flavor dev --dart-define=API_BASE_URL=https://example.test
    cd ../laravel-api && php artisan test
    cd .. && git status --porcelain --untracked-files=all
    git diff --stat

# REPORT — end with exactly these five headings
- **Done** · **Not done** · **Uncertain** · **Contradictions** · **Requests**
"Partially done, blocked on X" is a good report. A confident claim of completion
that does not survive verification is a failed task.
```

---

# PHASE 2 — Complete the foundation

Prerequisite for everything else. Single-threaded.

### Order 2.1 — Backend: delta-sync endpoints

> **Goal.** `openapi.yaml` currently has no cursor, no `since`/`updated_after`
> parameter, and no tombstone shape. `DeltaSync` in `lib/core/sync/` runs against
> a fake. Build the real endpoints.
>
> **In scope.** `GET /api/mobile/v1/sync/delta?since=<cursor>&types=<csv>`
> returning changed entities plus tombstones and a next cursor. Cursor is opaque
> and monotonic. Scoped to what the authenticated user may see — a parent gets
> only their children's entities, a teacher only assigned classes, a student only
> self. Page with a bounded size. Regenerate `openapi.yaml`.
>
> **Out of scope.** Any existing route or controller. `school-web/`. The Flutter
> client.
>
> **Acceptance.** A parent's delta never contains another family's entity
> (assert). A tombstone deletes on the client contract. The cursor is stable
> across identical calls. Query-count ceiling asserted — no N+1. IDOR test for
> every new route. The drift gate passes after regeneration.

### Order 2.2 — Backend: push provider *(blocked until the FCM project exists)*

> **Goal.** FCM adapter, `push:verify {user} {--device=}` command, delivery
> recorded to `NotificationDelivery`.
>
> **In scope.** Categories mapped to `NotificationPreference`: fees, attendance,
> grades, messages, announcements, emergency. **Server-side quiet hours**,
> school-configurable, default 08:00–20:00, with an emergency-only bypass.
> Data-only payloads carrying `{type, deep_link, entity_id}`.
>
> **Acceptance.** Delivers to a real Android device. A push suppressed by quiet
> hours is logged as suppressed, not silently dropped. A push to a revoked
> device fails cleanly and marks the device stale. **No name, national id,
> phone, or amount appears in any payload — assert this in a test.**

### Order 2.3 — Flutter: push client

> **Depends on 2.2.**
>
> **In scope.** `lib/core/push/`: FCM registration bound to the existing device
> id from `lib/core/auth/`, data-only messages rendered locally so Arabic and RTL
> are under app control, deep-link dispatch through `go_router` **including cold
> start with the app killed**, per-category preference sync.
>
> **Acceptance.** A push received with the app terminated opens the correct
> screen. Registration survives token rotation. Revoking the device server-side
> stops delivery. **No PII in any notification body beyond a first name — lock
> screens are public.**

### Order 2.4 — Flutter: router and role shells

> **In scope.** `lib/core/router/`: `go_router` with `ParentShell`, `TeacherShell`,
> `StudentShell` resolved from `roles[]` after login. A role switcher for
> multi-role users — **a teacher whose child attends the school is common, do not
> treat roles as exclusive**. Force-upgrade and soft-upgrade gates driven by
> `min_supported_version` from bootstrap. Deep-link routes registered.
>
> **Acceptance.** Each role lands in its own shell. A two-role user can switch
> without re-login. `force_upgrade: true` blocks the app behind an Arabic upgrade
> screen. An unknown deep link does not crash.

### Order 2.5 — Flutter: shared UI kit

> **In scope.** `lib/shared/`: loading, empty, error-with-request-id, offline
> banner, pending-sync badge, pull-to-refresh, list and detail scaffolds, a
> money-display widget using the existing `Money` type, a date widget honouring
> the digit-shape and Hijri preferences.
>
> **Acceptance.** Every component renders correctly in `ar` and `en`, at 200%
> text scale without clipping, with 48dp minimum tap targets. The error component
> surfaces the server request id so a parent phoning the school can quote it.

**Gate to leave Phase 2:** push delivered end to end; delta sync working against
real endpoints; role shells resolving. Then **freeze** `lib/core/` and
`lib/shared/` — later orders needing changes there file a request in
`docs/mobile/change-requests.md` instead of editing.

---

# PHASE 3 — Authentication

Single-threaded. This is the security boundary.

### Order 3.1 — Login

> **Critical.** The login request **must send `device_id`** from
> `SecureTokenStore`. The server binds refresh-token families to it, and
> `DeviceRegistry.revoke()` kills tokens by that binding. Omit it and remote
> device revocation silently never reaches the mobile session.
>
> **In scope.** `lib/features/auth/`: login screen (Arabic-first, mobile-first),
> credential submission via the generated client, token storage through the
> existing `SecureTokenStore`, error states for wrong credentials, inactive
> account, and lockout — each mapped to the server's actual response.
>
> **Acceptance.** Successful login persists tokens and survives app restart.
> `device_id` present in the request — assert it. Lockout after the server's
> threshold shows an Arabic message, not a raw error. No password in any log.

### Order 3.2 — MFA, forced password change, account state

> **In scope.** Google2FA challenge screen, recovery-code entry, forced password
> change blocking the app exactly as it blocks web, deactivated-account handling.
>
> **Acceptance.** A privileged account cannot proceed past MFA. A temporary
> password blocks every screen until changed. Each honours the existing server
> guards without new exceptions.

### Order 3.3 — Biometric app-lock and device management

> **Biometrics are an app-lock, not authentication.** The token still governs.
> **Never store a password to re-authenticate behind biometrics.**
>
> **In scope.** `local_auth` unlock on resume after a configurable timeout,
> device list screen, remote revoke, and wiring revocation to the existing
> `SessionWipe`.
>
> **Acceptance.** Revoking from another device logs this one out within one
> refresh cycle and wipes local data. Biometric failure falls back to login, not
> to a bypass.

### Order 3.4 — Parent onboarding without passwords

> **Why.** Jordanian parents will not manage a password-reset flow. Every failure
> becomes a phone call to the school office, and the school blames the app.
>
> **In scope.** School-issued invite code, or SMS OTP to the guardian's
> registered number, then a device PIN. Backend endpoints as needed, with rate
> limiting and an audit trail.
>
> **Acceptance.** A parent activates from an invite code without ever typing a
> password. OTP is rate-limited and single-use. An invite code cannot be reused
> or used for a different guardian.

---

# PHASE 4 — Parent app

**Highest business value.** This is the collection surface — the cleared invoice,
the reminder, the payment. It is what moves the collection rate the product is
sold on. Build it before Teacher and Student.

### Order 4.1 — Backend: parent BFF

> **In scope.**
> ```
> GET /api/mobile/v1/session/bootstrap
> GET /api/mobile/v1/parent/home
> GET /api/mobile/v1/parent/children/{id}/overview
> ```
> `bootstrap`: user, roles, children, school theme tokens (reuse the
> `ACCENT_PRESETS` / `FONT_FAMILIES` / `BORDER_RADII` contract from
> `SchoolSettings.tsx`), feature flags, unread count, `min_supported_version`,
> `force_upgrade`.
> `parent/home`: per child — attendance % this week, next installment (minor
> units, due date, days remaining, overdue flag), latest published grade, unread
> count, today's timetable.
>
> **Requirements.** `EnsureParentOwnsChild` on every child-scoped path. ETag +
> `If-None-Match` → 304. **No N+1** — assert a hard query-count ceiling.
> p95 < 400 ms with 5 children.
>
> **Acceptance.** Parent A requesting parent B's child → 403, logged. A parent
> with zero children gets a valid empty payload, not a 500.

### Order 4.2 — Backend: parent finance BFF

> **The most important endpoint set in the app.**
> ```
> GET  /api/mobile/v1/parent/finance/summary
> GET  /api/mobile/v1/parent/children/{childId}/installments
> GET  /api/mobile/v1/parent/invoices
> GET  /api/mobile/v1/parent/invoices/{id}
> POST /api/mobile/v1/parent/pay/{installmentId}/intent   (Idempotency-Key required)
> GET  /api/mobile/v1/parent/receipts/{id}/pdf
> ```
> Reuse `StudentFinanceService`, `Invoice`, `PaymentPlan`, `PaymentReceipt`,
> `Installments`. **Do not reimplement fee logic.**
>
> **Requirements.** All amounts as `{minor, currency, decimals}`. **No float
> anywhere in the path** — assert it. Family-level view: three siblings, one
> guardian, correct per-child allocation. Invoice payload exposes clearance state
> (`pending|cleared|rejected`) and the authority-returned QR **only when
> cleared** — never synthesise one.
>
> **Acceptance.** Five concurrent identical payment intents with the same
> idempotency key produce exactly ONE. Installment amounts sum exactly to the
> invoice total in fils. Another parent's invoice → 403. An uncleared invoice
> never returns a QR field.

### Order 4.3 — Flutter: parent home

> **In scope.** `lib/features/parent/`: home screen, one card per child —
> attendance, next payment with days remaining, latest grade, unread count.
> Cache-first from `LocalCache`, background revalidate. **Skip the child picker
> entirely for single-child parents.**
>
> **Acceptance.** Renders from cache in under one second on a cold start with no
> network. The offline banner appears when connectivity is lost. Pull-to-refresh
> revalidates.

### Order 4.4 — Flutter: fees, payments, invoices

> **The screen that justifies the app to the school owner.**
>
> **In scope.** Balance, installment schedule with due dates and overdue state,
> **pay in three taps maximum**, payment history, receipt detail showing the
> JoFotara-cleared invoice with the **authority-returned QR**, downloadable PDF.
>
> **Requirements.** Idempotency key generated client-side per payment attempt.
> Writes are online-only — never queue a payment to the outbox. Amounts through
> the existing `Money` type only.
>
> **Acceptance.** A tapped payment that times out does not double-charge on
> retry — assert the same key is reused. An uncleared invoice shows its pending
> state honestly and displays no QR. Amounts render at exactly three decimals in
> both locales.

### Order 4.5 — Flutter: attendance, grades, report cards

> **In scope.** Attendance calendar per child with absence and lateness detail
> and an "explain absence" action. Term grades, subject breakdown, report card
> PDF **only when published via `ReportCardIssue`**.
>
> **Acceptance.** Cache-first, works offline with a visible staleness indicator.
> An unpublished report card is not reachable, not merely hidden.

### Order 4.6 — Flutter: notifications, messages, timetable, profile

> **Constraint on messages that an agent must not relax:** threads are
> **teacher-initiated or school-initiated only**, within school-configurable
> hours. Unconstrained parent-initiated chat is how teachers come to hate the
> product and how a pilot dies on staff resistance. This is a product
> requirement, not a limitation to be helpfully removed.
>
> **In scope.** Notification list with per-category preferences (**fees must be
> mutable separately from grades**), message threads, timetable today and week,
> child profile with a request-correction action.
>
> **Acceptance.** Muting grades does not mute fee reminders. A parent cannot
> initiate a thread. Read state syncs with web.

---

# PHASE 5 — Teacher app

Designed around one truth: **classroom wifi is unreliable and a teacher will not
wait.**

### Order 5.1 — Backend: teacher BFF

> ```
> GET  /api/mobile/v1/teacher/today
> GET  /api/mobile/v1/teacher/roster/{classId}
> POST /api/mobile/v1/teacher/attendance/batch   (idempotent)
> POST /api/mobile/v1/teacher/grades/batch       (idempotent)
> ```
> Attendance batch maps to the existing `AttendanceSubmissionBatch`. Grades batch
> respects `GradebookWorkflowService` states.
>
> **Requirements.** Teacher routes scoped to **assigned classes only** — a
> teacher must not read another section's roster. The **attendance edit window**
> is enforced server-side and its state returned to the client.
>
> **Acceptance.** Cross-teacher roster access → 403, logged. A batch replayed
> with the same idempotency key produces one submission. Submitting outside the
> edit window is rejected with a reason the client can display.

### Order 5.2 — Flutter: today and classes

> **In scope.** Today's sessions in order with pending attendance and grade tasks
> surfaced. Class roster with photos, student lookup, contact guardian.
>
> **Acceptance.** Renders from cache offline. Pending tasks reflect actual outbox
> state, not a guess.

### Order 5.3 — Flutter: offline attendance

> **The most-used screen in the product.**
>
> **In scope.** Open a roster and mark a full class in **under 30 seconds**.
> Default all-present with exception marking, ≥48dp targets, swipe gestures.
> **Fully offline** — queues to `LocalOutbox`, syncs via the existing
> `OutboxDrainer`. Shows the edit-window state honestly and clearly when it has
> closed.
>
> **Acceptance.** A full class marked and queued in airplane mode; restoring
> connectivity submits exactly once. **Pending is displayed as pending — never
> as saved.** A rejected submission tells the teacher what was rejected and why;
> it is never silently dropped.
>
> **Before this ships: time a real teacher marking a real class against paper
> with a stopwatch.** If the app is not faster, it will not be adopted, and no
> amount of polish fixes that.

### Order 5.4 — Flutter: grade entry

> **In scope.** Per-`GradeComponent` entry, fully offline, surfacing the workflow
> state machine honestly: draft, submitted, locked.
>
> **Acceptance.** A queued grade is never displayed as saved. A conflict — the
> server state moved — produces a visible, explained conflict, never silent data
> loss. **Server wins**, and the teacher is told.

### Order 5.5 — Flutter: assignments and announcements

> **In scope.** Create assignment with file attach, publish, view submission
> status. Announcements to a class or a guardian from approved templates.
>
> **Acceptance.** File upload resumes or fails visibly — never silently. An
> announcement cannot reach a guardian outside the school's configured hours.

---

# PHASE 6 — Student app

**Scope: grade 7 and above only** unless the pilot school's under-13 policy is
decided otherwise. Younger children are reached through the parent app. Primary-
grade student accounts require a parental-consent module — a two-sprint addition,
not a checkbox.

### Order 6.1 — Backend: student BFF

> ```
> GET /api/mobile/v1/student/home
> GET /api/mobile/v1/student/timetable
> GET /api/mobile/v1/student/assignments
> GET /api/mobile/v1/student/grades
> GET /api/mobile/v1/student/attendance
> ```
> **Every route scoped to self only.** Cross-student access is the highest-risk
> case in the entire mobile surface — assert it for every route.

### Order 6.2 — Flutter: student screens

> **In scope.** Home, timetable, assignments with submission upload, grades,
> attendance, announcements. All read-only except submission upload.
>
> **Excluded, and NOT negotiable by an agent:** student-to-student messaging, any
> social feature, any peer-visible ranking or leaderboard. Each is a safeguarding
> surface and a moderation obligation nobody here is staffed to carry. If the
> order seems to invite one, it does not — report and stop.
>
> **Acceptance.** A student cannot reach another student's record by any route.
> Submission upload is idempotent and shows its state honestly.

---

# PHASE 7 — Integration, hardening, release

| Order | Scope | Acceptance |
|---|---|---|
| 7.1 | Cross-role integration, role switcher, cache coherence, session edge cases | A teacher-parent switches roles without data bleeding between shells |
| 7.2 | Offline chaos: mid-sync kill, clock skew, storage full, conflict UX | No queued write is lost in any scenario |
| 7.3 | Performance | Cold start < 2s, home render < 1s **on a 3-year-old mid-range Android over throttled 3G** — not an emulator |
| 7.4 | Accessibility | Arabic screen-reader labels, 48dp targets, 200% text scale without clipping |
| 7.5 | Security | PII scrubbing audit, `FLAG_SECURE` on finance and student-record screens, certificate pinning **with a documented rotation plan** so a cert change does not brick installed apps |
| 7.6 | Play Store | Listing, Arabic screenshots, privacy policy, **Data Safety form**, content rating, signing |
| 7.7 | Pilot support | Request-id on error screens, diagnostics export, remote feature flags |

**The Data Safety form is not paperwork.** It declares what children's data the
app collects, and it must match what the app does and what the DPA says. An
inconsistency there is a compliance problem, not a store problem.

---

## What gets cut if the timeline compresses

In order: student app → parent messaging → teacher assignments →
conduct/medical/library/transport screens.

**Never cut:** the fees and payments screen, offline attendance, the IDOR gate,
PII scrubbing, and Arabic RTL correctness. Those are the product.

---

## Standing blockers

| # | Item | Blocks |
|---|---|---|
| 1 | **Google Play organization account + D-U-N-S** — 2–4 weeks, not started | The release itself |
| 2 | **FCM project + service-account key** — 20 minutes, not started | Orders 2.2 and 2.3 |
| 3 | Play policy on school fee payments vs Play Billing | Order 4.4 architecture |
| 4 | Under-13 student account policy | Phase 6 scope |

Item 1 has the longest lead time in the project and cannot be accelerated later.
