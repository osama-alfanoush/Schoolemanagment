WEEK 1 — Code Quality: Zero-Risk Wins
Target: 26/60 → 42/60

Day 1 — AuthServiceProvider + StudentPolicy (2 hrs)
1. Register AuthServiceProvider in bootstrap/app.php:

php
return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(...)
    ->withMiddleware(...)
    ->withProviders([
        App\Providers\AuthServiceProvider::class,  // ADD
    ])
    ->withExceptions(...)
    ->create();
2. Create app/Providers/AuthServiceProvider.php:

php
<?php
namespace App\Providers;

use App\Models\User;
use App\Policies\StudentPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        User::class => StudentPolicy::class,
    ];

    public function boot(): void
    {
        $this->registerPolicies();
    }
}
3. Create app/Policies/StudentPolicy.php — use the full policy from the Code Quality audit report (already written, copy-paste ready).

4. Replace all 13 ensureChild calls in ParentController:

php
// BEFORE (every method):
$this->ensureChild($request, $studentId);
$student = User::findOrFail($studentId);

// AFTER (every method):
$student = User::findOrFail($studentId);
$this->authorize('view', $student);
5. Delete the private ensureChild() method entirely.

6. Verify:

bash
php artisan test  # must still show 52/52 passing
Day 2 — ApiResponse Helper + Response Standardization (3 hrs)
1. Create app/Http/Responses/ApiResponse.php — use the class from the audit (copy-paste ready), but fix the deleted() method:

php
// Fix this method specifically:
public static function deleted(): \Illuminate\Http\Response
{
    return response()->noContent(); // NOT json(null, 204)
}
2. Standardize the 5 most inconsistent endpoints first:

php
// TeacherController - GET /teacher/classes
return ApiResponse::success($classes);  // was: response()->json($classes)

// TeacherController - GET /teacher/timetable
return ApiResponse::success($entries);

// ParentController - GET /parent/children
return ApiResponse::success($children);

// AdminController - GET /admin/dashboard/kpis
return ApiResponse::withSummary($kpis, ['generated_at' => now()->toIso8601String()]);

// All DELETE endpoints
return ApiResponse::deleted();  // was: response()->json(['message' => 'Deleted'])
3. Run tests after each controller change:

bash
php artisan test  # 52/52 must stay green
Day 3 — TypeScript Types Foundation (3 hrs)
1. Create src/types/api.types.ts — use the complete types file from the Code Quality audit. It already covers: User, Invoice, Payment, Grade, Attendance, JournalEntry, and all request types.

2. Enable only strictNullChecks first (not full strict):

json
// tsconfig.json
{
  "compilerOptions": {
    "strictNullChecks": true
  }
}
3. Run TypeScript check:

bash
npx tsc --noEmit
# Count how many errors appear
4. Fix nullability errors — the most common pattern:

typescript
// Pattern 1: Object possibly undefined
const name = user.studentProfile.classRoom.name;  // ❌
const name = user.studentProfile?.classRoom?.name ?? 'Unknown';  // ✅

// Pattern 2: Function return possibly undefined
const item = list.find(x => x.id === id);
item.name  // ❌
item?.name  // ✅

// Pattern 3: DOM element possibly null
const el = document.getElementById('app');
el.innerHTML  // ❌
el!.innerHTML  // ✅ (when you're certain it exists)
Day 4 — Type api.ts Financial Functions (3 hrs)
The riskiest any types are in financial operations. Fix these first:

typescript
// src/lib/api.ts - Fix the 6 most dangerous any types

// 1. Invoice generation (was: data: any)
generateInvoices: (data: GenerateInvoicesRequest) =>
  apiFetch("/finance/invoices/generate", { method: "POST", body: data }),

// 2. Record payment (was: data: any)
recordPayment: (invoiceId: number, data: RecordPaymentRequest) =>
  apiFetch(`/finance/invoices/${invoiceId}/payments`, { method: "POST", body: data }),

// 3. Journal entry (was: data: any)
createJournalEntry: (data: CreateJournalEntryRequest) =>
  apiFetch("/accounting/journal-entries", { method: "POST", body: data }),

// 4. Mark attendance (was: data: any)
markAttendance: (data: MarkAttendanceRequest) =>
  apiFetch("/teacher/attendance", { method: "POST", body: data }),

// 5. Enter grade (was: data: any)
enterGrade: (data: { student_user_id: number; grade_component_id: number; score: number }) =>
  apiFetch("/teacher/grades", { method: "POST", body: data }),

// 6. User profile (was: studentProfile?: any)
export interface AuthUser {
  id: number;
  name: string;
  email: string;
  role: UserRole;
  studentProfile?: StudentProfile;
  staffProfile?: StaffProfile;
}
Day 5 — Type Remaining api.ts Functions + Verify (2 hrs)
Fix all remaining any types in api.ts (admin, auth, warehouse, HR functions). Then:

