# Graph Report - artifacts  (2026-08-11)

## Corpus Check
- 609 files · ~240,081 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 3996 nodes · 10209 edges · 292 communities (169 shown, 123 thin omitted)
- Extraction: 92% EXTRACTED · 8% INFERRED · 0% AMBIGUOUS · INFERRED: 779 edges (avg confidence: 0.8)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `9f1aa812`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- toArray
- App.tsx
- User
- useToast
- BrandCard.tsx
- ClassRoom
- TestCase
- api.types.ts
- api.ts
- BrandButton.tsx
- cn
- Illuminate\Database\Eloquent\Relations\BelongsTo
- Illuminate\Http\Request
- SchoolSettings.tsx
- Illuminate\Database\Eloquent\Model
- msw-handlers.ts
- SchoolContext
- NotificationService
- badge.tsx
- utils.ts
- Illuminate\Database\Eloquent\Relations\HasMany
- Controller
- UserManagementService
- HrController
- DashboardPage.tsx
- Contracts.tsx
- StudentProfile
- Invoice
- PurchaseOrders.tsx
- NotificationController
- AuditLogger
- compilerOptions
- useAuth
- Illuminate\Database\Eloquent\Factories\Factory
- devDependencies
- AccountingController
- AppShell.tsx
- ApiResponse
- HrPayrollController
- JournalEntry
- AttendanceRecord
- Grade
- AuthController
- LibraryBook
- WarehouseItem
- button.tsx
- PayrollRun
- 4. API endpoints
- Illuminate\Console\Command
- PaymentReceipt
- School
- MedicalRecord
- Message
- TeacherController
- School Management API
- item.tsx
- PaymentPlan
- StudentController
- FinanceSubmodulesTest
- components.json
- menubar.tsx
- Carbon
- NotificationReceived
- TeacherFullTest
- StudentPolicy
- JournalBatch
- StudentEnrollment
- Gradebook
- LedgerService
- MfaController
- PaymentGatewayService
- chart.tsx
- GoodsReceipt
- CurrentSchool
- PayrollSettingsController
- StaffProfile
- NotificationTemplate
- WarehouseService
- UserFactory
- Sidebar.tsx
- StudentFinancialAdjustment
- EmployeeAdvanceService
- SupplierInvoice
- WarehouseCategory
- PayrollAccountingService
- ProcurementTest
- تقرير تجهيز School Management Suite للإنتاج
- scripts
- carousel.tsx
- LoginForm.test.tsx
- StudentFinanceService
- FinanceFullTest
- toast.tsx
- package.json
- GradeService
- composer.json
- scripts
- HR and Payroll Workspace
- AdminOpsTest
- WarehouseTest
- form.tsx
- require
- deploy
- IdorTest
- FinancialWorkspaceTest
- ProcurementUserLifecycleTest
- context-menu.tsx
- Staff.tsx
- AppServiceProvider.php
- .calculate
- SIS Domain Architecture Decisions
- مساحة العمل المالية للطلاب
- AdminTest
- HealthTest
- TransportTest
- ErrorBoundary
- input-group.tsx
- HealthController
- require-dev
- Load Testing
- drawer.tsx
- navigation-menu.tsx
- GPT handoff — School Management Suite
- config
- toggle-group.tsx
- Illuminate\Database\Eloquent\Relations\BelongsToMany
- 2026_05_22_000001_add_performance_indexes.php
- 2026_08_03_000002_enforce_school_scope_across_modules.php
- baseline.js
- peak.js
- psr-4
- Staging and Restore Qualification
- Uptime Robot Monitoring
- critical-flows.spec.ts
- vite.config.ts
- post-create-project-cmd
- 2026_08_03_000001_harden_school_scoped_hr_payroll.php
- CI/CD Environment Variables
- Foreign-Key Retention Inventory
- @babel/parser
- autoload-dev
- keywords
- backup-container.sh
- staging.ps1
- Security Exceptions Register
- sonner.tsx
- DataTable.test.tsx
- vite-env.d.ts
- AGENTS.md
- @babel/core
- @babel/generator
- @babel/traverse
- clsx
- cmdk
- date-fns
- embla-carousel-react
- eslint
- eslint-plugin-jsx-a11y
- framer-motion
- gh-pages
- globals
- @hookform/resolvers
- input-otp
- jsdom
- copy-frontend.sh
- first-run.sh
- preflight.sh
- prod-up.sh
- update.sh
- verify-restore.ps1
- railway-entrypoint.sh
- production-policy-owners.md
- lucide-react
- msw
- next-themes
- @playwright/test
- @radix-ui/react-alert-dialog
- @radix-ui/react-aspect-ratio
- @radix-ui/react-checkbox
- @radix-ui/react-context-menu
- @radix-ui/react-dialog
- @radix-ui/react-dropdown-menu
- @radix-ui/react-hover-card
- @radix-ui/react-label
- @radix-ui/react-menubar
- @radix-ui/react-navigation-menu
- @radix-ui/react-popover
- @radix-ui/react-progress
- @radix-ui/react-radio-group
- @radix-ui/react-scroll-area
- @radix-ui/react-separator
- @radix-ui/react-slider
- @radix-ui/react-slot
- @radix-ui/react-switch
- @radix-ui/react-tabs
- @radix-ui/react-toast
- @radix-ui/react-toggle-group
- react-day-picker
- react-dom
- react-hook-form
- react-icons
- react-resizable-panels
- recharts
- sonner
- tailwind-merge
- tailwindcss
- @tailwindcss/typography
- @tailwindcss/vite
- @tanstack/react-query
- @testing-library/jest-dom
- @testing-library/react
- @testing-library/user-event
- tw-animate-css
- @types/node
- @types/react
- vite
- @vitejs/plugin-react
- vitest
- @vitest/coverage-v8
- wouter
- README.md
- QueryParams
- UserRole

