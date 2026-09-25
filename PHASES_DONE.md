# Phases Done

Progress against [MOBILE_PHASED_PLAN.md](MOBILE_PHASED_PLAN.md).
Branch: `mobile/wave-0`.

One entry per order. An order is listed here only after its verification block
ran clean and the commit landed.

---

## PHASE 2 — Complete the foundation

**Status: 3 of 5 orders done. Not complete — 2.2 and 2.3 are blocked on the FCM
project, which is standing blocker #2 in the plan and cannot be created from
inside this repo.**

The plan's gate for leaving Phase 2 is *push delivered end to end, delta sync
working against real endpoints, role shells resolving*. Two of those three are
met. `lib/core/` and `lib/shared/` are therefore **not yet frozen**.

### Order 2.1 — Backend: delta-sync endpoints ✅

`1b25fd9` · `GET /api/mobile/v1/sync/delta?since=&types=&limit=`

- Cursor is opaque, signed with the app key, bound to the user and school it
  was issued for, and can only move forward. Encoding identical positions
  yields an identical string, so two identical calls return the same cursor.
- Pagination is a per-stream keyset on `(updated_at, id)`, not an offset, so a
  concurrent write cannot make the feed skip or repeat a row.
- Deletions are recorded to a new `sync_tombstones` table on the Eloquent
  `deleted` event, carrying the scope keys captured at deletion time.
- Eight entity types: attendance, grades, assignments, timetable, invoices,
  installments, announcements, notifications. Finance types are absent from the
  teacher and student sets entirely.
- Money leaves as `{minor, currency, decimals}` at JOD's three decimals, via
  string arithmetic.

Verified: 25 feature tests + 13 unit tests, 515 backend tests green, contract
regenerated and idempotent, Redocly lint clean, Dart client regenerated and
deterministic.

**Negative control:** removing the student scope from
`DeltaEntityRegistry::attendanceRecord` made two IDOR tests fail (a parent saw
another family's record, a student saw a classmate's); restoring it made them
pass.

### Order 2.2 — Backend: push provider ⛔ BLOCKED

Blocked on **standing blocker #2: FCM project + service-account key**. Not
started. Needs a Firebase project and a downloaded service-account JSON before
any of it can be written honestly — an FCM adapter with no project to send to
cannot be verified, and its acceptance criterion is delivery to a real Android
device.

### Order 2.3 — Flutter: push client ⛔ BLOCKED

Depends on 2.2.

### Order 2.4 — Flutter: router and role shells ✅

`616c106` · `lib/core/router/`, `lib/core/session/`

- `go_router` with a `StatefulShellRoute.indexedStack` per role, so a
  half-marked roster survives a trip to another tab.
- Roles are not exclusive. A teacher whose child attends the school holds both
  and switches between them without signing in again — switching never touches
  the token.
- A deep link into a role the user does not hold lands on their own home. An
  unrecognised link shows a not-found screen with a way out, and does not crash.
- A link opened before the token store has been read is remembered rather than
  discarded, so a push tapped on a cold start still arrives.
- `force_upgrade`, or a build below `min_supported_version`, pins the app to an
  Arabic upgrade screen nothing navigates past. A version merely behind gets a
  dismissible banner. An unparseable version from the server *disables* the
  gate rather than closing it.
- Screens are injected through `AppScreens`, so later orders fill in the
  parent, teacher and student screens without editing `lib/core/router/`.

Verified: 19 session tests + 19 router widget tests, both locales, RTL, 200%
text scale.

**Negative control:** removing the held-role check from the redirect let a
parent deep-link into `/teacher/classes/9/attendance`; restoring it sent them
home.

### Order 2.5 — Flutter: shared UI kit ✅

`a595279` · `lib/shared/`

- Loading, empty, error, offline banner, staleness label, pending-sync badge,
  pull-to-refresh, list and detail scaffolds, `MoneyText`, `DateText`,
  `ValueRow`.
- The error view surfaces the server's request id, labelled and copyable, and
  keeps it Latin and unshaped under the Arabic-Indic digit preference so it
  still matches the logs.
- `MoneyText` takes a `Money` and nothing else. `DateText` reads the digit
  shape and Hijri flag from `AppI18nScope` rather than taking them as
  arguments.
- `ValueRow` exists because `ListTile` throws when a three-decimal amount sits
  in `trailing` at 200% text scale — which is the shape of every fee row in the
  app.
- Pull-to-refresh is attached over the empty and error states too.

Verified: 29 widget tests in `ar` and `en`, at 200% text scale, with 48dp tap
targets asserted by measurement.

**Negative control:** disabling the stacking in `ValueRow` left the amount
beside its label at 200%; restoring it moved the amount below.

---

## PHASE 3 — Authentication

**Status: complete. All 4 orders done.**

### Order 3.1 — Login ✅

`724c35e` · `school-mobile/lib/features/auth/`

- `device_id` travels with every login and **the request is not sent without
  one**. `DeviceRegistry.revoke()` kills refresh-token families by that
  binding, so a session established without it could never be revoked
  remotely — failing the attempt beats creating one nobody can end.
- The request body is built through the generated `AuthLoginRequest`, so its
  shape stays bound to `openapi.yaml`. The **response** is read by hand, for
  two reasons: the generated `authLogin` binds exactly one success type and
  login has two (200 with tokens, 202 with an MFA challenge); and the contract
  pins `token_type` and `expires_in` to constants, so changing the server's
  token TTL would break deserialisation on every installed copy.
