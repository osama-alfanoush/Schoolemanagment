# Mobile App Implementation Plan

## Parent · Teacher · Student — School Management Suite

**Grounded in:**`GRAPH_REPORT.md` (commit `a7f4c66a`, 4,439 nodes / 10,894 edges / 653 files). **Companion docs:**`master-plan-10k-school-jordan-gulf.md` (strategy), `implementation-plan-be-first.md` (backend/product). **Horizon:** 14 weeks to a parent app in production, 20 weeks to all three roles.

---

## 0. What the graph tells us before we write anything

I read the graph specifically for mobile-readiness. The headline is good: **your backend is roughly 80% ready for these apps already.** That changes the plan from "build a mobile platform" to "expose and harden what exists."

### 0.1 Already built — reuse, don't rebuild


| Capability                                      | Evidence in the graph                                                                                                                                                | Mobile relevance                                                                    |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| Token auth for non-browser clients              | `AuthController`↔`PersonalAccessToken`,`TokenIssuer`,`Laravel\Sanctum\PersonalAccessToken`,`EnsureTokenIsUsable`                                                    | The mobile auth path exists in skeleton form                                        |
| Push infrastructure                             | `PushToken`(Community 42),`DeviceToken`(Community 76)                                                                                                                | Device registration already modelled                                                |
| Parent→child authorization                     | `EnsureParentOwnsChild`middleware,`ParentController`,`ParentStudentLinkTest`                                                                                         | The single most important guard for a parent app is already written and tested      |
| Notification pipeline                           | `NotificationService`,`NotificationTemplate`,`NotificationPreference`,`NotificationDelivery`,`NotificationReceived`(ShouldBroadcast),`ProcessScheduledNotifications` | Templates, per-user preferences, delivery tracking and scheduling all exist         |
| Batch attendance                                | `AttendanceSubmissionBatch`,`AttendanceService`, "Attendance edit window"                                                                                            | Exactly the shape an offline teacher app needs                                      |
| Gradebook workflow                              | `GradebookController`,`GradebookWorkflowService`,`Gradebook`,`GradeComponent`,`ReportCardIssue`                                                                      | Teacher grade entry has a real state machine behind it                              |
| Assignments + submissions                       | `Assignment`,`Submission`,`AssignmentService`,`FileController`(`StreamedResponse`)                                                                                   | Student app has a backend already                                                   |
| Student finance                                 | `StudentFinanceService`,`Invoice`,`PaymentPlan`,`PaymentReceipt`,`Installments`,`InstallmentReminderService`                                                         | The parent app's most valuable screen is backed                                     |
| Timetable, conduct, medical, transport, library | `TimetableEntry`,`ConductLog`,`MedicalRecord`/`MedicalVisit`,`TransportRoute`/`TransportStop`,`LibraryBorrowing`                                                     | Phase-2 screens need no new backend                                                 |
| Security posture                                | `IdorTest`,`RateLimitTest`,`AuditLogger`,`PermissionMiddleware`,`RoleMiddleware`,`StudentPolicy`, MFA via`Google2FA`,`AccountLockout`,`AssignRequestId`              | You already take IDOR seriously — critical, because mobile multiplies that surface |

### 0.2 Three findings you should act on before sprint 1

**Finding 1 — `PushToken` and `DeviceToken` are two different models in two different communities.**`PushToken` sits with `AuthController`/`PersonalAccessToken` (Community 42); `DeviceToken` sits with `NotificationController`/`NotificationPreference` (Community 76). That is almost certainly two competing implementations of the same concept, written at different times. **Pick one, migrate the other, delete it — in sprint 1.** If you ship a mobile app on top of a fork in device identity, you will get duplicate pushes, silent delivery failures, and a revocation path that misses half the devices.

