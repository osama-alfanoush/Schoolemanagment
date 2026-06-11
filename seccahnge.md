Based on both security audit reports from MiniMax M2.5 and my expert analysis, here is your complete phased security hardening plan to take your app from **6.5/10 → 10/10**. Each phase is a standalone prompt you send to the agent with your actual code files.

***

# Security Hardening Roadmap
## School Management System — Laravel 11 + React 19

***

## Phase 0 — Immediate Fixes (Today, ~2 hours)
*No agent needed — pure config changes, zero code risk*

These are 1-line fixes with no side effects. Do these before anything else:

**1. Set `APP_DEBUG=false` in `.env.prod`**
```bash
APP_DEBUG=false
APP_ENV=production
```

**2. Set secure session flags in `.env.prod`**
```bash
SESSION_SECURE_COOKIE=true
SESSION_SAME_SITE=strict
SESSION_ENCRYPT=true
SESSION_DRIVER=redis
```

**3. Remove `role` from `$fillable` in `User.php`**
```php
// BEFORE — mass assignment privilege escalation risk
protected $fillable = ['name', 'email', 'password', 'role', ...];

// AFTER — role is assigned only via explicit code
protected $fillable = ['name', 'email', 'password', 'phone', 'photo_path', 'locale', 'is_active'];
```

**4. Add `.env` to `.gitignore` and scan git history**
```bash
echo ".env" >> .gitignore
git log --all --full-history -- .env  # check if it was ever committed
```

***

## Phase 1 — Backend Hardening (Day 1, ~3 hours)
*Send this prompt to M2.5 with: `AppServiceProvider.php`, `routes/api.php`, `HealthController.php`*

```
You are a Laravel security engineer. I need you to implement the following 
security fixes in my Laravel 11 application. For each fix, provide the 
COMPLETE updated file content, not just snippets.

## Fix 1: Add Laravel-Level Rate Limiting
In AppServiceProvider::boot(), add RateLimiter definitions:
- 'login': 5 attempts per minute per IP
- 'change-password': 3 attempts per minute per user ID
- 'api': 60 requests per minute per authenticated user ID (fallback to IP)

Then bind these in routes/api.php using ->middleware('throttle:login') 
on the login route, throttle:change-password on the password change route,
and throttle:api on the main api group.

## Fix 2: Create config/cors.php
Create a strict CORS configuration that:
- Only allows origins from the FRONTEND_URL environment variable
- Allows credentials (supports_credentials: true)
- Only allows methods: GET, POST, PUT, PATCH, DELETE, OPTIONS
- Sets max_age: 7200
- Paths: ['api/*', 'sanctum/csrf-cookie']

## Fix 3: Sanitize Health Endpoint
In HealthController.php, modify the /api/health endpoint to:
- Keep basic status (up/down) public: {"status": "ok", "timestamp": "..."}
- Move detailed info (disk, DB version, queue depth) behind 
  auth:sanctum middleware, accessible only to admin role
- Remove any version numbers, path info, or server details from public response

## Fix 4: Add Rate Limiting to Payment Endpoints
Identify all routes related to payments and finances in routes/api.php
and add throttle:3,1 (3 per minute) middleware to them.

After each fix, show a before/after diff and explain what attack it prevents.
```

***

## Phase 2 — CORS Configuration (Day 1, ~1 hour)
*Send this prompt with: `config/sanctum.php`, `nginx/prod.conf`, your `.env.example`*

```
You are a Laravel + Nginx security engineer. I need to configure a 
bulletproof CORS + Sanctum stateful authentication setup.

My setup:
- Laravel 11 backend (API only, no Blade views)
- React 19 SPA frontend on a separate domain
- Laravel Sanctum for auth
- Docker + Nginx deployment

## Task 1: Configure Sanctum for Cookie-Based Auth (Stateful)
Modify config/sanctum.php to:
- Set stateful domains from SANCTUM_STATEFUL_DOMAINS env variable
- Set the session cookie name to a non-default value (not 'laravel_session')
- Ensure token expiry is enforced

## Task 2: Add CSP Header to Nginx
In nginx/prod.conf, add a Content-Security-Policy header:
- default-src 'self'
- script-src 'self' (no unsafe-inline, no unsafe-eval)
- style-src 'self' 'unsafe-inline' (React needs this for CSS-in-JS)
- img-src 'self' data: blob:
- connect-src 'self' [API domain]
- frame-ancestors 'none'
- upgrade-insecure-requests

## Task 3: Add Missing Security Headers
Add to nginx/prod.conf:
- Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
- Permissions-Policy: camera=(), microphone=(), geolocation=()
- Cross-Origin-Opener-Policy: same-origin
- Cross-Origin-Resource-Policy: same-origin

Provide the complete updated nginx/prod.conf file.
```