- Failures are typed against what the server actually returns — 422 for
  credentials (which deliberately cannot tell a wrong password from a
  deactivated account, so the form cannot enumerate emails), 429 *with*
  `locked_until` for a lockout, 429 *without* it for the rate limiter, 403 for
  no school assignment. Each renders as an Arabic sentence; no status code or
  English server string reaches the screen.
- Cold start re-checks the stored token against `/auth/me` rather than
  trusting it. `SchoolSuiteApp` takes an injectable keystore and transport, so
  `app_test.dart` drives the real app end to end: launch, sign in, land in the
  parent shell, restart, still in.

Verified: 27 tests. **Negative control:** dropping `device_id` from the request
failed the assertion; restoring it passed.

### Order 3.2 — MFA, forced password change, account state ✅

`76b5454`

- The MFA challenge grant is **never written to the token store** — storing it
  would make the interceptor, the refresh coordinator and the router all read
  the app as signed in while the second factor is outstanding. A login attempt
  clears the store first, so nothing stale can shadow it.
- A wrong code is told apart from an expired grant: one says try again, the
  other says start over. An account that requires MFA but never enrolled is
  told to finish setup on the web rather than left typing codes at a screen
  that will refuse all of them.
- The session opens only after `/auth/me` returns — a shell rendered from a
  half-known user is how someone sees the wrong child.
- A temporary password pins the app to the change-password screen, matching
  the server's own 403-on-everything rule. The rotated tokens the server
  issues on success are stored, because it deletes the old pair.
- A deactivated account is ejected on the next call; signing out clears
  credentials whether or not the server is reachable, keeping the device id.

Verified: 23 tests. **Negative control:** removing the router's password gate
let a blocked teacher reach `/teacher`; restoring it pinned them.

### Order 3.3 — Biometric app-lock and device management ✅

`0f1f585` · `school-mobile/lib/core/lock/`, `lib/features/security/`

- The lock is an **app-lock, not authentication**: unlocking reveals a session
  that already exists, never creates one, never touches a token. No password is
  stored to re-authenticate with.
- Every non-success leaves the app covered — wrong finger, dismissed prompt, OS
  lockout, and a device that has stopped being able to prompt at all. That last
  one is the tempting bug ("we cannot ask, so let them through") and is exactly
  what turns a removed fingerprint into a bypass.
- The overlay sits **above the router**, so while locked the app's screens are
  not in the tree and there is no navigation state to manipulate past it.
- Configurable, persisted timeout; a glance at a notification does not lock the
  app, and the transient `inactive` state is not treated as leaving.
- Remote revocation needs no push: the server stamps `revoked_at` on every
  token bound to that device id, the device 401s, its refresh fails, and the
  existing unauthenticated path wipes it — proved end to end.
- `MainActivity` is now a `FlutterFragmentActivity`; `androidx.biometric` needs
  a FragmentActivity host or the prompt throws at runtime.

Verified: 28 tests. **Negative control:** treating an unavailable prompt as a
way in unlocked the app; restoring the guard kept it locked.

### Order 3.4 — Parent onboarding without passwords ✅

`d9f0b17` · `laravel-api` invite endpoints + `school-mobile/lib/features/onboarding/`

- The office issues a code for one named guardian. The plaintext is in that
  response and nowhere else — only a keyed HMAC is stored, and it never reaches
  a log or an audit row. Issuing a new code expires the previous one.
- Redemption is single-use and atomic: the row is claimed in a locked
  transaction, so two devices racing one code produce one session and one
  rejection. Unknown, spent, expired and burned-by-guessing answer identically,
  so the endpoint cannot enumerate codes or guardians.
- Activation replaces the temporary password staff generated with something
  nobody holds. `device_id` is **required**, not optional as on login.
- The "device PIN" step is the app-lock from 3.3, using the phone's own
  credential. An app-specific PIN was deliberately not invented — it would
  store another credential to protect a session the token already governs.

Verified: 16 backend tests + 14 Flutter tests. **Negative control:** removing
the single-use and expiry guard failed 5 tests; restoring it passed all 16.

**⛔ Not built: SMS OTP.** The order allows *"invite code, **or** SMS OTP"*. No
SMS provider is configured or chosen for this project, and an OTP that delivers
nowhere cannot be verified against its own acceptance criterion
(*"OTP is rate-limited and single-use"*). Choosing a provider is a procurement
decision, like the FCM project.

## PHASE 4 — Parent app

**Status: complete. All 6 orders done.**

### Order 4.1 — Backend: parent BFF ✅

`5f55251` · `GET /api/mobile/v1/session/bootstrap`, `/parent/home`,
`/parent/children/{id}/overview`

- **Bootstrap now reports every role the user holds**, read from
  `school_user_roles` and merged with `users.role`. That closes the gap flagged
  in 3.1: a teacher whose own child attends the school arrived as a teacher
  only and could not see their child's fees.
- Branding is translated into what the app can apply — the web stores a border
  radius as a keyword, the app needs a number. The font stays Tajawal because
  the web's three choices are Latin-first faces with no Arabic coverage; the
  school's `font_style` is reported alongside rather than dropped. A school
  that has never opened the settings screen gets defaults, not a 500.
- `parent/home` batches every lookup across all children. A test asserts one
  child and five cost the **same** number of queries, not merely a bounded one.
- A grade is shown only when its gradebook is `finalized`. A component with no
  gradebook counts as unpublished — showing a teacher's working draft to a
  parent is the failure that cannot be undone, so the unknown case fails
  closed.