**Finding 2 — the web app authenticates by cookie.**`WebCookieAuthenticationTest`, `web-auth.php`, and the CSRF handling in `api.ts` (`ensureCsrfToken()`) confirm the browser path is session-cookie based. The mobile app must use the Sanctum **token** path exclusively. These are two different security models with different revocation, expiry and CSRF semantics, and they must be tested separately. Do not let the mobile client borrow cookie assumptions.

**Finding 3 — `User` is a god object.** 331 edges, betweenness 0.081, and the graph itself flags 202 *inferred* edges on `User` that need verification. Mobile auth, device binding, push preferences and role resolution all attach to `User`. Before you add three more mobile concerns to it, extract at least `UserDevices` and `UserNotificationPreferences` into their own aggregates. Otherwise every mobile change becomes a merge conflict with every other change.

### 0.3 The real gaps

Missing, and each is a work item below: a mobile-shaped API layer (BFF), token refresh/rotation, an OpenAPI contract, offline sync, deep links, and a verified push provider (your release notes list external providers as unverified and disabled).

---

## 1. Strategy: which app, and in what order

I recommended in the previous plan that you defer native apps. That advice stands **for the teacher and student apps** — but the **parent app is a different case, and I'd now build it first.**

Here's why. The parent app isn't an engagement feature; it's the **collection surface.** Every element of the finance strategy terminates in a parent's hand: the cleared invoice with its authority QR, the installment reminder, the one-tap payment link, the receipt. A parent app that shows "you owe JOD 450, due in 6 days, pay now" and completes the payment in three taps is not a nice-to-have — it is the mechanism that moves the collection rate, which is the number that renews your contract at full price.

**Build order, and the reasoning:**


| Order | App         | Why here                                                                                                        | Willingness to pay      |
| ----- | ----------- | --------------------------------------------------------------------------------------------------------------- | ----------------------- |
| **1** | **Parent**  | Carries the money. Drives collection rate. Highest visibility to the owner who signs                            | Very high (school pays) |
| **2** | **Teacher** | Removes the daily paper-and-Excel pain. Wins the staff over, which prevents the pilot from stalling on adoption | High                    |
| **3** | **Student** | Lowest revenue impact, highest support burden, most likely to need content you deliberately deferred (LMS)      | Low                     |

**Do not build all three in parallel.** Ship the parent app to a real school, learn from real Android phones on real Jordanian mobile networks, then build the teacher app with what you learned.

### 1.1 One app or three?

**One codebase, one binary, role-aware shell.** Not three apps.

Reasons: a parent is sometimes also a teacher at the same school; one release pipeline instead of three; store listings and reviews concentrate instead of fragmenting; and shared infrastructure (auth, push, offline, i18n, theming) is 60% of the work regardless of role. The role shell switches after login based on the user's roles, with a role switcher for multi-role users.

**Exception worth considering later:** if the teacher app grows heavy offline machinery, split it. Not before.

### 1.2 White-labelling — the trap

Schools will ask for their own logo in the store. Building per-school branded binaries means per-school app store accounts, per-school review cycles, per-school release management, and a support matrix that grows linearly with customers. For a solo or two-person team that is fatal.

**Phase 1:** one branded app, school selected at login, school logo and accent colour themed **inside** the app. Your `SchoolSettings.tsx` already carries `ACCENT_PRESETS`, `FONT_FAMILIES` and `BORDER_RADII` — reuse that theming contract for mobile so a school's identity is server-driven, not build-driven.

**Phase 2 (paid add-on, priced separately as in the pricing plan):** Flutter flavors + Fastlane + a per-school build pipeline. Charge properly for it, because it costs you real ongoing time.

---

## 2. Technology choice

**Recommendation: Flutter.**

It's your professional strength, which matters more than any framework benchmark — you will ship faster and debug better in Dart than in anything else. Flutter's RTL support is genuinely first-class (`Directionality`, logical `EdgeInsetsDirectional`, mirrored icons), which is not a small thing when the entire UI is Arabic. And a single codebase covers the Android-dominant Jordanian market plus iOS for the private-school parent demographic that skews toward iPhone.