bash
npx tsc --noEmit  # Should be 0 new errors vs the 13 pre-existing
php artisan test  # Still 52/52
npm run build     # Frontend still builds
End of Week 1 Score: 26/60 → ~42/60

WEEK 2 — Code Quality: Service Layer Extraction
Target: 42/60 → 55/60

Day 1–2 — Extract TeacherController Services (6 hrs)
Send this to M2.5 with TeacherController.php attached:

text
Extract 3 service classes from TeacherController.
Rules:
- Do NOT change any business logic, only move it
- Do NOT change any route signatures
- Use constructor injection in the controller
- PHP 8.2 strict types throughout

Extract:
1. GradeService → all grade methods (enterGrade, updateGrade, gradeComponents, 
   studentReport, exportGrades)
2. AttendanceService → all attendance methods (markAttendance, 
   updateAttendance, attendanceSummary, attendanceReport)  
3. AssignmentService → all assignment methods (create, update, 
   delete, gradeSubmission)

Thin controller result:
class TeacherController extends Controller {
    public function __construct(
        private GradeService $grades,
        private AttendanceService $attendance,
        private AssignmentService $assignments,
    ) {}
}

Also provide:
- AppServiceProvider bindings for all 3 services
- One before/after example per service showing the delegation pattern
After receiving output:

bash
php artisan test  # 52/52 must stay green
Day 3 — Extract AccountingController Services (3 hrs)
text
Extract from AccountingController:
1. BudgetService → all budget CRUD methods
2. JournalService → journal entry creation, validation, period management
3. FinancialReportService → trial balance, income statement, balance sheet

Same rules as TeacherController extraction.
Day 4 — Extract WarehouseController Services (2 hrs)
text
Extract from WarehouseController:
1. InventoryService → item CRUD, stock queries
2. StockMovementService → stock in/out, notification triggers, 
   low-stock detection
Day 5 — Enable noImplicitAny + Full Strict Mode (2 hrs)
After all any types are replaced in Week 1:

json
// tsconfig.json — Step 2
{
  "compilerOptions": {
    "strictNullChecks": true,
    "noImplicitAny": true
  }
}
Run npx tsc --noEmit. Fix any remaining errors. Then:

json
// tsconfig.json — Step 3 (final)
{
  "compilerOptions": {
    "strict": true
  }
}
End of Week 2 Code Quality Score: ~55/60 → Grade: B+

WEEK 3 — Testing: Infrastructure + Security Tests
Target: 15% → 35%

Day 1 — Build Test Factory Foundation (3 hrs)
Send to M2.5 with all migration files:

text
Create all missing Laravel test factories for a School Management System.
Provide factory states for User (all 8 roles), and full factories for:
ClassRoom, Subject, GradeComponent, Grade, Assignment, 
AssignmentSubmission, AttendanceRecord, Invoice (pending/partial/paid/overdue 
states), Payment, FeeStructure, JournalEntry, ChartOfAccount.

Each factory must:
- Use faker for realistic data
- Have proper foreign key relationships
- Include at least 2 state variations

Also extend tests/TestCase.php with:
protected function loginAs(string $role): User {
    $user = User::factory()->{$role}()->create();
    Sanctum::actingAs($user, ['*']);
    return $user;
}
Day 2–3 — IDOR + Authorization Tests (6 hrs)
These are your highest-priority tests — they verify your security fixes actually work:

php
// tests/Feature/Security/IdorTest.php
// Write tests for all 10 IDOR scenarios:

// 1. Parent cannot access another parent's child
public function test_parent_cannot_access_other_childs_grades(): void
{
    $parent1 = User::factory()->parent()->create();
    $child1 = User::factory()->student()->create(['parent_id' => $parent1->id]);
    $parent2 = User::factory()->parent()->create();

    Sanctum::actingAs($parent2, ['*']);

    $this->getJson("/api/parent/children/{$child1->id}/grades")
         ->assertForbidden();
}

// 2. Student cannot access other student grades
// 3. Teacher cannot grade students outside their class
// 4. Finance cannot access HR data
// 5-10. Remaining IDOR scenarios
Day 4–5 — Authentication Flow Tests (4 hrs)
php
// tests/Feature/AuthenticationTest.php — ADD to existing

// Token refresh test
public function test_token_refresh_returns_new_access_token(): void
{
    $user = User::factory()->student()->create();
    $loginResponse = $this->postJson('/api/auth/login', [
        'email' => $user->email,
        'password' => 'password',
    ]);
    
    $refreshToken = $loginResponse->json('refresh_token');
    
    $this->postJson('/api/auth/refresh', ['refresh_token' => $refreshToken])
         ->assertOk()
         ->assertJsonStructure(['access_token', 'expires_in']);
}

