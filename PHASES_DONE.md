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

Not started.

## PHASE 5 — Teacher app

Not started.

## PHASE 6 — Student app

Not started.

## PHASE 7 — Integration, hardening, release

Not started.

---

## Open blockers

| # | Item | Blocks | Who can clear it |
|---|---|---|---|
| 1 | Google Play organization account + D-U-N-S | The release itself | Account owner. Longest lead time in the project (2–4 weeks). |
| 2 | **FCM project + service-account key** | **Orders 2.2 and 2.3, and the Phase 2 gate** | Account owner. ~20 minutes. |
| 3 | Play policy on school fee payments vs Play Billing | Order 4.4 architecture | Product decision |
| 4 | Under-13 student account policy | Phase 6 scope | Product decision |
| 5 | **SMS provider** (none configured) | The OTP alternative in order 3.4 | Product/procurement decision. The invite-code path is built and does not need it. |

## Notes carried forward

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
- **`flutter build apk` warns about missing `CupertinoIcons` fonts.** Material's
  platform-adaptive back button references them. Harmless on an Android-only
  app — no Cupertino glyph ships — and not worth a dependency to silence.