- A week with no register taken reports `null`, not 100%.
- Conditional GET on all three: ETag over the payload, `private, no-cache`,
  weakened `W/` tags from a proxy still validate, and one family's tag never
  validates another's screen.
- Money is integer minor units at three decimals; the outstanding balance is
  subtracted in integers and rebuilt as a string rather than divided by 100.
- `EnsureParentOwnsChild` **now records its refusals**. The decision is
  unchanged; only the audit line is new.

Verified: 25 tests, 556 backend tests green, contract regenerated and
idempotent, Redocly valid, Dart client regenerated.

**Negative control:** removing the guardian scope from the child-id lookup let
one parent see another family's child and let their ETag validate the other's
screen; restoring it fixed both.

### Order 4.2 — Backend: parent finance BFF ✅

`f292e87` · `finance/summary`, `children/{studentId}/installments`,
`invoices`, `invoices/{invoiceId}`, `pay/{installmentId}/intent`,
`receipts/{receiptId}/pdf`

- **No float anywhere on the path.** A test walks the entire payload of every
  endpoint and fails on any float it finds. Installments are asserted to sum to
  the plan total exactly in fils — 100.00 split three ways is precisely where a
  schedule stops adding up — and a plan whose parts disagree with its total
  reports `reconciles: false` rather than quietly showing numbers that do not
  match.
- **Nothing about clearance is invented.** There is no e-invoicing integration
  in this system: no JoFotara client, no submission, no authority response. So
  the state is `pending` and there is **no `qr` key at all**. A QR is a signed
  artefact the authority returns; generating one from the invoice's own fields
  would produce a code that scans, looks official, and verifies against
  nothing.
- The payment intent is idempotent **because of a unique index**, not a check
  followed by an insert — two requests can both pass a check, only one can win
  an index. Five identical calls with one key produce exactly one row: the
  first answers 201, every replay answers 200 with the same body. A key
  replayed against a *different* installment is refused with 409.
- A five-process race was added to the Postgres concurrency suite, where the
  constraint can actually be raced. (Needs the Postgres harness to run; not
  executed here.)
- Only a **posted** receipt is downloadable. A draft is a finance clerk's
  working document, and a parent who files one has been given something still
  reversible.
- Family-level allocation: three siblings under one guardian are reported
  separately and the family total is their sum, to the fil.

Verified: 23 tests, 579 backend tests green, contract regenerated and
idempotent, Redocly valid.

**Negative control:** dropping the unique index *and* the idempotent lookup
failed 3 tests, including "five identical intents produce exactly one";
restoring them passed all 23.

**Route-naming trap worth knowing:** `EnsureParentOwnsChild` reads a bare
`{id}` route parameter as a **student** id. An invoice or receipt id there is
checked against the child list and always refused. The finance routes use
`{invoiceId}` / `{receiptId}` for that reason, and `{studentId}` on the
installments path *so that* the middleware guards it too.

### Order 4.3 — Flutter: parent home ✅

`a8381e9` · `school-mobile/lib/features/parent/`

- **Cache first, then revalidate.** The cached copy is rendered before the
  request is even sent; a test proves the ordering by holding the response for
  a second and asserting the screen already has data. Network-first with the
  cache as a fallback shows a blank screen for as long as the request takes,
  which on 3G is the whole interaction.
- A failed revalidate never blanks a screen that already has content, and never
  overwrites the last good copy — a 500 that wipes the cache leaves the next
  cold start with nothing.
- A 304 is treated as **fresh**, not stale: the server just confirmed the copy.
- **No child picker.** One child is one card; three siblings are three cards.
- Unmarked attendance renders as "not recorded yet", never as a percentage. A
  money block with the wrong shape is dropped rather than read as zero.

Verified: 19 tests, both locales, 200% text scale, offline banner,
pull-to-refresh.

**Negative control:** making the screen network-first failed the cache-ordering
test and the "failed fetch keeps showing cached data" test; restoring it passed.

### Order 4.4 — Flutter: fees, payments, invoices ✅

`7a8545d` · `school-mobile/lib/features/parent/`

- **Paying is two taps from this screen, three from home.** The confirmation is
  not ceremony — it is the last point at which the amount sits beside the
  child's name, which is what stops the wrong installment being paid.
- **One idempotency key per attempt, reused by every retry.** There are two
  retry layers and a test proves both reuse it: the transport retries a lost
  connection on its own, and the parent tapping again after it gives up is a
  second logical attempt. The key also survives an app restart mid-payment, and
  is cleared once the payment completes so the next one is genuinely new.
- **Payments are never queued.** Everything else that writes goes to the
  outbox; money does not, because a payment replayed hours later against a
  balance that has moved is a charge nobody authorised. A test asserts nothing
  reaches the outbox.
- The QR is rendered only when the invoice says `cleared` **and** the server
  sent one. A QR on an uncleared invoice is ignored, and an unrecognised
  clearance state counts as not cleared.
- The server decides what is payable; the client does not second-guess it.
- Amounts render at exactly three decimals in both locales.

Verified: 19 tests, both locales, 200% text scale.

**Negative control:** minting a fresh key per attempt failed the reuse and
restart tests; restoring it passed.

**Bug found and fixed while testing:** the installment row put an amount and a
Pay button in a `Row`, which overflows at 200% text scale on a phone. It wraps
now.

### Order 4.5 — Flutter: attendance, grades, report cards ✅