***

## Phase 3 — Critical Frontend Fix (Day 2, ~4 hours)
*The most impactful change — send with: `src/lib/api.ts`, `config/sanctum.php`, `app/Http/Controllers/Auth/AuthController.php`*

```
You are a senior full-stack security engineer. I need to migrate my 
React 19 + Laravel 11 application from localStorage token storage to 
httpOnly cookie-based authentication using Laravel Sanctum stateful mode.

This is a CRITICAL security fix. Current state:
- Frontend stores access + refresh tokens in localStorage (CVSS 9.1 vulnerability)
- Backend returns tokens as JSON response
- Frontend sends: Authorization: Bearer <token>

Required end state:
- Backend sets tokens as httpOnly, Secure, SameSite=Strict cookies
- Frontend sends cookies automatically (no manual token handling)
- Zero tokens accessible to JavaScript

## Step 1: Backend Changes (AuthController.php)
Modify the login endpoint to:
- Return a httpOnly cookie instead of JSON token
- Use Sanctum's cookie-based stateful authentication
- Keep the user data in the JSON response body (not the token)
- Handle CSRF cookie endpoint: GET /sanctum/csrf-cookie

Modify the logout endpoint to:
- Clear the cookie (set expired httpOnly cookie)
- Revoke the Sanctum token server-side

Modify the refresh endpoint to:
- Rotate the cookie (set new httpOnly cookie, invalidate old)

## Step 2: Frontend Changes (api.ts)
Rewrite api.ts to:
- REMOVE all localStorage.setItem/getItem for tokens
- ADD: fetch CSRF cookie from /sanctum/csrf-cookie before login
- SEND: include credentials: 'include' on all fetch/axios calls
- REMOVE: Authorization header injection (cookies are automatic)
- KEEP: the 401 interceptor logic for redirect to login
- Store ONLY non-sensitive user display data in memory/context 
  (NOT localStorage): { id, name, role, locale }

## Step 3: Update All API Calls
Show the pattern change for all API utility functions that 
currently inject the Bearer token header.

Provide complete rewritten files for: AuthController.php and api.ts.
Flag any endpoints that need the CSRF middleware adjusted.
```

***

## Phase 4 — IDOR & Authorization Hardening (Day 3, ~3 hours)
*Send with: `TeacherController.php`, `routes/api.php`, `ParentController.php`, any Admin/Finance controllers*

```
You are a Laravel authorization security engineer. I need to audit and 
fix all IDOR (Insecure Direct Object Reference) vulnerabilities in my 
Laravel 11 application.

The application has these user roles:
student, parent, teacher, admin, finance, HR, accounting, warehouse

## Task 1: Create a Reusable Ownership Policy Pattern
Create a Laravel Policy base class or trait called `OwnershipValidatable` 
that provides:
- verifyOwnership(Model $resource, string $userRelation): void
  (throws 403 if current user doesn't own the resource)
- Use abort_unless() pattern (like ParentController's ensureChild)

## Task 2: Audit TeacherController
For every method in TeacherController that accepts an ID parameter:
1. Show the current code
2. Identify if it validates that the teacher owns/has access to 
   that classroom/student/resource
3. Provide the fixed code using the policy pattern

Apply the same analysis to: FinanceController, HRController, 
AccountingController, WarehouseController.

## Task 3: Verify Route-Level Authorization
In routes/api.php, for every resource route group:
- Confirm the correct role middleware is applied
- Confirm there is no way for role A to call role B's endpoints
- Flag any routes that rely solely on auth:sanctum without role middleware

## Task 4: Add Laravel Policies
Generate a Laravel Policy for the User model and Student model that:
- Enforces: a teacher can only view students in their assigned classrooms
- Enforces: a parent can only view their own children
- Enforces: admin can view all
Register both policies in AuthServiceProvider.
```

***

## Phase 5 — Dependency & Secrets Audit (Day 3, ~1 hour)
*Run these commands first, then paste the output to M2.5*

**Run locally first:**
```bash
# Backend
composer audit --format=json > composer_audit.json

# Frontend
npm audit --json > npm_audit.json

# Check for secrets in git history
docker run --rm -v $(pwd):/repo trufflesecurity/trufflehog:latest git file:///repo
```

