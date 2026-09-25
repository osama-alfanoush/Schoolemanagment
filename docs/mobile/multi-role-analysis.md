# Multi-role authorization analysis

**Order 8.2 · read-only investigation · 2026-09-25**

Route facts are derived from `php artisan route:list --json` against the
application as it stands at commit `22c9a28`, so they reflect resolved
middleware groups rather than a reading of `routes/api.php`. Every code claim
cites `file:line`. Nothing outside this file was changed.

---

## Verdict in one paragraph

Widening `RoleMiddleware` would expose **191 routes on which it is the only
middleware-level authorization gate**, 134 of them staff routes including all
40 `AdminController` routes and the entire finance, accounting and warehouse
surface. But the finding that should decide this is smaller and blunter:
**widening `RoleMiddleware` would not fix the problem it is meant to fix.**
`EnsureParentOwnsChild` performs its own single-role check
(`app/Http/Middleware/EnsureParentOwnsChild.php:25`), so a teacher who is also
a parent would still be refused on all 32 child-scoped parent routes. And a
second finding makes the whole question less urgent than it looks: **no code
path in the application can create a second role row**, so the multi-role user
the bootstrap advertises cannot currently exist. Recommendation is **option
(c)**, which is honest, ships today, and costs nothing that a later decision
would have to undo.

---

## 1. Routes guarded by `RoleMiddleware`

`RoleMiddleware` admits on a single column:

```php
// app/Http/Middleware/RoleMiddleware.php:11-18
public function handle(Request $request, Closure $next, string ...$roles): Response
{
    $user = $request->user();
    if (! $user || ! in_array($user->role, $roles, true)) {
        return response()->json(['message' => 'Forbidden'], 403);
    }
    return $next($request);
}
```

Registered as the `role` alias at `bootstrap/app.php:50`.

Of **368** application routes, **315** carry at least one `RoleMiddleware`.
Several carry two — the mobile group applies `role:parent,student,teacher` and
then an inner `role:teacher` — so the figures below use the **intersection**,
which is what actually admits.

| Effective requirement | Routes |
|---|---:|
| `admin` | 68 |
| `admin,finance` | 64 |
| `parent` | 32 |
| `teacher` | 29 |
| `admin,finance,hr` | 26 |
| `admin,hr` | 26 |
| `student` | 22 |
| `admin,finance,procurement,warehouse` | 18 |
| `admin,warehouse` | 17 |
| `admin,finance,procurement` | 7 |
| `parent,student,teacher` | 6 |
| **Total** | **315** |

---

## 2. What a second role row would gain — and where the only gate is

Only two other authorization middleware exist in the application:

- `App\Http\Middleware\PermissionMiddleware` — on 92 routes
- `App\Http\Middleware\EnsureParentOwnsChild` — on 32 routes

Treating authentication, tenancy and rate limiting (`Authenticate`,
`EnsureAccountIsActive`, `EnsureTokenIsUsable`, `EnsurePasswordChanged`,
`ResolveSchoolContext`, `ThrottleRequests`, `SubstituteBindings`) as **not**
authorization, the split is:

- **124** guarded routes have a second authorization middleware.
- **191** guarded routes have **`RoleMiddleware` and nothing else**.

### 2a. The exhaustive single-gate set (acceptance criterion 3)

These 191 routes, by effective role and controller. This is the complete set at
middleware level; §2b then removes those whose controller performs its own
caller check.

| Effective role | Controller | Routes |
|---|---|---:|
| `admin` | `AdminController` | 40 |
| `admin` | `NotificationController` | 7 |
| `admin` | `GradebookController` | 6 |
| `admin` | `LibraryController` | 4 |
| `admin` | `TransportController` | 4 |
| `admin` | `EnrollmentController` | 2 |
| `admin` | `MfaController` | 2 |
| `admin` | `ParentInviteController` | 1 |
| `admin` | `HealthController` | 1 |
| `admin` | `WarehouseController` | 1 |
| `admin,finance` | `AccountingController` | 19 |
| `admin,finance` | `FinanceController` | 14 |
| `admin,warehouse` | `WarehouseController` | 17 |
| `admin,hr` | `HrController` | 16 |
| `teacher` | `TeacherController` | 25 |
| `teacher` | `GradebookController` | 2 |
| `teacher` | `HrController` | 2 |
| `student` | `StudentController` | 17 |
| `student` | `LibraryController` | 4 |
| `student` | `TransportController` | 1 |
| `parent,student,teacher` | `ParentInboxController` | 4 |
| `parent,student,teacher` | `ParentHomeController` | 1 |
| `parent,student,teacher` | `SyncController` | 1 |
| | **Total** | **191** |