**The honest cost:** your web app has a large shared type surface — `api.types.ts` is a 153-node community. React Native would let you reuse those TypeScript types directly. Flutter means maintaining a second type layer in Dart.

**The mitigation, and it's mandatory:** make **OpenAPI the single source of truth**, not either client.

```
laravel-api  ──generates──>  openapi.yaml  ──generates──>  Dart models + client (openapi-generator / swagger_dart_code_generator)
                                   └────────generates────>  TypeScript types (replacing hand-written api.types.ts drift)
```

Generate the spec from Laravel (Scramble or L5-Swagger with typed request/resource classes). A contract test in CI asserts the spec matches the routes. Both clients regenerate from it. This turns "two type layers" from a permanent tax into a build step, and it fixes the drift risk in `api.types.ts` at the same time.

**Core Flutter stack:**


| Concern             | Choice                               | Note                                                      |
| ------------------- | ------------------------------------ | --------------------------------------------------------- |
| State               | Riverpod                             | Testable, no BuildContext coupling, good async primitives |
| Navigation          | go\_router                           | Needed for deep links and push-notification routing       |
| Local DB            | Drift (SQLite)                       | Typed queries, migrations, works for the offline outbox   |
| Secure storage      | flutter\_secure\_storage             | Keychain / EncryptedSharedPreferences for tokens only     |
| HTTP                | Dio + generated client               | Interceptors for auth, refresh, retry, request-id         |
| Push                | firebase\_messaging (FCM) + APNs     | Verify the provider first (see §5.4)                     |
| Local notifications | flutter\_local\_notifications        | Foreground presentation, scheduled reminders              |
| Biometrics          | local\_auth                          | App unlock, not primary auth                              |
| i18n                | flutter\_localizations + ARB         | Arabic default, English secondary                         |
| Fonts               | IBM Plex Sans Arabic or Tajawal      | Bundle it — do not rely on system Arabic fonts           |
| Crash/perf          | Sentry (you already run`sentry.php`) | With PII scrubbing, see §5.5                             |

**Minimum Android API 24, iOS 14.** Jordanian private-school parents include a long tail of older Android devices; test on a 3-year-old mid-range device, not an emulator.

---

## 3. The mobile BFF — do not skip this

If the app builds its home screen by calling eight endpoints, it will feel broken on a 3G connection in Irbid. Add a versioned mobile aggregate layer:

```
/api/mobile/v1/session/bootstrap      → user, roles, children, school theme, feature flags, unread count
/api/mobile/v1/parent/home            → per-child summary: attendance %, next payment, unread, today's timetable
/api/mobile/v1/parent/children/{id}/overview
/api/mobile/v1/parent/finance/summary → balance, next installment, arrears state
/api/mobile/v1/parent/invoices        → list, with cleared status + authority QR payload
/api/mobile/v1/parent/pay/{installment}/intent
/api/mobile/v1/teacher/today          → sessions, classes, pending attendance, pending grade entry
/api/mobile/v1/teacher/roster/{classId}
/api/mobile/v1/teacher/attendance/batch   (POST, idempotent — maps to AttendanceSubmissionBatch)
/api/mobile/v1/teacher/grades/batch       (POST, idempotent)
/api/mobile/v1/student/home
/api/mobile/v1/sync/delta?since=<cursor>  → changed entities for offline caches
/api/mobile/v1/devices                     (POST/DELETE — unified device registration)
```

**Rules for this layer:**

1. **Versioned from day one.**`v1` in the path. Mobile clients live on users' phones for years; you cannot force-upgrade everyone.
2. **Every response carries an ETag.** The app sends `If-None-Match`; a `304` on the home screen costs almost nothing on a metered connection.
3. **Every write endpoint accepts an `Idempotency-Key` header.** A teacher on a flaky classroom connection will retry. Attendance must not double-submit.
4. **Aggregate server-side, not client-side.** One round trip per screen.
5. **Minimum-supported-version gate.** The bootstrap response can return `force_upgrade` or `soft_upgrade` so you can retire a broken client.
6. **`AssignRequestId` propagates to mobile.** Send the request id back in the response header, log it in the client, show it on error screens. When a parent calls the school, the accountant reads you a request id instead of "it doesn't work."