## God Nodes (most connected - your core abstractions)
1. `User` - 329 edges
2. `cn()` - 181 edges
3. `AuditLogger` - 151 edges
4. `useToast()` - 117 edges
5. `TestCase` - 106 edges
6. `toArray()` - 69 edges
7. `CurrentSchool` - 68 edges
8. `Invoice` - 61 edges
9. `NotificationService` - 57 edges
10. `Controller` - 56 edges

## Surprising Connections (you probably didn't know these)
- `setup()` --references--> `Trend`  [EXTRACTED]
  laravel-api/tests/load/baseline.js → school-web/src/components/ui/StatCard.tsx
- `setup()` --references--> `Trend`  [EXTRACTED]
  laravel-api/tests/load/peak.js → school-web/src/components/ui/StatCard.tsx
- `IndexRoute()` --calls--> `useAuth()`  [EXTRACTED]
  school-web/src/App.tsx → school-web/src/lib/auth.tsx
- `AppLayout()` --calls--> `useAuth()`  [EXTRACTED]
  school-web/src/components/layout/AppLayout.tsx → school-web/src/lib/auth.tsx
- `StatCard()` --calls--> `cn()`  [EXTRACTED]
  school-web/src/components/ui/StatCard.tsx → school-web/src/lib/utils.ts

## Import Cycles
- None detected.

## Communities (292 total, 123 thin omitted)

### Community 0 - "toArray"
Cohesion: 0.05
Nodes (69): ActionConfig, BrandEmptyState(), BrandEmptyStateProps, isActionConfig(), BrandModalProps, sizeMap, DataTable(), DataTableProps (+61 more)

### Community 1 - "App.tsx"
Cohesion: 0.02
Nodes (94): AccountingDashboard, AccountingReports, AdminAcademicYears, AdminAnnouncements, AdminAttendance, AdminAudit, AdminCalendar, AdminClasses (+86 more)

### Community 2 - "User"
Cohesion: 0.04
Nodes (11): Illuminate\Auth\Access\HandlesAuthorization, Illuminate\Foundation\Auth\User, AccountLockout, User, StudentPolicy, AuthenticationTest, ParentTest, RoleAccessTest (+3 more)

### Community 3 - "useToast"
Cohesion: 0.05
Nodes (65): Action, ActionType, actionTypes, addToRemoveQueue(), dispatch(), genId(), listeners, memoryState (+57 more)

### Community 4 - "BrandCard.tsx"
Cohesion: 0.09
Nodes (37): BrandCard(), BrandCardProps, Card, CardContent, CardDescription, CardHeader, CardTitle, ApiError (+29 more)

### Community 6 - "TestCase"
Cohesion: 0.04
Nodes (17): Illuminate\Foundation\Testing\RefreshDatabase, Illuminate\Foundation\Testing\TestCase, Illuminate\Http\UploadedFile, Illuminate\Notifications\Notifiable, AccountingExtendedTest, ParentStudentLinkTest, ExampleTest, HrTest (+9 more)

### Community 7 - "api.types.ts"
Cohesion: 0.02
Nodes (149): LoginResponse, LoginResult, MfaCompletionResponse, Payments, PermissionDef, REQUEST_TIMEOUT_MS, STORAGE_KEYS, UserPermissionsResponse (+141 more)