`d724e03` (backend) · `33833ec` (Flutter) ·
`GET /children/{studentId}/attendance|grades|report-cards`,
`GET /report-cards/{issueId}/pdf`, `POST /attendance/{recordId}/explain`

- **An unpublished thing is not visible, and not merely hidden.** A mark whose
  gradebook is not finalized and a report card that was never issued are absent
  from the payload entirely; the Flutter type cannot even represent an unissued
  report card.
- Report cards read `report_card_issues` and render each from **its own
  snapshot**. The existing web endpoint renders live grades on demand, so it
  can produce a report card nobody issued and hand out a different document
  under the same version number a week later. The checksum is printed so a
  paper copy can be checked against the record. A reissue supersedes the
  version before it rather than appearing beside it.
- An absence explanation is a new row, never a write into
  `attendance_records.note` — that note is the teacher's record of what they
  observed and the parent's account of why is a different claim by a different
  person. Filing one never changes the attendance status. Idempotent on a key
  reused across retries.
- A month grid starting **Sunday**, matching the Jordanian school week.
- An unrecognised attendance status renders as unknown, never as present.
- Cache-first with a staleness label; the three calls are cached as one payload
  because they are read as one screen.

Verified: 18 backend tests + 19 Flutter tests, both locales, 200% text scale.

**Negative controls:** removing the `finalized` filter let draft marks reach a
parent; treating an unrecognised status as present broke the guard test. Both
restored.

**Bugs found and fixed while testing:** the explain sheet is
`isScrollControlled`, which gives its child unbounded height — a multi-line
field in a bare `Column` there grew without limit. And its text controller was
disposed when the sheet returned, which is too early: the closing animation
still reads it.

### Order 4.6 — Flutter: notifications, messages, timetable, profile ✅

`12ee84a` (backend) · `cd579b7` (Flutter)

- **A parent cannot start a thread.** There is no route that creates one and no
  repository method that could call it — the absence is the mechanism. The
  first message in a thread decides, so a thread the parent opened *on the web*
  stays reply-only here rather than being inherited. Replies are confined to
  school hours. Both refusals are explicit so the client can say why; a
  conversation with no reply box carries the reason beside it, because a
  greyed-out field raises the question its absence answers.
- A missing `can_reply` reads as **no**, never yes.
- **Muting grades does not mute fee reminders.** Preferences merge rather than
  replace, the client sends only the category being toggled, and a widget test
  flips grades off then asserts fees is still on. `emergency` is not in the
  mutable set: a request to mute it is refused rather than accepted and
  ignored, and the UI renders it as an always-delivered row rather than a
  switch that does nothing.
- **Read state is the same `read_at` column the web writes**, so a notice read
  on the phone is read on the website.
- A profile correction is a **request, not an edit** — an admission number a
  family can rewrite is not a record anyone can rely on. The field name reaches
  the audit log; the family's account of the problem does not.

Verified: 21 backend tests + 13 Flutter tests.

**Negative controls:** allowing parents to start threads failed 2 tests;
replacing preferences instead of merging failed the independence test; sending
the whole category map from the client failed the toggle test. All restored.

**Deferred, and worth stating:** the timetable endpoint is built and tested but
its week view is not drawn — the home screen shows today's lessons, which is
what the acceptance criteria exercise. School-configurable messaging hours are
configuration rather than a per-school setting; `school_settings` has no column
for them.

## Status

| Phase | State |
|---|---|
| 2 — Foundation | 3 of 5 (2.2 and 2.3 blocked on FCM) |
| 3 — Authentication | Complete |
| 4 — Parent app | Complete |
| 5 — Teacher app | Complete |
| 6 — Student app | Complete |
| 7 — Integration, hardening, release | Complete |

Every order that could be built without a decision or a device has been built.
What remains is in the blocker table at the bottom: two account/provider
signups, two product decisions, and three measurements that need real hardware
and real people.

## PHASE 5 — Teacher app

**Complete.** Five orders, all five delivered.

### Order 5.1 — Backend: teacher BFF ✅

`33b73bd`

`GET /mobile/v1/teacher/today`, `GET /mobile/v1/teacher/roster/{classId}`,
`POST /mobile/v1/teacher/attendance/batch`, `POST /mobile/v1/teacher/grades/batch`.

- **Scope is a class, never a child.** Assignment is homeroom or a
  `class_subject_teacher` pairing. The class id is a claim by the client
  wherever it appears — path or body — so it is checked on every call and the
  refusal is written to `audit_logs`.
- **Attendance reuses `AttendanceService::markAttendance()`**, which already
  carries the idempotency key, the payload-hash conflict and the edit window.
  The window arithmetic was extracted into `AttendanceService::editWindow()` so
  the state the client is *shown* is literally the one the server *enforces*.
- **Grades needed a batch table of their own** (`teacher_grade_batches`).
  `Grade` carries an optimistic `version`, so replaying writes would 409 on the
  second attempt and read to the teacher as data loss. The key is claimed
  before a single mark is written, so a racing send rolls back having changed
  nothing rather than double-applying and bumping every version.
- 22 backend tests. Negative controls: `canTeach()` forced true (3 of 4 scope
  tests fail; the fourth is the `role:teacher` middleware, a separate guard);
  `editWindow()` forced open (both window tests fail); the idempotency lookup
  nulled (the replay test fails on the bumped version). All restored and green.
- `tests/Postgres/` gains a `grade_batch` worker op and a five-process one-key
  test. **Not executed** — that harness needs a real PostgreSQL.