// Inactive user blocked
public function test_inactive_user_cannot_login(): void
{
    $user = User::factory()->inactive()->create();
    
    $this->postJson('/api/auth/login', [
        'email' => $user->email,
        'password' => 'password',
    ])->assertUnprocessable();
}

// Password reset flow
// Role escalation blocked
// Brute force protection (rate limiting)
End of Week 3 Coverage: ~15% → ~35%

WEEK 4 — Testing: Business Logic + Frontend
Target: 35% → 65%

Day 1–2 — Business Logic Tests (6 hrs)
php
// tests/Feature/BusinessRules/GradeTest.php
public function test_grade_cannot_exceed_max_score(): void { ... }
public function test_same_component_cannot_be_graded_twice(): void { ... }
public function test_grade_cannot_be_entered_for_unenrolled_student(): void { ... }

// tests/Feature/BusinessRules/AttendanceTest.php
public function test_attendance_cannot_be_marked_twice_same_day(): void { ... }
public function test_attendance_cannot_be_marked_for_future_date(): void { ... }

// tests/Feature/BusinessRules/FinanceTest.php
public function test_payment_cannot_exceed_invoice_balance(): void { ... }
public function test_payment_cannot_be_made_on_paid_invoice(): void { ... }
public function test_invoice_status_transitions_correctly(): void { ... }
Day 3 — Frontend Test Infrastructure (3 hrs)
bash
npm install -D vitest @testing-library/react @testing-library/jest-dom \
  @testing-library/user-event jsdom msw @vitest/coverage-v8
Create the 3 setup files from the Testing Coverage audit:

vitest.config.ts

src/test/setup.ts

src/test/msw-handlers.ts (MSW API mocks for all auth endpoints)

src/test/render-utils.tsx (renderWithProviders wrapper)

Day 4–5 — Frontend Component Tests (6 hrs)
typescript
// 4 test files from the Testing Coverage audit:

// 1. LoginForm.test.tsx — 10 test cases
// 2. ProtectedRoute.test.tsx — 5 test cases
// 3. api.test.ts — 8 test cases (token handling, error states)
// 4. useAuth.test.tsx — 4 test cases

// Use MSW handlers, NOT vi.mock for API calls
End of Week 4 Coverage: ~35% → ~65%

WEEK 5 — CI/CD Enforcement + Final Verification
Target: 65% → 80%+ | Locked in permanently

Day 1–2 — Validation + Admin Tests (4 hrs)
php
// Fill remaining coverage gaps:

// tests/Feature/ValidationTest.php
// - login rejects invalid email
// - create user rejects duplicate email
// - grade score must be in valid range
// - payment amount must be positive

// tests/Feature/AdminTest.php
// - admin can create all 8 role types
// - admin cannot downgrade own role (lockout prevention)
// - bulk student import validates file format
Day 3 — Update GitLab CI/CD Pipeline (2 hrs)
Add coverage enforcement to .gitlab-ci.yml:

text
backend:test:
  script:
    - php artisan test --parallel --coverage
  coverage: '/Coverage: \d+\.\d+%/'
  after_script:
    - php artisan test --coverage-clover storage/coverage.xml
  # Fail pipeline if coverage drops below 70%
  
frontend:test:
  script:
    - npx vitest run --coverage
  coverage: '/All files.*?(\d+\.\d+) %/'
  # Fail pipeline if coverage drops below 50%

# Add quality gate — blocks merge if either fails
quality:gate:
  stage: .post
  script:
    - echo "All quality gates passed"
  needs:
    - backend:test
    - frontend:test
    - phpstan
    - frontend:typecheck
Day 4–5 — Final Verification Sprint (4 hrs)
bash
# Backend
php artisan test --coverage
# Target: 80%+ coverage, 120+ tests

# TypeScript
npx tsc --noEmit
# Target: 0 errors (including the 13 pre-existing, now fixed)

# Frontend tests
npx vitest run --coverage
# Target: 50+ tests, 65%+ coverage

# Build verification
npm run build
# Target: dist/ builds cleanly, ideally with code splitting added
Final Scorecards
Code Quality: 26/60 → 60/60
Category	Before	After	What Fixed It
Category	Before	After	What Fixed It
Controller Architecture	4/10	10/10	Service layer extraction
Code Duplication	3/10	10/10	StudentPolicy replaces 13 duplicates
TypeScript Quality	2/10	10/10	Strict mode + full type coverage
SOLID Compliance	3/10	10/10	SRP via services, DI via constructor
Dead Code	9/10	10/10	Already clean, minor cleanup
API Consistency	5/10	10/10	ApiResponse helper across all 16 controllers
Testing Coverage: 15% → 80%+
Category	Before	After	Tests Added
Auth flows	8/20	20/20	+12
IDOR/Authorization	0/50	50/50	+50
Business logic	0/30	28/30	+28
Validation	5/30	30/30	+25
Frontend	0/50	50/50	+50
Total	52 tests	~170 tests	+118