### Community 8 - "api.ts"
Cohesion: 0.06
Nodes (35): 1.1 Why php-fpm and not `artisan serve`, 1.2 Why PgBouncer, and why not just raise `max_connections`, 1.3 One image, three services, 1.4 File storage: what is public and what is not, 1.5 Failure behaviour, by design, 1. Architecture the runbook assumes, 2.1 Preconditions (all must hold), 2.2 Platform deploy (GitHub Actions) (+27 more)

### Community 9 - "BrandButton.tsx"
Cohesion: 0.12
Nodes (48): Badge(), BadgeProps, badgeVariants, BrandButtonProps, sizeClasses, variantClasses, DialogContent, DialogDescription (+40 more)

### Community 10 - "cn"
Cohesion: 0.05
Nodes (65): BrandButton(), BrandModal(), LoadingRow(), RowActionDropdown(), Empty(), EmptyContent(), EmptyDescription(), EmptyHeader() (+57 more)

### Community 11 - "Illuminate\Database\Eloquent\Relations\BelongsTo"
Cohesion: 0.06
Nodes (9): Illuminate\Database\Eloquent\Factories\HasFactory, Illuminate\Database\Seeder, TransportController, TransportAssignment, TransportRoute, TransportStop, TransportVehicle, DemoRoleUsersSeeder (+1 more)

### Community 12 - "Illuminate\Http\Request"
Cohesion: 0.07
Nodes (4): Illuminate\Http\Request, AdminController, FinancialWorkspaceController, Permission

### Community 13 - "SchoolSettings.tsx"
Cohesion: 0.06
Nodes (48): files, fs, pagesDir, parser, path, t, buildTheme(), contrastForeground() (+40 more)

### Community 15 - "msw-handlers.ts"
Cohesion: 0.07
Nodes (30): apiDownload(), authStore, ensureCsrfToken(), refreshSession(), ar, en, resources, Translations (+22 more)

### Community 16 - "SchoolContext"
Cohesion: 0.10
Nodes (13): Closure, AssignRequestId, EnsureAccountIsActive, EnsureParentOwnsChild, EnsurePasswordChanged, EnsureTokenIsUsable, PermissionMiddleware, ResolveSchoolContext (+5 more)

### Community 19 - "utils.ts"
Cohesion: 0.04
Nodes (34): AccordionContent, AccordionItem, AccordionTrigger, Alert, AlertDescription, AlertTitle, alertVariants, Checkbox (+26 more)

### Community 20 - "Illuminate\Database\Eloquent\Relations\HasMany"
Cohesion: 0.05
Nodes (14): Illuminate\Database\Eloquent\Model, Illuminate\Database\Eloquent\Relations\BelongsTo, Illuminate\Support\Carbon, EmployeeAdvanceInstallment, GoodsReceiptItem, InventoryCount, PaymentReceiptAllocation, PayrollRecordComponent (+6 more)

### Community 21 - "Controller"
Cohesion: 0.11
Nodes (6): Illuminate\Foundation\Auth\Access\AuthorizesRequests, EnrollmentController, Controller, StudentEnrollment, EnrollmentService, Symfony\Component\HttpFoundation\Cookie

### Community 22 - "UserManagementService"
Cohesion: 0.05
Nodes (9): AcademicYear, Announcement, CalendarEvent, Exam, SchoolSetting, Semester, TimetableEntry, UserManagementService (+1 more)

### Community 23 - "HrController"
Cohesion: 0.08
Nodes (5): HrController, JobApplication, JobPosting, PerformanceEvaluation, StaffAttendance

### Community 24 - "DashboardPage.tsx"
Cohesion: 0.09
Nodes (25): BrandAvatar(), BrandAvatarProps, getInitials(), roleGradientMap, roleRingMap, sizeMap, ACCENT_COLORS, GRADIENTS (+17 more)

### Community 25 - "Contracts.tsx"
Cohesion: 0.15
Nodes (19): HrAdvancesApi, HrEmployeesApi, HrPayrollReportsApi, HrWarningsApi, PayrollSettingsApi, Query, PaginatedResponse, AdvanceInstallment (+11 more)

### Community 26 - "StudentProfile"
Cohesion: 0.07
Nodes (6): FeeStructure, StudentProfile, LibraryFullTest, NewFeaturesTest, InvoiceGuardTest, StudentTest

### Community 28 - "PurchaseOrders.tsx"
Cohesion: 0.08
Nodes (48): BrandBadge(), AccountsPayable, Hr, Installments, PayrollRuns, Procurement, useAuth(), isRecord() (+40 more)