---

## 4. Feature scope by role

### 4.1 Parent app — MVP (phase 1)

The screens, in priority order:

1. **Home** — one card per child: attendance this week, next payment due with days remaining, latest grade, unread messages. If the parent has one child, skip the picker entirely.
2. **Fees & Payments***(the reason this app exists)* — current balance, installment schedule with due dates, **pay now** in three taps, full payment history, and each receipt showing the **JoFotara-cleared invoice with the authority-returned QR**. Downloadable PDF. This screen alone justifies the app to the school owner.
3. **Attendance** — calendar view per child, absence and lateness detail, and an "explain absence" action that reaches the school.
4. **Grades & report cards** — term grades, subject breakdown, report card PDF when `ReportCardIssue` marks it published.
5. **Notifications** — backed by `NotificationService`/`NotificationDelivery`, with per-category preferences from `NotificationPreference`. Read state syncs with web.
6. **Messages** — threaded conversation with the homeroom teacher and the administration. Backed by `Message`. **Constrain it:** teacher-initiated or school-initiated threads only, with school-configurable hours. An unconstrained parent-teacher chat is how teachers come to hate your product.
7. **Timetable** — today and the week, from `TimetableEntry`.
8. **Child profile** — enrollment status, class, homeroom teacher, transport route, and guardian contact details the parent can request corrections to.

**Phase 2:** conduct log (`ConductLog`), medical visits (`MedicalRecord`/`MedicalVisit` — with explicit consent gating), library borrowings, transport stop and route, absence request submission, re-enrollment acceptance and deposit payment (ties directly to the admissions module).

**Explicitly out:** live bus GPS, canteen wallet, chat with other parents, social feed.

### 4.2 Teacher app — MVP (phase 2)

Designed around one truth: **classroom wifi is unreliable, and a teacher will not wait.**

1. **Today** — my sessions, in order, with a one-tap entry into each.
2. **Attendance — offline-first.** Open a roster, mark everyone in under 30 seconds, works fully with no network, queues locally, syncs when connectivity returns. Default all-present with exception marking, big touch targets, swipe gestures. Respects the "Attendance edit window" rule from the backend, and shows clearly when the window has closed. Maps to `AttendanceSubmissionBatch`.
3. **Grade entry** — offline-first, per assessment component (`GradeComponent`), with the `GradebookWorkflowService` state machine surfaced honestly: draft, submitted, locked. Never let the app imply a grade is saved when it's queued.
4. **My classes** — roster with photos, quick student lookup, contact the guardian.
5. **Assignments** — create, attach a file, publish, view submission status via `Assignment`/`Submission`.
6. **Announcements & messages** — to a class or a guardian, from approved templates.

**Phase 3:** conduct log entry, substitution notices, leave requests (`HrRequest`), payslips (`PayrollRun` — genuinely popular and cheap to add), staff attendance.

### 4.3 Student app — MVP (phase 3)

Timetable · assignments and submission upload · grades · attendance record · announcements · library borrowings.

**Deliberately excluded:** messaging between students, any social feature, any peer-visible ranking or leaderboard. Every one of those is a safeguarding surface and a moderation obligation you are not staffed to carry. Student-to-teacher messaging only, and only if the school explicitly enables it.

**Age gating:** if the school enrolls under-13s, the student app needs parental consent flows and a reduced data footprint. Simplest defensible position for phase 1: **student accounts for secondary grades only**, younger children reached through the parent app. Decide this with the pilot school and write it into the DPA.

---

## 5. Cross-cutting engineering

### 5.1 Authentication and session