### 2b. Which of those have no caller check anywhere

Checked each controller for a check on *the caller* (`authorize()`,
`hasPermission()`, `$request->user()->id` scoping, an assignment test). School
scoping via `$this->schools->authorize(...)` is **tenancy, not role
authorization**, and is not counted.

**Genuinely single-gate — RoleMiddleware is the only thing standing there:**

| Controller | Routes | Evidence |
|---|---:|---|
| `AdminController` | 40 | Two matches only, neither a caller check: `app/Http/Controllers/Api/AdminController.php:389` validates a submitted role *name*, `:426` builds a response body |
| `AccountingController` | 19 | Its two matches are tenancy: `app/Http/Controllers/Api/AccountingController.php:82,113` |
| `WarehouseController` | 18 | Zero caller-authorization matches |
| `FinanceController` | 14 | Zero caller-authorization matches |
| `ParentInviteController` | 1 | Zero caller-authorization matches |
| **Total** | **92** | |

**Protected in the controller despite the single middleware:**

| Controller | Routes | Evidence |
|---|---:|---|
| `TeacherController` | 25 | Every route re-checks the class assignment — `app/Services/Mobile/TeacherService.php:73-95` (`canTeach`), called from `app/Http/Controllers/Api/Mobile/TeacherController.php:56,78,115,167` |
| `StudentController` | 17 | Self-scoped on every query: `app/Http/Controllers/Api/StudentController.php:52,95,137,158` |
| `HrController` | 18 | Real permission checks on the salary and warning routes: `app/Http/Controllers/Api/HrController.php:102,117,134,165` |
| `GradebookController` | 8 | `abort_unless($assigned, 403, …)` at `app/Http/Controllers/Api/GradebookController.php:29,42` |
| `NotificationController`, `LibraryController`, `TransportController`, `EnrollmentController`, `MfaController`, `ParentInboxController`, `ParentHomeController`, `SyncController` | 33 | All carry caller scoping; the mobile three resolve their audience from the token |

**So the answer to acceptance criterion 3 is: 92 routes — `AdminController`
(40), `AccountingController` (19), `WarehouseController` (18),
`FinanceController` (14), `ParentInviteController` (1).** On those, the role
check is the entire authorization story. That is the set a widening would open,
and it is the number that should govern the decision.

### 2c. What a widened middleware would actually grant

A user whose `users.role` is `teacher` but who holds an `admin` row would, under
option (a), reach all 92 of the above plus the rest of the 191. In particular:
user provisioning (`AdminController` calls
`app/Services/UserManagementService.php:67`, which itself creates role rows),
the journal and ledger surface, every warehouse movement, and every fee and
invoice endpoint.

`PermissionMiddleware` would still constrain the 92 perm-guarded routes (a
different set of 92 from the single-gate set above -- the two are disjoint by
construction, since a perm-guarded route is not single-gate),
because `hasPermission()` also reads the single column
(`app/Models/User.php:113,124`) — a widened `RoleMiddleware` would let the
request in and the permission check would still evaluate against the primary
role. That is a partial protection and an accidental one; it exists because
nobody widened `hasPermission`, not because it was designed to backstop.

Note `app/Models/User.php:113`: `if ($this->role === 'admin') return true;` —
any user whose **primary** role is admin bypasses every permission check.

---

## 3. How `school_user_roles` is populated — and the finding that reframes this

Every writer in the application:

| Writer | Line | What it writes |
|---|---|---|
| `UserManagementService::create` | `app/Services/UserManagementService.php:67` | `['role' => $data['role']]` — the same value written to `users.role` |
| `UserManagementService` bulk import | `app/Services/UserManagementService.php:252` | `['role' => 'student']`, alongside `users.role = 'student'` |
| `ProvisionAdmin` console command | `app/Console/Commands/ProvisionAdmin.php:62` | CLI only, not reachable over HTTP |
| `DatabaseSeeder` | `database/seeders/DatabaseSeeder.php:280` | mirrors `users.role` |
| `StagingQualificationSeeder` | `database/seeders/StagingQualificationSeeder.php:53` | mirrors |
| `UserFactory` | `database/factories/UserFactory.php:25` | mirrors |

**There is no code path — HTTP or console — that adds a *second* role row to an
existing user.** Every writer mirrors `users.role` at creation.

Confirmed against the development database:

```
users: 29
school_user_roles rows: 29
users with MORE THAN ONE role row: 0
role rows that DISAGREE with users.role: 0
```

Two consequences:

1. **A user cannot acquire a role row without an admin action** — and in fact
   cannot acquire a second one at all. Self-service escalation is not currently
   possible, which is the reassuring half.

2. **The multi-role user the bootstrap advertises cannot exist yet.**
   `MobileBootstrapService::rolesFor()` merges the table with `users.role`
   (`app/Services/Mobile/MobileBootstrapService.php:63-79`), but since the two
   always agree, `roles` is always a single-element list and the app's role
   switcher is never offered. The contract mismatch is **latent, not active.**
   The only way to produce one today is what `CrossRoleTest` does by hand:
   `tests/Feature/Mobile/CrossRoleTest.php:40-43` inserts the second row
   directly.

The table carries `starts_on` / `ends_on` columns, which the bootstrap honours
(`app/Services/Mobile/MobileBootstrapService.php:66-67`), so multi-role with a
validity window was clearly the intent. It was never wired up.

---

## 4. Would the other guards still constrain a widened role?

| Guard | Reads | Would it still constrain? |
|---|---|---|
| `PermissionMiddleware` → `User::hasPermission` | `users.role` — `app/Models/User.php:113,124` | **Yes, accidentally.** Covers 92 routes. But `:113` short-circuits `true` for a primary-role admin. |
| `StudentPolicy` | the `children()` relationship, not a role — `app/Policies/StudentPolicy.php:19` | **Yes, properly.** Relationship-based, so it is indifferent to how many roles a user holds. |
| `EnsureParentOwnsChild` | **`users.role` directly** — `app/Http/Middleware/EnsureParentOwnsChild.php:25` | **Yes — and that is the problem.** See below. |

### The finding that decides option (a)

```php
// app/Http/Middleware/EnsureParentOwnsChild.php:25
if (! $user || $user->role !== 'parent') {
    return response()->json(['message' => 'Forbidden'], 403);
}
```

**Widening `RoleMiddleware` alone would not fix blocker 7.** The teacher who is
also a parent would pass the widened role gate and then be refused by
`EnsureParentOwnsChild` on every one of the 32 child-scoped parent routes —
which is essentially the whole parent app. To make the use case work, both
middleware must be widened, which means the change is larger than it appears
*and* it removes one of the two guards currently protecting the parent surface.

The relationship check on the next lines
(`app/Http/Middleware/EnsureParentOwnsChild.php:32`) would still hold, and it is
the one that actually matters — but the audit log entry and the role check
would both need rethinking together.

---

## 5. Three options, costed

### (a) Widen `RoleMiddleware` to read `school_user_roles`

**Change:** `app/Http/Middleware/RoleMiddleware.php:14` plus, necessarily,
`app/Http/Middleware/EnsureParentOwnsChild.php:25`, or the target use case still fails (§4).
Realistically also `User::hasPermission` (`app/Models/User.php:113,124`), or the
permission layer silently keeps evaluating the wrong role.

**Exposure:** the 92 single-gate routes of §2b, immediately and for every
multi-role user — user provisioning, accounting, finance, warehouse.

**Extra cost:** a second database read on every authenticated request, or a
cache with an invalidation story. `users.role` is on the already-loaded user
model; `school_user_roles` is a join keyed on user and school.