### Order 5.2 — Flutter: today and classes ✅

`c383f37`

- Two tabs off **one** payload and **one** controller. Two endpoints for "my
  periods" and "my classes" would eventually disagree about which classes
  exist, and the tab a teacher trusts would be whichever they opened last.
- **Pending comes from the outbox, not from a flag.** A period has three
  states: outstanding, waiting to send, received by the school. The middle one
  is read from the queue on every load — the only source still right after a
  restart, on a second device, or when a drain succeeds while the screen is not
  looking. Dead rows are counted separately and never folded in.
- Roster gained photos and guardian contacts on the backend, behind the same
  assigned-class check. A photo is requested only when the server says one
  exists; a guardian with no number gets no call button at all.
- **New dependency: `url_launcher`** — placing a call is a platform intent with
  no Dart equivalent. Wrapped behind `GuardianDialer` so every screen offering
  it stays testable, including the branch that matters: a school tablet with no
  dialer, which now says so instead of doing nothing.

### Order 5.3 — Flutter: offline attendance ✅

`b374e31`

- Everyone starts present, pre-filled from whatever the server already has. A
  tap toggles present/absent, a swipe marks late or excused, a long press opens
  the full chooser and a note. Rows are 48dp. Swipes use `Dismissible` with
  `confirmDismiss` returning false, so the row springs back with a new status
  instead of the student leaving the class.
- **Every student is sent, not only the exceptions.** A partial roll cannot be
  told apart from an unfinished one.
- The screen never touches the network: submitting enqueues, and the existing
  `OutboxDrainer` sends it. Losing connectivity spends no attempt.
- **Pending is displayed as pending.** The confirmation says "saved on this
  phone"; a rejection names which submission and why, reconstructed from the
  local row because the drainer deliberately never keeps a response body.
- Two real controller bugs found while writing the tests: state published
  without being awaited (a spinner that never resolved), and notifying after
  disposal when a screen is popped mid-load.
- Negative controls: the local window check removed; dead rows folded into the
  pending set. Both fail the right tests, both restored.
- ⚠️ **Still required before this ships:** the plan asks for a real teacher
  marking a real class against paper with a stopwatch. Cannot be done from
  here. Recorded as an open item below.

### Order 5.4 — Flutter: grade entry ✅

`bea493b`

- New `GET /mobile/v1/teacher/gradebook/{classId}/{subjectId}`: components,
  every recorded score with its optimistic version, the workflow state, and
  whether the **server** considers the sheet editable. `editable` is never
  computed on the phone — the reopen window is a timestamp, and a device clock
  a day out would offer an editable sheet the server then refuses.
- One assessment at a time, not a spreadsheet on a phone. A submitted, approved
  or finalised sheet has disabled fields, an explanation and no submit button.
  A mark above the maximum never reaches the queue; a blank cell stays blank.
- The version read with each mark goes back with it. On a conflict the drainer
  lets the server win and does not replay; the screen names the batch, says the
  server's copy stands, and **lists the marks that were refused** so they can be
  entered again.
- Negative controls: `MarkSheet.isEditable` forced true (five tests fail); the
  version dropped from the payload (the silent-overwrite path itself fails).

### Order 5.5 — Flutter: assignments and announcements ✅

`ca50aa4`

- Assignment is a **draft** until published, and publishing twice is a no-op
  rather than a second round of notifications. Existing assignments are
  backfilled as published so nothing already live is retracted on deploy.
- The attachment is its own call: a failed upload costs the file and nothing
  else, is visible on screen with the assignment explicitly still saved, and
  retries in one tap. **This is not resumable upload** — see the note below.
- Announcements are **approved templates only**, worded in config so a change
  needs no app release, with the exact text shown before sending. Outside the
  school's hours the server refuses with 409 and the screen has no send button.
  Nothing here is queued: a notice drained at midnight arrives exactly when the
  hours exist to prevent.
- A notice to one guardian is a *message*, not a broadcast, so the family can
  answer it — the parent surface is reply-only and the first message decides.
- Negative controls: server hours guard forced open; template allow-list
  removed; assignments published on creation; the client's hours check forced
  open. All four fail the right tests; all restored.

**Phase 5 verification:** `flutter analyze --fatal-infos --fatal-warnings`
clean, 481 Flutter tests pass, 664 backend tests pass, `flutter build apk
--flavor dev` succeeds.

## PHASE 6 — Student app

**Complete.** Two orders, both delivered.

> **Scope note.** The plan restricts this phase to grade 7 and above pending
> the school's under-13 policy (open blocker 4). Nothing here enforces a
> minimum grade — the surface is the same for any student account the school
> creates. Enforcing it needs the policy decision first, and then a rule about
> which accounts may be issued at all, which belongs in account provisioning
> rather than in the app.

### Order 6.1 — Backend: student BFF ✅

`c2afc50`

`GET /mobile/v1/student/{home,timetable,attendance,grades,assignments}` and
`POST /mobile/v1/student/assignments/{id}/submit`.

- **Not one route accepts a student id** — not a path segment, not a query
  parameter, not a body field. The whole access-control story is one
  argument-free private method returning `$request->user()->id`. A parameter
  that does not exist cannot be forged, guessed or enumerated.
- Reads reuse `ParentAcademicsService` and `ParentInboxService`. A student's
  attendance and their parent's view of it must be the same numbers, and the
  rule that an unfinalized mark is invisible now holds on both surfaces because
  it is enforced once.