```
POST /api/mobile/v1/auth/login        → {access_token (short-lived), refresh_token (rotating), user, roles, mfa_required}
POST /api/mobile/v1/auth/mfa/verify   → completes the Google2FA challenge
POST /api/mobile/v1/auth/refresh      → rotates; old refresh token immediately invalidated (detect reuse → revoke family)
POST /api/mobile/v1/auth/logout       → revokes this device's tokens and its push registration
GET  /api/mobile/v1/auth/devices      → list; DELETE to revoke remotely
```

* Sanctum PATs are long-lived by default. For mobile, issue a **short-lived access token plus a rotating refresh token**, with reuse detection. `TokenIssuer` is the right place for this.
* **Device binding:** every token bound to a device id; revoking a device kills its tokens *and* deregisters push in one operation. This is only possible once you've resolved the `PushToken`/`DeviceToken` split.
* Honour the existing guards: `EnsureAccountIsActive`, `EnsurePasswordChanged`, `EnsureTokenIsUsable`, `AccountLockout`. A forced password change must block the app the same way it blocks the web.
* **Biometric unlock is an app-lock, not authentication.** The token still governs. Never store a password to re-authenticate behind biometrics.
* **Parent onboarding without passwords:** school-issued invite code or SMS OTP to the guardian's registered number, then set a PIN. Jordanian parents will not manage a password reset flow, and every failure becomes a phone call to the school office — which the school will blame on you.

### 5.2 Authorization — the IDOR surface

A mobile app multiplies your object-reference surface. The graph shows you already have `IdorTest`; **extend it to cover every single mobile endpoint** as a hard CI gate.

* `EnsureParentOwnsChild` on every child-scoped mobile route. No exceptions, no "this one's internal."
* Teacher routes scoped to assigned classes only — a teacher must not read another section's roster.
* Student routes scoped to self.
* Tenant id resolved server-side from the token. Never from a request field.
* Prefer opaque or hashed public ids over sequential integers in mobile responses.
* A test that enumerates every `/api/mobile/v1/*` route and asserts an authorization test exists. **New route without one fails the build.**

### 5.3 Offline and sync

Mirror your server-side outbox pattern on the device:

```dart
// Drift schema
LocalOutbox: id, endpoint, method, payloadJson, idempotencyKey (unique),
             status, attempts, lastError, createdAt, syncedAt
LocalCache:  entityType, entityId, payloadJson, syncCursor, fetchedAt
```

* **Reads:** cache-first with background revalidation. The home screen renders instantly from cache and refreshes underneath.
* **Writes:** enqueue locally with a client-generated idempotency key, show optimistic state clearly marked as pending, sync on connectivity, surface conflicts explicitly.
* **Conflict policy:** server wins for grades and attendance (the backend has business rules like the edit window that the client cannot evaluate). The app must show the user plainly when their queued change was rejected and why. Silent data loss in a gradebook will end a pilot.
* **Delta sync:**`/sync/delta?since=<cursor>` returning changed entities plus tombstones.
* **Cache TTL and eviction:** cap the local DB; evict old terms.

### 5.4 Push notifications

**Prerequisite:** your release notes list external providers as unverified and disabled. Verify FCM and APNs end-to-end in production configuration **before** sprint 1 of the app, not during it.

* One unified device registry (post-merge of `PushToken`/`DeviceToken`).
* Categories mapped to `NotificationPreference`: fees, attendance, grades, messages, announcements, emergencies. Parents must be able to mute grades without muting fee reminders.
* **Data-only messages** carrying a deep link, rendered locally — so you control Arabic formatting and RTL rather than depending on the OS.
* **Quiet hours enforced server-side**, matching the collections engine guardrails. A fee reminder at 23:00 is a complaint to the principal.
* Deep links: `schoolapp://child/{id}/finance`, `/attendance`, `/message/{threadId}` — routed through go\_router, with a cold-start path that survives the app being killed.
* Delivery tracking written back to `NotificationDelivery` so the school can prove a notice was delivered.
* **Never put PII in the notification body** beyond a first name. Lock screens are public.