### Community 30 - "AuditLogger"
Cohesion: 0.04
Nodes (15): Illuminate\Database\Eloquent\Relations\HasMany, Illuminate\Database\Eloquent\SoftDeletes, InstallmentController, ProcurementController, ProcurementFinanceController, GoodsReceipt, PaymentPlan, PurchaseOrder (+7 more)

### Community 31 - "compilerOptions"
Cohesion: 0.06
Nodes (30): build, dist, dom, dom.iterable, esnext, node, node_modules, src/**/* (+22 more)

### Community 32 - "useAuth"
Cohesion: 0.08
Nodes (26): AuthUser, MfaEnrollmentResponse, MfaRequiredResponse, AuthContext, AuthProvider(), AuthState, MfaRequiredError, useRequireRole() (+18 more)

### Community 33 - "Illuminate\Database\Eloquent\Factories\Factory"
Cohesion: 0.05
Nodes (17): Illuminate\Database\Eloquent\Factories\Factory, AttendanceRecordFactory, static, ChartOfAccountFactory, ClassRoomFactory, static, FeeStructureFactory, GradeFactory (+9 more)

### Community 34 - "devDependencies"
Cohesion: 0.07
Nodes (29): class-variance-authority, cross-env, @eslint/js, eslint-plugin-react-hooks, @radix-ui/react-accordion, @radix-ui/react-avatar, @radix-ui/react-collapsible, @radix-ui/react-select (+21 more)

### Community 35 - "AccountingController"
Cohesion: 0.08
Nodes (3): AccountingController, AuditLog, ChartOfAccount

### Community 36 - "AppShell.tsx"
Cohesion: 0.09
Nodes (29): AppShell(), buildNav(), NavItem, isRead(), NotificationBell(), NotificationBellProps, NotificationItem, notificationPath() (+21 more)

### Community 37 - "ApiResponse"
Cohesion: 0.11
Nodes (5): Illuminate\Http\JsonResponse, Illuminate\Http\Response, ParentController, ApiResponse, ConductLog

### Community 38 - "HrPayrollController"
Cohesion: 0.06
Nodes (10): Attribute, Illuminate\Database\Eloquent\Casts\Attribute, HrPayrollController, DisciplinaryWarning, EmployeeAdvance, EmployeeContract, PayrollAccountSetting, StaffProfile (+2 more)

### Community 39 - "JournalEntry"
Cohesion: 0.06
Nodes (9): Carbon, BudgetPlan, FinancialClosing, JournalEntry, BudgetService, FinancialReportService, JournalService, SchoolContext (+1 more)

### Community 40 - "AttendanceRecord"
Cohesion: 0.13
Nodes (17): ButtonGroup(), ButtonGroupSeparator(), ButtonGroupText(), buttonGroupVariants, Item(), ItemActions(), ItemContent(), ItemDescription() (+9 more)

### Community 41 - "Grade"
Cohesion: 0.08
Nodes (7): Illuminate\Database\Eloquent\Collection, Grade, GradeComponent, GradeService, GradeTest, PerformanceChartTest, ProductionReadinessWorkflowsTest

### Community 42 - "AuthController"
Cohesion: 0.12
Nodes (5): AuthController, PersonalAccessToken, PushToken, TokenIssuer, Laravel\Sanctum\PersonalAccessToken

### Community 43 - "LibraryBook"
Cohesion: 0.13
Nodes (3): LibraryController, LibraryBook, LibraryBorrowing

### Community 44 - "WarehouseItem"
Cohesion: 0.05
Nodes (10): WarehouseController, PurchaseRequest, StockMovement, WarehouseCategory, WarehouseItem, WarehouseItemFactory, ProcurementTest, UserGovernanceTest (+2 more)

### Community 45 - "button.tsx"
Cohesion: 0.11
Nodes (21): AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter(), AlertDialogHeader(), AlertDialogOverlay, AlertDialogTitle (+13 more)

### Community 46 - "PayrollRun"
Cohesion: 0.11
Nodes (5): Carbon\Carbon, PayrollController, PayrollRecord, PayrollCalculationService, PayrollStateService

### Community 47 - "4. API endpoints"
Cohesion: 0.09
Nodes (22): 1. Procurement module — DB schema, 1b. Inventory-side additions, 1c. Integration logic — `ProcurementService`, 2. Permission system (foundation for the Finance split), 3. Finance decomposition — DB schema, 3a. Installments — `2026_07_12_000004_create_installments_module.php`, 3b. Procurement Finance (AP) — `2026_07_12_000005_create_procurement_finance_module.php`, 3c. Payroll — `2026_07_12_000006_create_payroll_runs.php` (+14 more)