**Then send to M2.5:**
```
You are a dependency security engineer. I am attaching the output 
of composer audit and npm audit for my Laravel 11 + React 19 app.

## Task 1: Triage All CVEs
For each CVE found, provide:
- Package name + version
- CVE ID + CVSS score
- Is my app actually exploitable? (consider my usage context)
- Exact fix: upgrade command or patch

## Task 2: Identify Upgrade Path
Group fixes into:
- Safe to upgrade now (no breaking changes): provide exact command
- Requires code changes (breaking upgrade): provide migration steps
- No fix available: provide mitigation strategy

## Task 3: Secrets Scanning
Review this .env.example file and flag:
- Any default credentials that should be rotated
- Any keys that appear to be real values (not placeholders)
- Missing security-critical environment variables

[Paste composer_audit.json output here]
[Paste npm_audit.json output here]
[Paste .env.example here]
```

***

## Phase 6 — Monitoring & Audit Trail (Week 2, ~4 hours)
*Send with: `AuditLogger.php`, `AuthController.php`, `nginx/prod.conf`*

```
You are a security monitoring engineer. I need to implement 
production-grade security monitoring for my Laravel 11 application.

## Task 1: Expand AuditLogger Service
Extend the existing AuditLogger to track these events:
- login_success: { user_id, ip, user_agent, timestamp }
- login_failed: { email_attempted, ip, user_agent, timestamp }
- token_refreshed: { user_id, ip }
- permission_denied: { user_id, endpoint, attempted_role }
- idor_attempt: { user_id, resource_type, resource_id, ip }
- password_changed: { user_id, ip }
- admin_action: { admin_id, action, target_user_id, data_changed }

Store logs in a dedicated `security_logs` table (provide migration).
Never log: passwords, tokens, full request bodies.

## Task 2: Add Request ID Tracing
Add a middleware that:
- Generates a UUID request ID on every request
- Attaches it to the response header: X-Request-ID
- Injects it into all log entries for that request
- Enables log correlation across services

## Task 3: Fail2Ban Integration
Write an nginx log format that:
- Outputs structured JSON logs
- Includes: timestamp, IP, endpoint, status_code, user_agent
- Can be consumed by Fail2Ban to auto-block IPs after 
  10 failed logins in 5 minutes

Provide the Fail2Ban jail.conf rule for this pattern.

## Task 4: Security Alert Hooks
Add a notification when these events occur:
- 5+ failed logins from same IP in 1 minute → log + alert
- Admin account login from new IP → log + alert
- IDOR attempt detected → log + block IP for 1 hour
Use Laravel's notification system (log channel is fine for now).
```

***

## Phase 7 — Final Verification Audit (Week 2, ~1 hour)
*After all phases are done, run this final prompt to score your app*

```
You are a senior security auditor performing a FINAL VERIFICATION AUDIT 
of a Laravel 11 + React 19 School Management System.

All of the following security fixes have been implemented:
1. ✅ APP_DEBUG=false, SESSION_SECURE=true, SESSION_ENCRYPT=true
2. ✅ Laravel-level rate limiting on login, password-change, API
3. ✅ config/cors.php with strict origin whitelist
4. ✅ Tokens migrated from localStorage to httpOnly cookies
5. ✅ IDOR ownership checks in all controllers + Laravel Policies
6. ✅ Content-Security-Policy header in Nginx
7. ✅ HSTS, Permissions-Policy, CORP headers added
8. ✅ role removed from $fillable in User model
9. ✅ Health endpoint sanitized + protected
10. ✅ AuditLogger expanded with security events
11. ✅ Dependency CVEs resolved via composer/npm audit
12. ✅ Fail2Ban + structured Nginx logs configured

Review the attached updated files and:
1. Re-score each OWASP Top 10 category (A01–A10)
2. Re-run all 8 penetration test scenarios from the original report
3. Identify any remaining gaps
4. Produce a final security scorecard
5. Confirm production-readiness

[Attach all updated files here]
```

***

## Progress Tracker

| Phase | Focus | Time | Score Impact |
|---|---|---|---|
| Phase 0 | Config & `$fillable` fix | 2h | 6.5 → 7.0 |
| Phase 1 | Rate limiting + CORS + Health | 3h | 7.0 → 7.8 |
| Phase 2 | CSP + Security headers | 1h | 7.8 → 8.3 |
| Phase 3 | localStorage → httpOnly cookies | 4h | 8.3 → 9.0 |
| Phase 4 | IDOR + Authorization policies | 3h | 9.0 → 9.5 |
| Phase 5 | Dependency CVEs + secrets | 1h | 9.5 → 9.7 |
| Phase 6 | Monitoring + Audit trail | 4h | 9.7 → 10.0 |
| Phase 7 | Final verification | 1h | Confirms 10/10 |

**Total: ~19 hours of focused work over 2 weeks → 10/10 security posture.** Phase 3 (the localStorage migration) is the single highest-impact change — if you can only do one phase this week, do that one.