### 5.5 Privacy and safeguarding on device

You are shipping children's data onto parents' and teachers' phones, under a data protection law that applies in full.

* Tokens in Keychain/EncryptedSharedPreferences only. Cached PII in an **encrypted** SQLite database with a key held in secure storage.
* `FLAG_SECURE` on financial and student-record screens (blocks screenshots and hides content in the app switcher).
* Scrub PII from Sentry: no names, national ids, phone numbers, amounts, or request bodies. Your `errorReporting.ts` already establishes the pattern — port the redaction rules, don't reinvent them.
* Full local wipe on logout, on remote device revocation, and on token-reuse detection.
* Certificate pinning on the API domain, with a documented rotation plan so a certificate change doesn't brick every installed app.
* Root/jailbreak detection as a warning for teacher accounts, not a hard block.
* Arabic privacy notice and consent screens **inside the app**, with consent recorded server-side and provenance retained.

### 5.6 Arabic, RTL and localisation

* Arabic is the **default**, English secondary. Not the reverse.
* `Directionality` at the root; `EdgeInsetsDirectional` and `AlignmentDirectional` everywhere. Ban raw `left`/`right` in code review.
* Bundle the Arabic font. System Arabic rendering varies badly across Android OEMs and older devices.
* Arabic-Indic numerals (٠١٢٣) as a **user preference** — older parents strongly prefer them, younger ones don't. Get it wrong for either and the app feels foreign.
* **JOD is 3-decimal.** Format with `intl` and the locale, never string concatenation. Money bugs on the payment screen are the worst possible first impression.
* Mixed bidi text — an Arabic name next to a Latin invoice reference next to a number — is where RTL layouts actually break. Build a fixture screen full of these cases and check it every sprint.
* Hijri dates alongside Gregorian where the school configures it.

---

## 6. Sprint plan

Two-week sprints. Assumes you plus one Flutter contractor. Solo, add 50%.


| Sprint  | Weeks  | Focus                                                                                                                                                                 | Ship gate                                                                 |
| ------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| **M0**  | Wk 0   | Merge`PushToken`/`DeviceToken`. Verify FCM + APNs end to end. Generate`openapi.yaml`from Laravel with a CI contract test. Extract`UserDevices`off the`User`god object | One device registry; spec generates; push proven in prod config           |
| **M1**  | 1–2   | Mobile BFF v1: bootstrap, parent home, finance summary. Token refresh + rotation + device binding. IDOR tests for every new route                                     | Postman/HTTP suite green; IDOR gate enforced in CI                        |
| **M2**  | 3–4   | Flutter skeleton: auth, MFA, biometric lock, role shell, Arabic/RTL theming from server config, Drift cache, Dio interceptors, deep-link routing                      | Login → home renders from cache in < 1s on a 3-year-old Android          |
| **M3**  | 5–6   | Parent:**Fees & Payments**— schedule, balance, pay flow, receipts with the cleared-invoice QR, PDF                                                                   | End-to-end payment on a real device against staging                       |
| **M4**  | 7–8   | Parent: attendance, grades, report cards, notifications with preferences                                                                                              | Push delivered, deep-linked, quiet hours respected                        |
| **M5**  | 9–10  | Parent: messages (constrained), timetable, child profile. Store readiness: listings, Arabic screenshots, privacy labels, review submission                            | Both stores accept the build                                              |
| **M6**  | 11–12 | Pilot hardening: crash-free rate, performance on real networks, support tooling, request-id surfacing, force-upgrade gate                                             | Crash-free sessions > 99.5% over 2 weeks                                  |
| **M7**  | 13–14 | **Parent app live at the pilot school**, with onboarding materials in Arabic. Measure adoption and payment completion                                                 | ≥ 60% of families activated within 30 days                               |
| **M8**  | 15–16 | Teacher: offline engine (Drift outbox, delta sync, conflict UX), Today, offline attendance                                                                            | Attendance markable and syncable with airplane mode on for a full session |
| **M9**  | 17–18 | Teacher: grade entry with workflow states, classes, assignments, announcements                                                                                        | Teacher completes a full day without touching the web app                 |
| **M10** | 19–20 | Student app (secondary grades only), consent and age gating, store release                                                                                            | Pilot school signs off on the safeguarding position                       |