### Community 48 - "Illuminate\Console\Command"
Cohesion: 0.05
Nodes (17): Illuminate\Console\Command, Illuminate\Support\ServiceProvider, CleanAuditLogs, HrPayrollSchoolScopePreflight, OperationalSmokeCheck, PreflightEnvironment, ProcessScheduledNotifications, ProvisionAdmin (+9 more)

### Community 50 - "School"
Cohesion: 0.11
Nodes (3): TeacherController, HrRequest, Notifier

### Community 51 - "MedicalRecord"
Cohesion: 0.16
Nodes (3): MedicalController, MedicalRecord, MedicalVisit

### Community 52 - "Message"
Cohesion: 0.20
Nodes (3): MessagingController, AppNotification, Message

### Community 53 - "TeacherController"
Cohesion: 0.15
Nodes (12): Backend, Backup and restore — executed, not asserted, Defects found and fixed, Frontend, Load — k6 against the staging stack, Production readiness review — 2026-08-10, Release gates, Risks and open decisions (+4 more)

### Community 54 - "School Management API"
Cohesion: 0.10
Nodes (19): Admin (`/api/admin/*`, role `admin`), Attendance edit window, Audit log, Audit log coverage, Authentication, Database, Deploy to Railway, Environment variables to set in the Railway dashboard (+11 more)

### Community 55 - "item.tsx"
Cohesion: 0.06
Nodes (27): react, react, Carousel, CarouselApi, CarouselContent, CarouselContext, CarouselContextProps, CarouselItem (+19 more)

### Community 56 - "PaymentPlan"
Cohesion: 0.09
Nodes (5): StudentController, Assignment, Submission, AssignmentService, PerformanceChartService

### Community 57 - "StudentController"
Cohesion: 0.16
Nodes (4): Illuminate\Database\Eloquent\Builder, AttendanceRecord, AttendanceSubmissionBatch, AttendanceService

### Community 59 - "components.json"
Cohesion: 0.12
Nodes (16): aliases, components, hooks, lib, ui, utils, rsc, $schema (+8 more)

### Community 60 - "menubar.tsx"
Cohesion: 0.12
Nodes (11): Menubar, MenubarCheckboxItem, MenubarContent, MenubarItem, MenubarLabel, MenubarRadioItem, MenubarSeparator, MenubarShortcut() (+3 more)

### Community 61 - "Carbon"
Cohesion: 0.10
Nodes (8): CheckContractRenewals, PayrollSettingsController, ContractAlertDelivery, HrPayrollSetting, PayrollComponent, SocialInsuranceScheme, StaffPayrollComponent, HrPayrollWorkspaceTest

### Community 63 - "TeacherFullTest"
Cohesion: 0.05
Nodes (9): ClassRoom, Subject, AssignmentFactory, static, GradeComponentFactory, static, AdminAcademicTest, AttendanceTest (+1 more)

### Community 67 - "Gradebook"
Cohesion: 0.27
Nodes (3): Gradebook, ReportCardIssue, GradebookWorkflowService

### Community 70 - "PaymentGatewayService"
Cohesion: 0.22
Nodes (3): PaymentTransaction, PaymentGatewayService, Stripe\StripeClient

### Community 71 - "chart.tsx"
Cohesion: 0.10
Nodes (13): Illuminate\Broadcasting\InteractsWithSockets, Illuminate\Bus\Queueable, Illuminate\Contracts\Broadcasting\ShouldBroadcast, Illuminate\Foundation\Events\Dispatchable, Illuminate\Mail\Mailable, Illuminate\Queue\SerializesModels, GoodsReceived, NotificationReceived (+5 more)

### Community 74 - "PayrollSettingsController"
Cohesion: 0.18
Nodes (13): CardFooter, FormControl, FormDescription, FormField(), FormFieldContext, FormFieldContextValue, FormItem, FormItemContext (+5 more)

### Community 75 - "StaffProfile"
Cohesion: 0.25
Nodes (7): SelectContent, SelectItem, SelectLabel, SelectScrollDownButton, SelectScrollUpButton, SelectSeparator, SelectTrigger

### Community 76 - "NotificationTemplate"
Cohesion: 0.16
Nodes (3): NotificationController, DeviceToken, self

### Community 81 - "EmployeeAdvanceService"
Cohesion: 0.33
Nodes (3): Illuminate\Pagination\LengthAwarePaginator, Illuminate\Support\Collection, StudentFinanceService