- A **draft** assignment is invisible and cannot be handed in to. Handing in
  **late is recorded as late, not refused** — a student who cannot hand in at
  all hands in nothing, and the teacher loses the work rather than the
  timestamp. `submissions.idempotency_key` was added so a retried upload is
  *answered* rather than treated as a conflict.
- ⚠️ **The negative control earned its keep.** With `studentId()` rewired to
  read a query parameter, all 21 tests still passed: the forged-id test was
  asserting on the other student's *name*, which none of those payloads carry.
  Rewritten to assert on `student_user_id` and on the other class's homework by
  id; it then failed under the broken guard, as it should have from the start.

### Order 6.2 — Flutter: student screens ✅

`fa1624d`

- Home, timetable, assignments, grades, attendance. Read-only except the
  hand-in.
- **`StudentRepository` has no method that takes a student id.** A test walks
  every request the app can produce and asserts none carries a query string or
  a body on a read, and a second test names the entire API surface — so adding
  a method that reaches another student means editing that list.
- **No classmate list, no ranking, no peer messaging.** Excluded by the plan
  and asserted absent on both sides.
- The hand-in is **not queued**. A student shown "handed in" for work sitting
  on their own phone stops carrying it, and the deadline is at the school.
  Offline says so; a failure says the work has not arrived, in those words.
  Late is warned about and still accepted.
- The idempotency key is minted once per hand-in and kept in the local cache
  until the server accepts it, so a retry after the app was killed mid-upload
  is the same hand-in rather than a second one.
- Negative controls: key persistence removed (the reuse test fails — that is
  the duplicate-hand-in path itself); a failed hand-in reported as accepted
  (two tests fail, including the one asserting the screen never claims work
  arrived when it did not).
- Also fixed: four duplicate l10n keys introduced in 5.3. `gen-l10n` tolerated
  them with last-wins and the two Arabic values for "excused" differed, so
  which one rendered depended on parse order.

**Phase 6 verification:** analyze clean, 496 Flutter tests pass, 686 backend
tests pass, `flutter build apk --flavor dev` succeeds.

## PHASE 7 — Integration, hardening, release

**Complete.** Seven orders, all seven delivered.

### Order 7.1 — Cross-role, cache coherence, session edges ✅

`b8ee99a`

- ⛔ **The multi-role gap is a blocker, not a bug I fixed.**
  `MobileBootstrapService` reports both roles for a teacher whose own child
  attends the school; `RoleMiddleware` admits on `users.role`, which holds one
  value. The app is told it may switch to a role the API refuses, so 7.1's
  acceptance case cannot be exercised at all. Widening `RoleMiddleware` would
  widen every admin, finance and HR route at the same time, so per standing
  rule 3 this stops at the guard. `CrossRoleTest` records both halves as they
  behave, **including the refusal**; that test is the one to invert once the
  decision is made. See blocker 7 below.
- ✅ **Fixed: a device carried one user's cache into the next user's session.**
  `signOut()` cleared tokens and nothing else. `LocalDataOwner` records which
  user the local database belongs to — in the database itself, so the record
  cannot outlive the data it describes — and a sign-in or cold-start restore by
  a different user clears their rows first and reports what was discarded.
- ✅ **Signing out refuses when writes are still owed**, and says how many. It
  is the last moment the person who queued that register is present to be
  asked. The count travels; the contents never do. Paths where the session is
  already dead (own device revoked, forced password change) discard explicitly.

### Order 7.2 — Offline chaos ✅

`f93b0e2`

- ✅ **Clock skew.** A phone that thought it was next Tuesday when a failure was
  recorded left the row waiting for a date years away. `claimNext` now treats
  anything beyond the backoff's own ceiling as skew. A *backwards* jump makes
  an honest backoff look like skew too, so the row retries early — the right
  direction to err in, because every queued write carries an idempotency key.
- ✅ **Storage full.** `enqueue` failing raised a raw exception and the register
  would have shown "saved on this phone" for something never written. Now a
  typed `LocalWriteFailedException` (no payload, no path, not SQLite's own
  message, which quotes paths that hold account names) and a visible notice.
- Already held, now asserted: a drain killed mid-flight recovers without
  spending an attempt; no eviction touches a pending, failed or dead row.

### Order 7.3 — Performance ✅

`f840fb7`

- ⚠️ **The wall-clock target has NOT been measured.** Cold start under two
  seconds and a home render under one, on a three-year-old mid-range Android
  over throttled 3G, is a measurement on the handset. Open item, alongside 5.3's
  stopwatch test.
- ✅ Query budgets as tripwires: a roster of thirty, a day of eight periods, a
  parent with five children, eight assignments, one delta type. The negative
  control takes the roster from single digits to 34 queries.
- ✅ Render ordering: the parent home paints its cached copy while a five-second
  request is still in flight, with no spinner; one screen costs one request; a
  revalidate is one round trip and no body.

### Order 7.4 — Accessibility ✅

`41df592`

- A sweep over five screens' real semantics trees: every actionable node has a
  label, tooltip or value; every one clears 48dp; every screen renders at 200%.
- Every screen passed first time, which is a result worth distrusting, so the
  sweep was negative-controlled with an unlabelled 30dp icon button. Both halves
  failed and named the offender.

### Order 7.5 — Security ✅

`9ee2035`