**Blast radius today:** *nil*, because no multi-role user exists (§3). That is
not comfort — it means the change would be untested against real data and would
arm a mechanism that fires the first time anyone adds a second role row.

**Verdict:** largest new attack surface, and it does not even solve the
problem on its own.

### (b) Mobile-only role check on `/api/mobile/v1/*`

**Change:** a second middleware applied only to the mobile group at
`laravel-api/routes/api.php:128-131`, reading `school_user_roles`; web routes
keep `RoleMiddleware` unchanged.

**Exposure:** bounded to the mobile surface — 32 parent, 29 teacher, 22 student,
6 shared = 89 routes. None of the 92 single-gate staff routes is in that set,
because none of them is under `/api/mobile/v1/*`. `EnsureParentOwnsChild` still
needs widening for the parent routes to work (§4), but its relationship check
remains, and `TeacherController` re-checks assignment on every route
(`app/Services/Mobile/TeacherService.php:73-95`) and `StudentController` is
self-scoped.

**Cost:** one new middleware, one route-group edit, and the inversion of
`tests/Feature/Mobile/CrossRoleTest.php:88-100`. Real but contained.

**Verdict:** the only option that actually delivers role switching, and it
confines the new surface to routes that carry a second, relationship-based
guard.

### (c) Leave the middleware; make bootstrap report only the admitted role

**Change:** `MobileBootstrapService::rolesFor()`
(`app/Services/Mobile/MobileBootstrapService.php:59-79`) stops merging and
returns only the role the API will actually admit.

**Exposure:** none. Nothing is widened.

**Effect:** the app stops offering a switch it cannot perform. Since no
multi-role user can exist today (§3), this is **behaviourally a no-op right
now** — `roles` is already a single-element list for every real user. It
changes only the hand-built case in `CrossRoleTest`, and it makes the contract
honest before anyone can create one.

**Cost:** a few lines, one test updated. `CrossRoleTest:88-100` stays as it is,
because the behaviour it records stays true.

**Verdict:** smallest surface, ships today, forecloses nothing.

---

## 6. Which leaves the smallest new attack surface

Strictly ordered: **(c) nil < (b) 89 routes, all with a second guard < (a) 191
routes, 92 of them single-gate.**

---

## 7. Recommendation

**Take (c) now. Hold (b) until a school actually needs role switching. Do not
take (a).**

The reasoning is the same shape as the money audit's: the dangerous option is
the one that weakens a guard without any signal. Option (a) widens the coarse
gate across 92 routes where nothing else is checking, and — per §4 — does not
even deliver the feature unless `EnsureParentOwnsChild` is widened with it.

Option (c) is close to free because of §3: there is no multi-role user, so
there is nothing to take away. It makes the app tell the truth about what the
API will do, which is the same defect class as the `decimals: 3` contract lie
in the money audit — **the client advertising a capability the server does not
have.** Fixing both is the same principle applied twice.

When a school does need a teacher-parent to switch roles, (b) is the shape to
build, and it should be built together with:

1. A way to *create* a second role row — an admin action, audited. Today none
   exists (§3), so the feature has no data to operate on.
2. Widening `app/Http/Middleware/EnsureParentOwnsChild.php:25` in the same change, or the parent
   app stays closed to exactly the users the feature is for.
3. Inverting `tests/Feature/Mobile/CrossRoleTest.php:88-100`, which the test's
   own comment already anticipates: *"When the decision is taken, this test is
   the one to invert."*

---

## 8. Limits of this analysis

- Route figures come from `route:list` on the local application. They are
  accurate for this commit and would change if middleware groups change.
- §2b's "no caller check" classification is based on searching each controller
  for `authorize(`, `hasPermission`, `$request->user()->id`, `abort_if`,
  `abort_unless` and assignment helpers. A check written in some other form —
  a query scope applied in a model boot method, say — would not be caught.
  The five controllers named as single-gate were read directly; the rest were
  classified by search.
- No production database was inspected. The role-row counts in §3 are from the
  local development database (29 seeded users) and are evidence about the
  *code paths*, not about production data. Whether a production database
  contains a hand-inserted second role row **cannot be determined from this
  repository.**