### Community 85 - "ProcurementTest"
Cohesion: 0.28
Nodes (3): AuditLoggerRedactTest, ExampleTest, PHPUnit\Framework\TestCase

### Community 86 - "تقرير تجهيز School Management Suite للإنتاج"
Cohesion: 0.15
Nodes (12): أهم الإصلاحات المنفذة, أول نشر, الترحيل الجديد, الثوابت الأمنية والمالية, الرجوع الآمن, النسخ الاحتياطي والاسترجاع, بوابة الإطلاق الإلزامية, تقرير تجهيز School Management Suite للإنتاج (+4 more)

### Community 87 - "scripts"
Cohesion: 0.15
Nodes (13): scripts, build, build:pages, deploy, dev, lint, predeploy, serve (+5 more)

### Community 89 - "LoginForm.test.tsx"
Cohesion: 0.14
Nodes (12): AppLayout(), AppLayoutProps, PageTransition(), Props, financeAndAccountingNav, NavItem, navMap, Sidebar() (+4 more)

### Community 90 - "StudentFinanceService"
Cohesion: 0.25
Nodes (7): Breadcrumb, BreadcrumbEllipsis(), BreadcrumbItem, BreadcrumbLink, BreadcrumbList, BreadcrumbPage, BreadcrumbSeparator()

### Community 91 - "FinanceFullTest"
Cohesion: 0.20
Nodes (9): build, builder, dockerfilePath, deploy, numReplicas, restartPolicyType, sleepApplication, startCommand (+1 more)

### Community 92 - "toast.tsx"
Cohesion: 0.24
Nodes (10): Toast, ToastAction, ToastActionElement, ToastClose, ToastDescription, ToastProps, ToastTitle, toastVariants (+2 more)

### Community 93 - "package.json"
Cohesion: 0.18
Nodes (10): i18next, react-i18next, dependencies, i18next, react-i18next, homepage, name, private (+2 more)

### Community 94 - "GradeService"
Cohesion: 0.20
Nodes (9): build, builder, dockerfilePath, deploy, numReplicas, restartPolicyType, sleepApplication, startCommand (+1 more)

### Community 95 - "composer.json"
Cohesion: 0.18
Nodes (10): description, extra, laravel, dont-discover, license, minimum-stability, name, prefer-stable (+2 more)

### Community 96 - "scripts"
Cohesion: 0.18
Nodes (11): scripts, dev, post-autoload-dump, post-root-package-install, post-update-cmd, Composer\\Config::disableProcessTimeout, Illuminate\\Foundation\\ComposerScripts::postAutoloadDump, npx concurrently -c \"#93c5fd,#c4b5fd,#fb7185,#fdba74\" \"php artisan serve\" \"php artisan queue:listen --tries=1\" \"php artisan pail --timeout=0\" \"npm run dev\" --names=server,queue,logs,vite (+3 more)

### Community 97 - "HR and Payroll Workspace"
Cohesion: 0.18
Nodes (10): Audit result, Data model, Deployment, HR and Payroll Workspace, Journals, Legislative decisions, Manual verification, Payroll formula (+2 more)

### Community 103 - "require"
Cohesion: 0.20
Nodes (10): require, barryvdh/laravel-dompdf, laravel/framework, laravel/sanctum, laravel/tinker, league/flysystem-aws-s3-v3, php, pragmarx/google2fa (+2 more)

### Community 104 - "deploy"
Cohesion: 0.15
Nodes (12): build, builder, dockerfilePath, deploy, healthcheckPath, healthcheckTimeout, numReplicas, restartPolicyMaxRetries (+4 more)

### Community 109 - "context-menu.tsx"
Cohesion: 0.20
Nodes (9): ContextMenuCheckboxItem, ContextMenuContent, ContextMenuItem, ContextMenuLabel, ContextMenuRadioItem, ContextMenuSeparator, ContextMenuShortcut(), ContextMenuSubContent (+1 more)

### Community 110 - "Staff.tsx"
Cohesion: 0.10
Nodes (28): Avatar, AvatarFallback, AvatarImage, TabsContent, TabsList, TabsTrigger, mediaUrl(), AdminUsers() (+20 more)

### Community 114 - "SIS Domain Architecture Decisions"
Cohesion: 0.22
Nodes (8): Academic calendar, Course delivery, Deletion and retention, Enrollment, Gradebook lifecycle, Organizational scope, Required school approvals, SIS Domain Architecture Decisions