---

## 7. Definition of Done for mobile

1. Works fully offline where specified, with pending state visibly marked.
2. Every write is idempotent and survives a forced network kill mid-request.
3. Arabic RTL verified on a real device, including bidi fixtures and Arabic-Indic numerals.
4. Authorization test exists for every touched endpoint; IDOR gate passes.
5. No PII in logs, crash reports, or notification bodies.
6. Renders acceptably on a 3-year-old mid-range Android over a throttled 3G profile.
7. Screen reader labels present (Arabic), tap targets ≥ 48dp, text scales to 200% without clipping.
8. Failure path designed: what an Arabic-speaking parent sees when it breaks, and what they can do.
9. Generated from `openapi.yaml` — no hand-written model that could drift.

---

## 8. Risks


| Risk                                | Impact                                                                               | Mitigation                                                                                                                                                                                                                                                          |
| ----------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| App store payment policy on tuition | Rejection, or a 15–30% cut                                                          | **Verify before M3.**Real-world services are generally outside the in-app-purchase requirement, but confirm current Apple and Google policy directly and get it in writing before building the pay flow. This is the single highest-consequence unknown in the plan |
| Parent activation stalls below 40%  | The collection-rate improvement never materialises, and T8 in the backend plan fails | Invite codes handed out at fee-payment time; the WhatsApp reminder deep-links into the app; school-office assisted onboarding during the first week                                                                                                                 |
| Offline sync corrupts grades        | Loss of teacher trust, pilot ends                                                    | Server wins; explicit conflict UI; never silent; heavy property testing on the sync engine                                                                                                                                                                          |
| Store review cycles block a hotfix  | Days of downtime on a broken release                                                 | Server-driven feature flags and force-upgrade gate; keep business logic server-side so most fixes ship without a store round trip                                                                                                                                   |
| White-label demands from school #2  | Unbounded release overhead                                                           | In-app theming in phase 1; white-label as a separately priced add-on with an explicit build-slot limit                                                                                                                                                              |
| Two more clients to keep in sync    | Drift, bugs, slower delivery                                                         | OpenAPI as the single source of truth, enforced by a CI contract test                                                                                                                                                                                               |
| Teacher rejection                   | Adoption failure regardless of quality                                               | Ship the teacher app only after attendance is genuinely faster than paper. Time it with a stopwatch against a real teacher before release                                                                                                                           |

---

## 9. What I'd cut if the timeline compresses

In order of what goes first: student app → parent messaging → teacher assignments → conduct/medical/library/transport screens → iOS (Android-only launch is defensible in Jordan for a first pilot).

**What never gets cut:** the fees and payments screen, offline attendance, the IDOR gate, PII scrubbing, and Arabic RTL correctness. Those four are the product.

---

## 10. Open questions

1. Does the pilot school enroll under-13s, and what's their position on student accounts? This decides §4.3.
2. Is `PushToken` or `DeviceToken` the one you keep — and is either currently in production use with live registrations to migrate?
3. Is Sanctum PAT expiry currently configured, or are tokens unbounded? Determines how much of §5.1 is new work versus configuration.
4. Do you have an Apple Developer account and a Google Play account under a registered entity? Both need a legal entity and can take weeks.
5. Flutter contractor, or solo? The sprint plan doubles in length if solo.

---

*Say the word and I'll produce the Arabic version of this plan, or expand any single sprint into a task-level backlog an agent can execute.*