- ✅ **FLAG_SECURE, per screen and counted.** Fees, invoices, class rosters
  (guardians' phone numbers), student marks and attendance. Not the whole app:
  a parent has every reason to screenshot a timetable, and people who cannot do
  the ordinary thing photograph the screen with another phone. Opening an
  invoice over the fee list must not un-protect the list on close — tested.
- ✅ **Certificate pinning with the rotation plan in the class that implements
  it.** SPKI, not the certificate, because a certificate is renewed every ninety
  days and pinning it bricks every install. Two pins always: the key in use and
  its replacement. A *release* configured with a single pin is refused at
  construction. Ships **unpinned** — no production certificate exists yet, and
  an empty pin list means "not pinned", which is the honest state.
- ✅ **PII audit** across log lines, sync events, stored failure reasons, the
  rejection a teacher reads, and exceptions.
- ✅ Writing the Data Safety form surfaced a real gap: minSdk 24 permits
  cleartext on Android 7 and 8, so "encrypted in transit" would have been false
  on exactly the older handsets a pilot runs on. Now refused explicitly.

### Order 7.6 — Play Store ✅

`0ffae46`

- ✅ Release signing from a gitignored `key.properties`, with a fallback that
  **announces itself** — a silently debug-signed artefact that looks like a
  release is how the wrong APK reaches a listing.
- ✅ `store/data-safety.md`, written from the code with every row citing its
  file, plus a section naming what would make it wrong.
- ✅ `store/listing-ar.md`, `store/privacy-policy.md` (ar + en),
  `store/release-checklist.md` with the content-rating answers.
- ⛔ **Not done:** screenshots (need a device; shot list written, and it says not
  to photograph real children), the public policy URL, the submission itself,
  and the upload keystore — which must be generated by whoever will hold it.

### Order 7.7 — Pilot support ✅

`411f8ee`

- Request ids on error screens were already built in 2.5; this adds the tests,
  including that the id is *selectable*.
- ✅ **Feature flags** finally read on the client. Defaults to on in three
  separate ways: unknown flag, unreachable server, never-reached server. A flag
  is how a school turns something off; treating a bad connection as "everything
  off" turns one morning's signal problem into an outage.
- ✅ **Diagnostics export** as plain text a teacher can read out. Counts,
  statuses, endpoints, short reasons. Cache entity *types* go in; entity ids do
  not, because an entity id can be a student id and a bundle gets pasted into
  group chats.

**Phase 7 verification:** analyze clean, 568 Flutter tests pass, 697 backend
tests pass, `flutter build apk --flavor dev` succeeds.

---

## Open blockers

| # | Item | Blocks | Who can clear it |
|---|---|---|---|
| 1 | Google Play organization account + D-U-N-S | The release itself | Account owner. Longest lead time in the project (2–4 weeks). |
| 2 | **FCM project + service-account key** | **Orders 2.2 and 2.3, and the Phase 2 gate** | Account owner. ~20 minutes. |
| 3 | Play policy on school fee payments vs Play Billing | Order 4.4 architecture | Product decision |
| 4 | Under-13 student account policy | Phase 6 scope | Product decision |
| 5 | **SMS provider** (none configured) | The OTP alternative in order 3.4 | Product/procurement decision. The invite-code path is built and does not need it. |
| 6 | **JoFotara / e-invoicing integration** — none exists | A *cleared* invoice and its authority QR (order 4.2, and 4.4's receipt view) | Needs a real integration. Until then every invoice reports `clearance.state: pending` and carries no QR, which is the honest answer. |
| 7 | **Multi-role users cannot switch roles** — `RoleMiddleware` admits on `users.role` (one value), while `school_user_roles` holds several | Order 7.1's acceptance case: a teacher whose own child attends the school | Product + security decision. Widening `RoleMiddleware` widens every admin, finance and HR route at once, so it was not touched. `CrossRoleTest::test_the_other_role_is_refused_by_the_role_middleware` is the test to invert. |
| 8 | **Performance never measured on a handset** | Order 7.3's acceptance (cold start < 2s, home render < 1s on a 3-year-old mid-range Android over throttled 3G) | Needs a device and a throttled network. Query budgets and render ordering are held by tests; the wall clock is not. |
| 9 | **Attendance never timed against paper** | Order 5.3's own acceptance | Needs a real teacher, a real class and a stopwatch. If the app is not faster than paper it will not be adopted. |
| 10 | **No production certificate, so the app ships unpinned** | Order 7.5's pinning | Needs the production TLS key. The mechanism and the two-pin rotation plan are built and tested; the pins are empty, which the code treats as "not pinned" rather than pretending. |
| 11 | **No Arabic screenshots, no public privacy-policy URL, no upload keystore** | Order 7.6's submission | Screenshots need a device; the keystore must be generated by whoever will hold it. |
| 12 | **92 routes where `RoleMiddleware` is the only authorization guard** — `AdminController` 40, `AccountingController` 19, `WarehouseController` 18, `FinanceController` 14, `ParentInviteController` 1 | Nothing today; it is a standing risk, not a blocker. User provisioning is in that set, and provisioning is what creates role rows | Needs a decision on whether coarse role checks are sufficient for the admin surface, or whether `perm:` should extend to it. Inventory in [docs/mobile/multi-role-analysis.md](docs/mobile/multi-role-analysis.md) §2b |
| 13 | **Money is stored in qirsh, not fils** — the server has no third decimal anywhere, so a JOD amount cannot be expressed to the fil | Exact installment splitting. A 100.000 JOD plan split three ways stores 33.33/33.33/33.34, putting the whole remainder on the last instalment | Needs the integer-minor-units migration across 70 columns. The API now declares 2 decimals so nothing is *displayed* as false precision, but the underlying coarseness remains. [docs/finance/money-precision-audit.md](docs/finance/money-precision-audit.md) |
| 14 | **Two sites round a computed third decimal away** — percentage adjustments (`StudentAdjustmentService.php:45`) and weighted-average stock costing (`ProcurementService.php:101`) | A 33.3333% scholarship loses 3 fils per invoice | Next order. Input-scale validation (8.4) is in, so the fix can now be proven by a test rather than asserted |
| 15 | ✅ **Closed by 8.4.** ~~SQLite does not enforce decimal scale; PostgreSQL does~~ | Nothing now. An over-precise amount is a 422 naming the field on both drivers, before either stores it | The `money` rule is on all 42 money inputs, not only the seven the audit named, and `MoneyInputCoverageTest` fails for any new `numeric` input that lacks it. The driver difference itself remains; it can no longer be reached through an input |
| 16 | **Card payments assume a two-decimal currency** — `PaymentGatewayService` sends `round($due * 100)` to Stripe and divides by 100 on the way back, whatever the currency | Nothing today: `PAYMENT_CURRENCY` defaults to `usd`. Set it to `jod` and every charge is one tenth of the invoice, because Stripe takes the smallest unit and JOD's is the fil | A decision on whether cards will ever be taken in JOD through Stripe. If so, convert through currency-aware minor units the way `MobileMoney` does. Stripe's own page on three-decimal currencies could not be reached from the build environment to confirm any JOD-specific rule |

## Notes carried forward

- **Attendance timing against paper has not been measured.** Order 5.3's own
  acceptance says to time a real teacher marking a real class with a stopwatch
  before it ships. The screen is built for it — default all-present, one tap
  per exception, swipes, 48dp rows — but the measurement is a field test and
  has not happened. If the app is not faster than paper it will not be adopted,
  and no amount of polish repairs that.
- **The assignment attachment is retryable, not resumable.** True resumable
  upload needs a protocol (tus or multipart-with-offsets) and server-side
  storage of partial objects; neither exists here. What is built satisfies
  "fails visibly": the assignment is created first, so a failed upload loses
  only the file, the failure is on screen, and the retry is one tap. A 20 MB
  worksheet over a bad school connection will still start from zero.
- **No file picker is wired into the build.** `AssignmentsScreen` takes a
  `FilePicker` and hides the attach action when it is null, so the button is
  absent rather than present and inert. Adding a picker package is a one-line
  change at the `SchoolSuiteApp` seam.
- **Announcement wording lives in `config/mobile.php`, not in a table.** A
  school that wants to edit its own templates needs an admin surface and a
  `school_id`-scoped table; until then the templates are the same for every
  tenant, which is correct for a single-school pilot and wrong for the second
  school.
- **Announcement and assignment writes are deliberately not queued offline.**
  Only attendance and grades go through the outbox. A notice queued at four in
  the afternoon and drained at midnight would arrive exactly when the school's
  hours exist to prevent, and a queued assignment has no id for its attachment
  to attach to.

- **Currency is configured, not stored.** No school setting carries a currency,
  so mobile money payloads read `mobile.currency` (`JOD`) and
  `mobile.currency_decimals` (`3`) from config. If the product ever serves a
  second currency, that becomes a per-school column.
- **Money columns are `decimal(12,2)` but JOD has three decimals.** The mobile
  layer widens on the way out and refuses to narrow. PDO SQLite — which the
  test suite runs on — returns those columns as PHP floats; that value is
  converted at the column's own scale and checked to round-trip rather than
  rounded.
- **A tombstone's `payload` is `{}`, not `null`.** The Dart generator drops the
  null half of `object | null` and emits a non-nullable `BuiltMap`, so a null
  there would crash the client on the one path that most needs to work.
  `deleted` is the signal.
- **Database-level `ON DELETE CASCADE` leaves no tombstone.** Cascades here
  follow an owning record whose own deletion is reported, so the client drops
  the subtree from that. A cascade with no reported parent would need a
  database trigger.
- **`/auth/login` and `/auth/me` return a single `role`.** The server can hold
  several (`school_user_roles` is keyed on `(school_id, user_id, role)`), but
  neither endpoint exposes them, so a teacher whose child attends the school
  arrives as a teacher only. `AuthRepository.sessionFrom` already reads a
  `roles` array when present, so this starts working the day
  `session/bootstrap` (order 4.1) returns one. **Order 4.1 should return
  `roles[]`.**
- **`php artisan openapi:generate` needs more than a 128 MB `memory_limit`.**
  It OOMs part-way through the Symfony YAML dump on this contract and leaves
  the file untouched (so it fails loudly rather than writing a truncated spec).
  CI is unaffected — `shivammathur/setup-php` sets `memory_limit=-1` for CLI —
  but a local run needs `php -d memory_limit=1G artisan openapi:generate`.
- **`test/core/sync/outbox_drainer_test.dart` "a 503 is retried" is
  timing-sensitive.** It flaked once when the full suite ran alongside a Gradle
  build, then passed in isolation three times and in two clean full-suite runs.
  Worth hardening against wall-clock pressure before it wastes someone's
  afternoon in CI.
- **`flutter build apk` warns about missing `CupertinoIcons` fonts.** Material's
  platform-adaptive back button references them. Harmless on an Android-only
  app — no Cupertino glyph ships — and not worth a dependency to silence.