### Community 115 - "مساحة العمل المالية للطلاب"
Cohesion: 0.22
Nodes (8): التحقق التشغيلي المختصر, التشغيل, الصلاحيات الجديدة, القرار المعماري, حدود معروفة, دورة العمل, مساحة العمل المالية للطلاب, نقاط النهاية الرئيسية

### Community 123 - "input-group.tsx"
Cohesion: 0.28
Nodes (8): InputGroup(), InputGroupAddon(), inputGroupAddonVariants, InputGroupButton(), inputGroupButtonVariants, InputGroupInput(), InputGroupText(), InputGroupTextarea()

### Community 127 - "require-dev"
Cohesion: 0.25
Nodes (8): require-dev, fakerphp/faker, laravel/pail, laravel/pint, laravel/sail, mockery/mockery, nunomaduro/collision, phpunit/phpunit

### Community 128 - "Load Testing"
Cohesion: 0.25
Nodes (7): 1. Normal school day baseline, 2. Report card day peak, 3. Stress test / find breaking point, Load Testing, Metrics, Prerequisites, Run Commands

### Community 131 - "drawer.tsx"
Cohesion: 0.25
Nodes (6): DrawerContent, DrawerDescription, DrawerFooter(), DrawerHeader(), DrawerOverlay, DrawerTitle

### Community 133 - "navigation-menu.tsx"
Cohesion: 0.25
Nodes (7): NavigationMenu, NavigationMenuContent, NavigationMenuIndicator, NavigationMenuList, NavigationMenuTrigger, navigationMenuTriggerStyle, NavigationMenuViewport

### Community 134 - "GPT handoff — School Management Suite"
Cohesion: 0.29
Nodes (6): GPT handoff — School Management Suite, Important remaining decisions / follow-up, Included projects, Useful commands, Validation completed, Work completed in the current pass

### Community 135 - "config"
Cohesion: 0.29
Nodes (7): pestphp/pest-plugin, php-http/discovery, config, allow-plugins, optimize-autoloader, preferred-install, sort-packages

### Community 142 - "2026_05_22_000001_add_performance_indexes.php"
Cohesion: 0.60
Nodes (5): down(), indexName(), safeDropIndex(), safeIndex(), up()

### Community 143 - "2026_08_03_000002_enforce_school_scope_across_modules.php"
Cohesion: 0.60
Nodes (5): down(), replaceIndexWithUnique(), replaceUnique(), replaceUniqueWithIndex(), up()

### Community 144 - "baseline.js"
Cohesion: 0.12
Nodes (15): ACCOUNTS, dashLatency, errorRate, loginLatency, options, READS, setup(), ACCOUNTS (+7 more)

### Community 145 - "peak.js"
Cohesion: 0.70
Nodes (4): createIndex(), down(), indexName(), up()

### Community 148 - "psr-4"
Cohesion: 0.40
Nodes (5): autoload, psr-4, App\\, Database\\Factories\\, Database\\Seeders\\

### Community 150 - "Staging and Restore Qualification"
Cohesion: 0.40
Nodes (4): Commands, First verified local run, Scope, Staging and Restore Qualification

### Community 151 - "Uptime Robot Monitoring"
Cohesion: 0.40
Nodes (4): Alert Settings, Monitors, Response Validation, Uptime Robot Monitoring

### Community 154 - "vite.config.ts"
Cohesion: 0.50
Nodes (3): cspPlugin(), port, productionCsp()

### Community 155 - "post-create-project-cmd"
Cohesion: 0.50
Nodes (4): post-create-project-cmd, @php artisan key:generate --ansi, @php artisan migrate --graceful --ansi, @php -r \"file_exists('database/database.sqlite') || touch('database/database.sqlite');\

### Community 157 - "CI/CD Environment Variables"
Cohesion: 0.50
Nodes (3): CI/CD Environment Variables, How to generate values, Notes

### Community 158 - "Foreign-Key Retention Inventory"
Cohesion: 0.50
Nodes (3): Foreign-Key Retention Inventory, Known destructive legacy constraints, Migration sequence

### Community 160 - "autoload-dev"
Cohesion: 0.67
Nodes (3): autoload-dev, psr-4, Tests\\

### Community 161 - "keywords"
Cohesion: 0.67
Nodes (3): keywords, framework, laravel

## Knowledge Gaps
- **773 isolated node(s):** `$schema`, `name`, `type`, `description`, `laravel` (+768 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **123 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `User` connect `User` to `TestCase`, `Illuminate\Database\Eloquent\Relations\BelongsTo`, `Illuminate\Http\Request`, `Illuminate\Database\Eloquent\Relations\BelongsToMany`, `toggle-group.tsx`, `Illuminate\Database\Eloquent\Model`, `NotificationService`, `badge.tsx`, `Illuminate\Database\Eloquent\Relations\HasMany`, `Controller`, `UserManagementService`, `HrController`, `StudentProfile`, `NotificationController`, `AuditLogger`, `Illuminate\Database\Eloquent\Factories\Factory`, `ApiResponse`, `JournalEntry`, `Grade`, `AuthController`, `LibraryBook`, `WarehouseItem`, `Illuminate\Console\Command`, `PaymentReceipt`, `School`, `Message`, `PaymentPlan`, `StudentController`, `FinanceSubmodulesTest`, `Carbon`, `NotificationReceived`, `TeacherFullTest`, `StudentPolicy`, `JournalBatch`, `StudentEnrollment`, `MfaController`, `chart.tsx`, `GoodsReceipt`, `NotificationTemplate`, `EmployeeAdvanceService`, `SupplierInvoice`, `PayrollAccountingService`, `carousel.tsx`, `AdminOpsTest`, `IdorTest`, `FinancialWorkspaceTest`, `ProcurementUserLifecycleTest`, `.calculate`, `AdminTest`, `HealthTest`, `TransportTest`?**
  _High betweenness centrality (0.080) - this node is a cross-community bridge._
- **Why does `cn()` connect `cn` to `toArray`, `drawer.tsx`, `BrandCard.tsx`, `navigation-menu.tsx`, `BrandButton.tsx`, `SchoolSettings.tsx`, `utils.ts`, `DashboardPage.tsx`, `PurchaseOrders.tsx`, `useAuth`, `AppShell.tsx`, `AttendanceRecord`, `button.tsx`, `item.tsx`, `menubar.tsx`, `PayrollSettingsController`, `StaffProfile`, `LoginForm.test.tsx`, `StudentFinanceService`, `toast.tsx`, `context-menu.tsx`, `Staff.tsx`, `input-group.tsx`?**
  _High betweenness centrality (0.036) - this node is a cross-community bridge._
- **Why does `devDependencies` connect `devDependencies` to `react-dom`, `react-hook-form`, `react-icons`, `react-resizable-panels`, `recharts`, `sonner`, `tailwind-merge`, `tailwindcss`, `@tailwindcss/typography`, `@tailwindcss/vite`, `@tanstack/react-query`, `@testing-library/jest-dom`, `@testing-library/react`, `@testing-library/user-event`, `tw-animate-css`, `@types/node`, `@types/react`, `vite`, `@vitejs/plugin-react`, `vitest`, `@vitest/coverage-v8`, `wouter`, `@babel/parser`, `item.tsx`, `@babel/core`, `@babel/generator`, `clsx`, `cmdk`, `date-fns`, `embla-carousel-react`, `eslint`, `eslint-plugin-jsx-a11y`, `framer-motion`, `gh-pages`, `globals`, `@hookform/resolvers`, `input-otp`, `jsdom`, `package.json`, `form.tsx`, `lucide-react`, `msw`, `next-themes`, `@playwright/test`, `@radix-ui/react-alert-dialog`, `@radix-ui/react-aspect-ratio`, `@radix-ui/react-checkbox`, `@radix-ui/react-context-menu`, `@radix-ui/react-dialog`, `@radix-ui/react-dropdown-menu`, `@radix-ui/react-hover-card`, `@radix-ui/react-label`, `@radix-ui/react-menubar`, `@radix-ui/react-navigation-menu`, `@radix-ui/react-popover`, `@radix-ui/react-progress`, `@radix-ui/react-radio-group`, `@radix-ui/react-scroll-area`, `@radix-ui/react-separator`, `@radix-ui/react-slider`, `@radix-ui/react-slot`, `@radix-ui/react-switch`, `@radix-ui/react-tabs`, `@radix-ui/react-toast`, `@radix-ui/react-toggle-group`, `react-day-picker`?**
  _High betweenness centrality (0.033) - this node is a cross-community bridge._
- **Are the 200 inferred relationships involving `User` (e.g. with `.handle()` and `.handle()`) actually correct?**
  _`User` has 200 INFERRED edges - model-reasoned connections that need verification._
- **What connects `$schema`, `name`, `type` to the rest of the system?**
  _773 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `toArray` be split into smaller, more focused modules?**
  _Cohesion score 0.050118926265715256 - nodes in this community are weakly interconnected._
- **Should `App.tsx` be split into smaller, more focused modules?**
  _Cohesion score 0.019801980198019802 - nodes in this community are weakly interconnected._