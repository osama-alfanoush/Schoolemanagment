<?php

use App\Http\Controllers\Api\AccountingController;
use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\EnrollmentController;
use App\Http\Controllers\Api\FileController;
use App\Http\Controllers\Api\FinanceController;
use App\Http\Controllers\Api\FinancialWorkspaceController;
use App\Http\Controllers\Api\GradebookController;
use App\Http\Controllers\Api\HealthController;
use App\Http\Controllers\Api\HrController;
use App\Http\Controllers\Api\HrPayrollController;
use App\Http\Controllers\Api\InstallmentController;
use App\Http\Controllers\Api\LibraryController;
use App\Http\Controllers\Api\MessagingController;
use App\Http\Controllers\Api\Mobile\ParentAcademicsController as MobileParentAcademicsController;
use App\Http\Controllers\Api\Mobile\ParentFinanceController as MobileParentFinanceController;
use App\Http\Controllers\Api\Mobile\ParentInboxController as MobileParentInboxController;
use App\Http\Controllers\Api\Mobile\ParentHomeController as MobileParentHomeController;
use App\Http\Controllers\Api\Mobile\SyncController as MobileSyncController;
use App\Http\Controllers\Api\Mobile\TeacherController as MobileTeacherController;
use App\Http\Controllers\Api\MfaController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\ParentController;
use App\Http\Controllers\Api\ParentInviteController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\PayrollController;
use App\Http\Controllers\Api\PayrollSettingsController;
use App\Http\Controllers\Api\ProcurementController;
use App\Http\Controllers\Api\ProcurementFinanceController;
use App\Http\Controllers\Api\StudentController;
use App\Http\Controllers\Api\TeacherController;
use App\Http\Controllers\Api\TransportController;
use App\Http\Controllers\Api\WarehouseController;
use App\Http\Middleware\AccountLockout;
use App\Http\Middleware\EnsureParentOwnsChild;
use Illuminate\Support\Facades\Route;

Route::get('/healthz', fn () => response()->json(['status' => 'ok']));

// Public auth endpoints with rate limiting
Route::get('/auth/csrf-cookie', [AuthController::class, 'csrfCookie'])
    ->middleware('throttle:60,1');
Route::post('/auth/login', [AuthController::class, 'login'])
    ->middleware(['throttle:login', AccountLockout::class]);
Route::post('/auth/forgot-password', [AuthController::class, 'forgotPassword'])
    ->middleware('throttle:3,5');
Route::post('/auth/reset-password', [AuthController::class, 'resetPassword'])
    ->middleware('throttle:5,30');
// Stub named route the framework references when generating reset-link emails.
// In a real client app the user is sent here with the token + email, then POSTs to /api/auth/reset-password.
Route::get('/auth/password/reset/{token}', fn (string $token) => response()->json([
    'message' => 'Use POST /api/auth/reset-password with this token, your email, and the new password.',
    'token' => $token,
]))->name('password.reset');
// Refresh has its own throttle — high limit since it's used frequently for token rotation
Route::post('/auth/refresh', [AuthController::class, 'refresh'])
    ->middleware(['auth:sanctum', 'account.active', 'abilities:refresh', 'school.context', 'throttle:30,1']);

// Guardian activation without a password. Public because the guardian has no
// session and no password yet -- that is the point: a Jordanian parent will not
// manage a password reset, and every failure of one becomes a phone call to the
// school office. Throttled hard, single-use and attempt-capped in the service.
Route::post('/mobile/v1/onboarding/activate', [ParentInviteController::class, 'activate'])
    ->middleware('throttle:10,10');

Route::middleware(['auth:sanctum', 'account.active', 'school.context', 'throttle:5,1'])->group(function () {
    Route::post('/auth/mfa/enroll', [MfaController::class, 'enroll'])->middleware('token.usable:mfa-enroll');
    Route::post('/auth/mfa/confirm', [MfaController::class, 'confirm'])->middleware('token.usable:mfa-enroll');
    Route::post('/auth/mfa/challenge', [MfaController::class, 'challenge'])->middleware('token.usable:mfa-challenge');
});

Route::middleware(['auth:sanctum', 'account.active', 'token.usable:access', 'password.changed', 'school.context'])->group(function () {
    Route::get('/auth/me', [AuthController::class, 'me']);
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::patch('/auth/profile', [AuthController::class, 'updateProfile']);
    Route::post('/auth/profile/photo', [AuthController::class, 'uploadProfilePhoto']);
    Route::post('/auth/change-password', [AuthController::class, 'changePassword']);
    Route::post('/auth/push-token', [AuthController::class, 'registerPushToken']);
    Route::post('/auth/mfa/recovery-codes', [MfaController::class, 'regenerateRecoveryCodes'])->middleware('throttle:5,1');
    Route::post('/auth/mfa/disable', [MfaController::class, 'disable'])->middleware('throttle:5,1');
    Route::get('/health', HealthController::class)->middleware('role:admin');

    // Private files. The only route out of the private disk; every action
    // checks school scope, record ownership and role before streaming. Rate
    // limited because a download endpoint keyed by record id is the natural
    // place to attempt enumeration.
    Route::middleware('throttle:120,1')->prefix('files')->group(function () {
        Route::get('/profile-photo/{userId}', [FileController::class, 'profilePhoto'])->whereNumber('userId');
        Route::get('/assignment/{assignmentId}/attachment', [FileController::class, 'assignmentAttachment'])->whereNumber('assignmentId');
        Route::get('/submission/{submissionId}', [FileController::class, 'submission'])->whereNumber('submissionId');
    });

    Route::get('/school-settings', [AdminController::class, 'getSchoolSettings']);
    Route::get('/hr-requests', [HrController::class, 'myRequests']);
    Route::post('/hr-requests', [HrController::class, 'submitRequest']);

    // Messaging
    Route::get('/messages/threads', [MessagingController::class, 'threads']);
    Route::get('/messages/recipients', [MessagingController::class, 'recipients']);
    Route::get('/messages/conversation/{otherId}', [MessagingController::class, 'conversation']);
    Route::post('/messages', [MessagingController::class, 'send']);

    // NOTIFICATION SYSTEM (Enhanced)
    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::get('/notifications/unread-count', [NotificationController::class, 'unreadCount']);
    Route::patch('/notifications/{id}/read', [NotificationController::class, 'markAsRead']);
    Route::patch('/notifications/read-all', [NotificationController::class, 'markAllAsRead']);
    Route::patch('/notifications/{id}/click', [NotificationController::class, 'markAsClicked']);
    Route::get('/notifications/preferences', [NotificationController::class, 'getPreferences']);
    Route::patch('/notifications/preferences', [NotificationController::class, 'updatePreferences']);
    Route::post('/notifications/register-device', [NotificationController::class, 'registerDevice']);
    Route::post('/notifications/unregister-device', [NotificationController::class, 'unregisterDevice']);
    Route::get('/notifications/devices', [NotificationController::class, 'getDevices']);

    // PAYMENT GATEWAY
    Route::post('/payments/create-intent', [PaymentController::class, 'createPaymentIntent']);
    Route::post('/payments/confirm', [PaymentController::class, 'confirmPayment']);
    Route::get('/payments/status/{paymentIntentId}', [PaymentController::class, 'getStatus']);
    Route::get('/payments/methods', [PaymentController::class, 'getPaymentMethods']);
    Route::post('/payments/setup-intent', [PaymentController::class, 'createSetupIntent']);

    // MOBILE (v1)
    // The bearer-token surface the Flutter app talks to. Every route here
    // resolves its scope from the authenticated token: nothing in the request
    // selects a school, a child or a class. Throttled separately from the web
    // API because a sync client polls far more often than a person clicks.
    Route::prefix('mobile/v1')
        ->middleware(['role:parent,student,teacher', 'throttle:120,1'])
        ->group(function () {
            Route::get('/sync/delta', [MobileSyncController::class, 'delta']);

            // Everything the app needs before its first screen. Open to every
            // mobile role; what comes back is scoped to the roles the token
            // actually holds.
            Route::get('/session/bootstrap', [MobileParentHomeController::class, 'bootstrap']);

            // NOTIFICATIONS. Read state is the same `read_at` column the web
            // writes, so a notice read on the phone is read on the website.
            Route::get('/notifications', [MobileParentInboxController::class, 'notifications']);
            Route::patch('/notifications/{notificationId}/read', [MobileParentInboxController::class, 'markRead'])
                ->whereNumber('notificationId');
            Route::get('/notifications/preferences', [MobileParentInboxController::class, 'preferences']);
            Route::patch('/notifications/preferences', [MobileParentInboxController::class, 'updatePreferences']);

            // PARENT
            // EnsureParentOwnsChild guards the child-scoped path, and the
            // controller repeats the ownership check: this is one route
            // registration away from being reachable without the middleware.
            Route::middleware(['role:parent', EnsureParentOwnsChild::class])
                ->prefix('parent')
                ->group(function () {
                    Route::get('/home', [MobileParentHomeController::class, 'home']);
                    Route::get('/children/{id}/overview', [MobileParentHomeController::class, 'childOverview'])
                        ->whereNumber('id');

                    // FINANCE. The collection surface: what a family owes, what
                    // they have paid, and the intent to pay the next thing.
                    Route::get('/finance/summary', [MobileParentFinanceController::class, 'summary']);
                    // Named {studentId} on purpose: EnsureParentOwnsChild
                    // recognises `id` and `studentId`, so this path is guarded
                    // by the middleware as well as by the controller.
                    Route::get('/children/{studentId}/installments', [MobileParentFinanceController::class, 'installments'])
                        ->whereNumber('studentId');
                    Route::get('/invoices', [MobileParentFinanceController::class, 'invoices']);

                    // NOT named {id}: EnsureParentOwnsChild reads `id` as a
                    // *student* id, so an invoice id there would be checked
                    // against the child list and always refused.
                    Route::get('/invoices/{invoiceId}', [MobileParentFinanceController::class, 'invoice'])
                        ->whereNumber('invoiceId');
                    Route::get('/receipts/{receiptId}/pdf', [MobileParentFinanceController::class, 'receiptPdf'])
                        ->whereNumber('receiptId');

                    // Idempotency-Key is required, and the unique index on it
                    // is what makes a double tap one payment rather than two.
                    Route::post('/pay/{installmentId}/intent', [MobileParentFinanceController::class, 'payIntent'])
                        ->whereNumber('installmentId');

                    // ACADEMICS. Marks appear only once their gradebook is
                    // finalized, and a report card only once it has been
                    // issued -- an unissued one has no row to reach.
                    Route::get('/children/{studentId}/attendance', [MobileParentAcademicsController::class, 'attendance'])
                        ->whereNumber('studentId');
                    Route::get('/children/{studentId}/grades', [MobileParentAcademicsController::class, 'grades'])
                        ->whereNumber('studentId');
                    Route::get('/children/{studentId}/report-cards', [MobileParentAcademicsController::class, 'reportCards'])
                        ->whereNumber('studentId');

                    // Keyed on an issue id, which EnsureParentOwnsChild cannot
                    // interpret, so ownership is checked in the controller.
                    Route::get('/report-cards/{issueId}/pdf', [MobileParentAcademicsController::class, 'reportCardPdf'])
                        ->whereNumber('issueId');

                    Route::post('/attendance/{recordId}/explain', [MobileParentAcademicsController::class, 'explainAbsence'])
                        ->whereNumber('recordId');

                    // MESSAGES. Reply-only by design: a guardian may answer a
                    // thread staff opened and cannot start one. There is no
                    // route here that creates a thread.
                    Route::get('/messages', [MobileParentInboxController::class, 'threads']);
                    Route::get('/messages/{otherId}', [MobileParentInboxController::class, 'conversation'])
                        ->whereNumber('otherId');
                    Route::post('/messages/{otherId}/reply', [MobileParentInboxController::class, 'reply'])
                        ->whereNumber('otherId');

                    Route::get('/children/{studentId}/timetable', [MobileParentInboxController::class, 'timetable'])
                        ->whereNumber('studentId');
                    Route::post('/children/{studentId}/correction', [MobileParentInboxController::class, 'requestCorrection'])
                        ->whereNumber('studentId');
                });

            // TEACHER
            // Scoped to assigned classes only. The class id is a claim by the
            // client wherever it appears -- path or body -- so the controller
            // checks it against the assignment on every call and logs the
            // refusal. Reading another section's roster is the one failure
            // here a school would call a breach.
            Route::middleware('role:teacher')->prefix('teacher')->group(function () {
                Route::get('/today', [MobileTeacherController::class, 'today']);
                Route::get('/roster/{classId}', [MobileTeacherController::class, 'roster'])
                    ->whereNumber('classId');

                // The mark sheet, with the workflow state and every score's
                // version, so a locked gradebook reads as locked on the phone
                // instead of at submission time.
                Route::get('/gradebook/{classId}/{subjectId}', [MobileTeacherController::class, 'gradebook'])
                    ->whereNumber('classId')
                    ->whereNumber('subjectId');

                // Both writes require Idempotency-Key: this is what an offline
                // phone drains into, so every batch will arrive twice sooner
                // or later.
                Route::post('/attendance/batch', [MobileTeacherController::class, 'attendanceBatch']);
                Route::post('/grades/batch', [MobileTeacherController::class, 'gradesBatch']);
            });
        });

    // STUDENT
    Route::middleware('role:student')->prefix('student')->group(function () {
        Route::get('/dashboard', [StudentController::class, 'dashboard']);
        Route::get('/timetable', [StudentController::class, 'timetable']);
        Route::get('/assignments', [StudentController::class, 'assignments']);
        Route::post('/assignments/{id}/submit', [StudentController::class, 'submitAssignment']);
        Route::get('/grades', [StudentController::class, 'grades']);
        Route::get('/attendance', [StudentController::class, 'attendance']);
        Route::get('/report-card', [StudentController::class, 'reportCard']);
        Route::get('/report-card/pdf', [StudentController::class, 'reportCardPdf']);
        Route::get('/announcements', [StudentController::class, 'announcements']);
        Route::get('/calendar', [StudentController::class, 'calendar']);
        Route::get('performance-chart', [StudentController::class, 'performanceChart']);

        // Library
        Route::get('/library/books', [LibraryController::class, 'availableBooks']);
        Route::get('/library/my-borrowings', [LibraryController::class, 'myBorrowings']);
        Route::post('/library/books/{id}/borrow', [LibraryController::class, 'selfBorrow']);
        Route::post('/library/borrowings/{id}/return', [LibraryController::class, 'selfReturn']);

        // Transport
        Route::get('/transport/my-route', [TransportController::class, 'myRoute']);

    });

    // PARENT
    Route::middleware(['role:parent', EnsureParentOwnsChild::class])->prefix('parent')->group(function () {
        Route::get('/children', [ParentController::class, 'children']);
        Route::get('/children/{id}/overview', [ParentController::class, 'childOverview']);
        Route::get('/children/{id}/grades', [ParentController::class, 'childGrades']);
        Route::get('/children/{id}/assignments', [ParentController::class, 'childAssignments']);
        Route::get('/children/{id}/attendance', [ParentController::class, 'childAttendance']);
        Route::get('/children/{id}/invoices', [ParentController::class, 'childInvoices']);
        Route::get('/children/{id}/payments', [ParentController::class, 'paymentHistory']);
        Route::get('/children/{id}/conduct', [ParentController::class, 'childConduct']);
        Route::get('/children/{id}/report-card', [ParentController::class, 'childReportCard']);
        Route::get('/children/{id}/report-card/pdf', [ParentController::class, 'childReportCardPdf']);
        Route::get('children/{id}/performance-chart', [ParentController::class, 'childPerformanceChart']);
        Route::get('/children/{id}/invoices/{invoiceId}/receipt-pdf', [ParentController::class, 'invoiceReceipt']);
        Route::get('/announcements', [ParentController::class, 'announcements']);

        // Transport
        Route::get('/children/{id}/transport', [TransportController::class, 'childTransport']);
    });

    // TEACHER
    Route::middleware('role:teacher')->prefix('teacher')->group(function () {
        Route::get('/classes', [TeacherController::class, 'myClasses']);
        Route::get('/timetable', [TeacherController::class, 'myTimetable']);
        Route::get('/classes/{classRoomId}/students', [TeacherController::class, 'classStudents']);
        Route::post('/assignments', [TeacherController::class, 'createAssignment']);
        Route::get('/assignments/{id}/submissions', [TeacherController::class, 'assignmentSubmissions']);
        Route::patch('/submissions/{id}/grade', [TeacherController::class, 'gradeSubmission']);
        Route::post('/attendance', [TeacherController::class, 'markAttendance']);
        Route::match(['get', 'post'], '/grade-components/{classId}/{subjectId}', [TeacherController::class, 'gradeComponents']);
        Route::get('grades/export', [TeacherController::class, 'exportGrades']);
        Route::post('/grades', [TeacherController::class, 'enterGrade']);
        Route::post('/gradebooks/{id}/submit', [GradebookController::class, 'submit']);
        Route::get('/gradebooks/{id}', [GradebookController::class, 'show']);
        Route::post('/conduct', [TeacherController::class, 'logConduct']);
        Route::get('/announcements', [TeacherController::class, 'getAnnouncements']);
        Route::post('/announcements', [TeacherController::class, 'announce']);
        Route::post('/hr-requests', [HrController::class, 'submitRequest']);
        Route::get('/hr-requests', [HrController::class, 'myRequests']);
    });

    // ADMIN
    Route::middleware('role:admin')->prefix('admin')->group(function () {
        Route::post('/users/{userId}/mfa-recovery', [MfaController::class, 'requestHelpDeskRecovery']);
        Route::post('/mfa-recovery/{requestId}/approve', [MfaController::class, 'approveHelpDeskRecovery']);
        Route::post('/gradebooks/{id}/approve', [GradebookController::class, 'approve']);
        Route::get('/gradebooks/{id}', [GradebookController::class, 'show']);
        Route::post('/gradebooks/{id}/return', [GradebookController::class, 'returnForCorrection']);
        Route::post('/gradebooks/{id}/finalize', [GradebookController::class, 'finalize']);
        Route::post('/gradebooks/{id}/reopen', [GradebookController::class, 'reopen']);
        Route::post('/report-cards/issue', [GradebookController::class, 'issue']);
        Route::get('/users', [AdminController::class, 'listUsers']);
        Route::post('/users', [AdminController::class, 'createUser']);
        Route::patch('/users/{id}', [AdminController::class, 'updateUser']);
        Route::delete('/users/{id}', [AdminController::class, 'deactivateUser']);
        Route::post('/users/link-parent', [AdminController::class, 'linkParentStudent']);
        // Issues the code the office hands to a guardian. The plaintext is in
        // the response and nowhere else.
        Route::post('/parent-invites', [ParentInviteController::class, 'store']);
        Route::post('/users/import-students', [AdminController::class, 'bulkImportStudents']);
        Route::post('/enrollments', [EnrollmentController::class, 'store']);
        Route::post('/enrollments/{enrollment}/transfer', [EnrollmentController::class, 'transfer']);
        Route::match(['get', 'post'], '/classes', [AdminController::class, 'classes']);
        Route::patch('/classes/{id}', [AdminController::class, 'updateClass']);
        Route::delete('/classes/{id}', [AdminController::class, 'deleteClass']);
        Route::post('/classes/{id}/assign-subject-teacher', [AdminController::class, 'assignSubjectTeacher']);
        Route::match(['get', 'post'], '/classes/{id}/timetable', [AdminController::class, 'timetable']);
        Route::delete('/classes/{classId}/timetable/{id}', [AdminController::class, 'deleteTimetableEntry']);
        Route::match(['get', 'post'], '/calendar', [AdminController::class, 'calendar']);
        Route::patch('/calendar/{id}', [AdminController::class, 'updateCalendarEvent']);
        Route::delete('/calendar/{id}', [AdminController::class, 'deleteCalendarEvent']);
        Route::get('/attendance/dashboard', [AdminController::class, 'attendanceDashboard']);
        Route::get('/hr-requests', [AdminController::class, 'hrRequests']);
        Route::patch('/hr-requests/{id}/review', [AdminController::class, 'reviewHrRequest']);
        Route::get('/dashboard/kpis', [AdminController::class, 'dashboardKpis']);
        Route::post('/announcements', [AdminController::class, 'announce']);
        Route::get('/reports/monthly', [AdminController::class, 'monthlyReport']);
        Route::get('/announcements', [AdminController::class, 'getAnnouncements']);
        Route::delete('/announcements/{id}', [AdminController::class, 'deleteAnnouncement']);
        Route::get('/audit-logs', [AdminController::class, 'auditLogs']);
        Route::match(['get', 'post'], '/subjects', [AdminController::class, 'subjects']);
        Route::patch('/subjects/{id}', [AdminController::class, 'updateSubject']);
        Route::delete('/subjects/{id}', [AdminController::class, 'deleteSubject']);
        Route::match(['get', 'post'], '/exams', [AdminController::class, 'exams']);
        Route::patch('/exams/{id}', [AdminController::class, 'updateExam']);
        Route::delete('/exams/{id}', [AdminController::class, 'deleteExam']);
        Route::match(['get', 'post'], '/academic-years', [AdminController::class, 'academicYears']);
        Route::patch('/academic-years/{id}', [AdminController::class, 'updateAcademicYear']);
        Route::delete('/academic-years/{id}', [AdminController::class, 'deleteAcademicYear']);
        Route::get('/school-settings', [AdminController::class, 'getSchoolSettings']);
        Route::post('/school-settings', [AdminController::class, 'updateSchoolSettings']);

        // Granular permissions management
        Route::get('/permissions', [AdminController::class, 'listPermissions']);
        Route::get('/roles/{role}/permissions', [AdminController::class, 'rolePermissions']);
        Route::put('/roles/{role}/permissions', [AdminController::class, 'updateRolePermissions']);
        Route::get('/users/{id}/permissions', [AdminController::class, 'userPermissions']);
        Route::put('/users/{id}/permissions', [AdminController::class, 'updateUserPermissions']);

        // Notification Management
        Route::get('/notifications/templates', [NotificationController::class, 'getTemplates']);
        Route::patch('/notifications/templates/{id}', [NotificationController::class, 'updateTemplate']);
        Route::post('/notifications/seed-templates', [NotificationController::class, 'seedTemplates']);
        Route::post('/notifications/send-test', [NotificationController::class, 'sendTest']);
        Route::post('/notifications/send-bulk', [NotificationController::class, 'sendBulk']);
        Route::get('/notifications/analytics', [NotificationController::class, 'analytics']);
        Route::delete('/notifications/cleanup', [NotificationController::class, 'cleanup']);

        // Library Management
        Route::match(['get', 'post'], '/library/books', [LibraryController::class, 'books']);
        Route::patch('/library/books/{id}', [LibraryController::class, 'updateBook']);
        Route::get('/library/borrowings', [LibraryController::class, 'allBorrowings']);
        Route::get('/library/overdue', [LibraryController::class, 'overdueBooks']);

        // Transport Management
        Route::match(['get', 'post'], '/transport/routes', [TransportController::class, 'routes']);
        Route::match(['get', 'post'], '/transport/vehicles', [TransportController::class, 'vehicles']);
        Route::match(['get', 'post'], '/transport/stops', [TransportController::class, 'stops']);
        Route::get('/transport/assignments', [TransportController::class, 'allAssignments']);

    });

    // PROCUREMENT
    // Coarse role gate for the module, then per-action perm: gates so e.g. a
    // warehouse user can post goods receipts but never approve or delete.
    Route::prefix('procurement')->middleware('role:procurement,warehouse,finance,admin')->group(function () {
        Route::get('/suppliers', [ProcurementController::class, 'indexSuppliers'])->middleware('perm:procurement.view');
        Route::post('/suppliers', [ProcurementController::class, 'storeSupplier'])->middleware('perm:procurement.create');
        Route::get('/suppliers/{id}', [ProcurementController::class, 'showSupplier'])->middleware('perm:procurement.view');
        Route::patch('/suppliers/{id}', [ProcurementController::class, 'updateSupplier'])->middleware('perm:procurement.edit');
        Route::delete('/suppliers/{id}', [ProcurementController::class, 'destroySupplier'])->middleware('perm:procurement.delete');
        Route::get('/suppliers/{id}/transactions', [ProcurementController::class, 'supplierTransactions'])->middleware('perm:procurement.view');

        Route::get('/purchase-orders', [ProcurementController::class, 'indexPurchaseOrders'])->middleware('perm:procurement.view');
        Route::post('/purchase-orders', [ProcurementController::class, 'storePurchaseOrder'])->middleware('perm:procurement.create');
        Route::get('/purchase-orders/{id}', [ProcurementController::class, 'showPurchaseOrder'])->middleware('perm:procurement.view');
        Route::patch('/purchase-orders/{id}', [ProcurementController::class, 'updatePurchaseOrder'])->middleware('perm:procurement.edit');
        Route::post('/purchase-orders/{id}/submit', [ProcurementController::class, 'submitPurchaseOrder'])->middleware('perm:procurement.edit');
        Route::post('/purchase-orders/{id}/approve', [ProcurementController::class, 'approvePurchaseOrder'])->middleware('perm:procurement.approve');
        Route::post('/purchase-orders/{id}/cancel', [ProcurementController::class, 'cancelPurchaseOrder'])->middleware('perm:procurement.approve');
        // Inventory sync entry point: posts a GRN, moves stock in, updates costs.
        Route::post('/purchase-orders/{id}/receive', [ProcurementController::class, 'receivePurchaseOrder'])->middleware('perm:procurement.receive');

        Route::get('/goods-receipts', [ProcurementController::class, 'indexGoodsReceipts'])->middleware('perm:procurement.view');
        Route::get('/goods-receipts/{id}', [ProcurementController::class, 'showGoodsReceipt'])->middleware('perm:procurement.view');

        // Read-only item catalogue so procurement can build PO lines without
        // needing access to the warehouse module itself.
        Route::get('/items', [WarehouseController::class, 'indexItems'])->middleware('perm:procurement.view');

        Route::get('/dashboard', [ProcurementController::class, 'dashboard'])->middleware('perm:procurement.view');
    });

    // FINANCE — Procurement Finance sub-module (accounts payable)
    Route::prefix('finance/ap')->middleware('role:finance,procurement,admin')->group(function () {
        Route::get('/supplier-invoices', [ProcurementFinanceController::class, 'indexInvoices'])->middleware('perm:finance.procurement.view');
        Route::post('/supplier-invoices', [ProcurementFinanceController::class, 'storeInvoice'])->middleware('perm:finance.procurement.create');
        Route::get('/supplier-invoices/{id}', [ProcurementFinanceController::class, 'showInvoice'])->middleware('perm:finance.procurement.view');
        Route::patch('/supplier-invoices/{id}', [ProcurementFinanceController::class, 'updateInvoice'])->middleware('perm:finance.procurement.edit');
        Route::delete('/supplier-invoices/{id}', [ProcurementFinanceController::class, 'cancelInvoice'])->middleware('perm:finance.procurement.delete');
        Route::post('/supplier-invoices/{id}/payments', [ProcurementFinanceController::class, 'recordPayment'])->middleware('perm:finance.procurement.approve');
        Route::get('/reports/ap-aging', [ProcurementFinanceController::class, 'apAging'])->middleware('perm:finance.procurement.view');
    });

    // FINANCE — Installments sub-module (student payment plans)
    Route::prefix('finance/installments')->middleware('role:finance,admin')->group(function () {
        Route::get('/plans', [InstallmentController::class, 'indexPlans'])->middleware('perm:finance.installments.view');
        Route::post('/plans', [InstallmentController::class, 'storePlan'])->middleware('perm:finance.installments.create');
        Route::get('/plans/{id}', [InstallmentController::class, 'showPlan'])->middleware('perm:finance.installments.view');
        Route::patch('/plans/{id}', [InstallmentController::class, 'updatePlan'])->middleware('perm:finance.installments.edit');
        Route::post('/plans/{id}/cancel', [InstallmentController::class, 'cancelPlan'])->middleware('perm:finance.installments.approve');
        Route::post('/installments/{id}/waive', [InstallmentController::class, 'waiveInstallment'])->middleware('perm:finance.installments.approve');
        Route::post('/installments/{id}/pay', [InstallmentController::class, 'payInstallment'])->middleware('perm:finance.installments.create');
        Route::get('/due', [InstallmentController::class, 'due'])->middleware('perm:finance.installments.view');
        Route::post('/send-reminders', [InstallmentController::class, 'sendReminders'])->middleware('perm:finance.installments.edit');
    });

    // FINANCE — Payroll sub-module (run-based workflow; legacy /finance/payroll
    // endpoints below remain for deployed clients)
    Route::prefix('finance/payroll')->middleware('role:finance,hr,admin')->group(function () {
        Route::get('/runs', [PayrollController::class, 'indexRuns'])->middleware('perm:finance.payroll.view');
        Route::post('/runs', [PayrollController::class, 'storeRun'])->middleware('perm:finance.payroll.create');
        Route::get('/runs/{id}', [PayrollController::class, 'showRun'])->middleware('perm:finance.payroll.view');
        Route::patch('/records/{id}', [PayrollController::class, 'updateRecord'])->middleware('perm:finance.payroll.edit');
        Route::post('/runs/{id}/process', [PayrollController::class, 'processRun'])->middleware('perm:finance.payroll.edit');
        Route::post('/runs/{id}/approve', [PayrollController::class, 'approveRun'])->middleware('perm:finance.payroll.approve');
        Route::post('/runs/{id}/pay', [PayrollController::class, 'payRun'])->middleware('perm:finance.payroll.approve');
        Route::post('/runs/{id}/reverse', [PayrollController::class, 'reverseRun'])->middleware('perm:payroll.runs.reverse');
        Route::get('/records/{id}/payslip', [PayrollController::class, 'payslip'])->middleware('perm:payroll.payslips.print');
        Route::get('/settings', [PayrollSettingsController::class, 'index'])->middleware('perm:payroll.settings.view');
        Route::post('/settings/components', [PayrollSettingsController::class, 'storeComponent'])->middleware('perm:payroll.settings.manage');
        Route::patch('/settings/components/{id}', [PayrollSettingsController::class, 'updateComponent'])->middleware('perm:payroll.settings.manage');
        Route::post('/settings/social-insurance', [PayrollSettingsController::class, 'storeScheme'])->middleware('perm:payroll.settings.manage');
        Route::patch('/settings/general', [PayrollSettingsController::class, 'updateGeneral'])->middleware('perm:payroll.settings.manage');
        Route::patch('/settings/accounts', [PayrollSettingsController::class, 'updateAccounts'])->middleware('perm:payroll.settings.manage');
        Route::post('/staff/{id}/components', [PayrollSettingsController::class, 'assignComponent'])->middleware('perm:hr.salary.edit');
    });

    Route::prefix('hr/advances')->middleware('role:finance,hr,admin')->group(function () {
        Route::get('/', [HrPayrollController::class, 'advances'])->middleware('perm:hr.advances.view');
        Route::post('/', [HrPayrollController::class, 'storeAdvance'])->middleware('perm:hr.advances.request');
        Route::get('/{id}', [HrPayrollController::class, 'showAdvance'])->middleware('perm:hr.advances.view');
        Route::post('/{id}/submit', [HrPayrollController::class, 'submitAdvance'])->middleware('perm:hr.advances.request');
        Route::post('/{id}/approve', [HrPayrollController::class, 'approveAdvance'])->middleware('perm:hr.advances.approve');
        Route::post('/{id}/reject', [HrPayrollController::class, 'rejectAdvance'])->middleware('perm:hr.advances.approve');
        Route::post('/{id}/cancel', [HrPayrollController::class, 'cancelAdvance'])->middleware('perm:hr.advances.request');
        Route::post('/{id}/disburse', [HrPayrollController::class, 'disburseAdvance'])->middleware('perm:hr.advances.disburse');
        Route::post('/{id}/settle', [HrPayrollController::class, 'settleAdvance'])->middleware('perm:hr.advances.settle');
        Route::post('/{id}/reschedule', [HrPayrollController::class, 'rescheduleAdvance'])->middleware('perm:hr.advances.settle');
    });

    // FINANCE
    Route::middleware('role:finance,admin')->prefix('finance')->group(function () {
        Route::get('/students/search', [FinancialWorkspaceController::class, 'searchStudents'])->middleware('perm:finance.student.view');
        Route::get('/students/{studentId}', [FinancialWorkspaceController::class, 'studentProfile'])->middleware('perm:finance.student.view');
        Route::get('/students/{studentId}/statement', [FinancialWorkspaceController::class, 'studentStatement'])->middleware('perm:finance.student.view');
        Route::get('/receipts', [FinancialWorkspaceController::class, 'indexReceipts'])->middleware('perm:finance.receipts.view');
        Route::post('/receipts', [FinancialWorkspaceController::class, 'storeReceipt'])->middleware('perm:finance.receipts.create');
        Route::get('/receipts/{id}', [FinancialWorkspaceController::class, 'showReceipt'])->middleware('perm:finance.receipts.view');
        Route::get('/receipts/{id}/pdf', [FinancialWorkspaceController::class, 'receiptPdf'])->middleware('perm:finance.receipts.view');
        Route::post('/receipts/{id}/approve', [FinancialWorkspaceController::class, 'approveReceipt'])->middleware('perm:finance.receipts.approve');
        Route::post('/receipts/{id}/post', [FinancialWorkspaceController::class, 'postReceipt'])->middleware('perm:finance.receipts.post');
        Route::post('/receipts/{id}/reverse', [FinancialWorkspaceController::class, 'reverseReceipt'])->middleware('perm:finance.receipts.reverse');
        Route::get('/adjustments', [FinancialWorkspaceController::class, 'indexAdjustments'])->middleware('perm:finance.adjustments.view');
        Route::post('/adjustments', [FinancialWorkspaceController::class, 'storeAdjustment'])->middleware('perm:finance.adjustments.create');
        Route::post('/adjustments/{id}/approve', [FinancialWorkspaceController::class, 'approveAdjustment'])->middleware('perm:finance.adjustments.approve');
        Route::post('/adjustments/{id}/post', [FinancialWorkspaceController::class, 'postAdjustment'])->middleware('perm:finance.adjustments.post');
        Route::post('/adjustments/{id}/reverse', [FinancialWorkspaceController::class, 'reverseAdjustment'])->middleware('perm:finance.adjustments.reverse');
        Route::get('/workspace-reports/{type}', [FinancialWorkspaceController::class, 'report'])->middleware('perm:finance.reports.view');
        Route::match(['get', 'post'], '/fee-structures', [FinanceController::class, 'feeStructures']);
        Route::patch('/fee-structures/{id}', [FinanceController::class, 'updateFeeStructure']);
        Route::delete('/fee-structures/{id}', [FinanceController::class, 'deleteFeeStructure']);
        Route::get('/invoices', [FinanceController::class, 'invoices']);
        Route::post('/invoices/generate', [FinanceController::class, 'generateInvoices']);
        Route::post('/invoices/{id}/payments', [FinanceController::class, 'recordPayment']);
        Route::post('/payments/reconcile', [FinanceController::class, 'reconcilePayments']);
        Route::get('/invoices/{id}/receipt-pdf', [FinanceController::class, 'invoiceReceipt']);
        Route::post('/invoices/send-reminders', [FinanceController::class, 'sendReminders']);
        Route::get('/outstanding', [FinanceController::class, 'outstandingByStudent']);
        Route::get('/payroll', [FinanceController::class, 'payroll']);
        Route::post('/payroll/process', [FinanceController::class, 'processPayroll']);
        Route::patch('/payroll/{id}/pay', [FinanceController::class, 'markPayrollPaid']);
        Route::get('/reports', [FinanceController::class, 'financialReports']);
    });

    // ACCOUNTING
    // Accounting module is now part of the unified Finance & Accounting role.
    Route::prefix('accounting')->middleware(['auth:sanctum', 'role:finance,admin'])->group(function () {
        Route::get('journal-batches', [AccountingController::class, 'indexJournalBatches'])->middleware('perm:finance.journal.view');
        Route::post('journal-batches', [AccountingController::class, 'storeJournalEntry'])->middleware('perm:finance.journal.create');
        Route::get('journal-batches/{id}', [AccountingController::class, 'showJournalBatch'])->middleware('perm:finance.journal.view');
        Route::post('journal-batches/{id}/approve', [AccountingController::class, 'approveJournalBatch'])->middleware('perm:finance.journal.approve');
        Route::post('journal-batches/{id}/post', [AccountingController::class, 'postJournalBatch'])->middleware('perm:finance.journal.post');
        Route::post('journal-batches/{id}/reverse', [AccountingController::class, 'reverseJournalBatch'])->middleware('perm:finance.journal.reverse');
        Route::get('journal-entries', [AccountingController::class, 'indexJournalEntries']);
        Route::post('journal-entries', [AccountingController::class, 'storeJournalEntry']);
        Route::get('journal-entries/{id}', [AccountingController::class, 'showJournalEntry']);
        Route::delete('journal-entries/{id}', [AccountingController::class, 'destroyJournalEntry']);

        Route::get('chart-of-accounts', [AccountingController::class, 'indexAccounts']);
        Route::post('chart-of-accounts', [AccountingController::class, 'storeAccount']);
        Route::patch('chart-of-accounts/{id}', [AccountingController::class, 'updateAccount']);

        Route::get('budget', [AccountingController::class, 'indexBudget']);
        Route::post('budget', [AccountingController::class, 'storeBudget']);
        Route::patch('budget/{id}', [AccountingController::class, 'updateBudget']);
        Route::post('budget/sync-actuals', [AccountingController::class, 'syncBudgetActuals']);

        Route::get('closings', [AccountingController::class, 'indexClosings']);
        Route::post('closings', [AccountingController::class, 'closeMonth']);

        Route::get('reports/trial-balance', [AccountingController::class, 'trialBalance']);
        Route::get('reports/trial-balance/pdf', [AccountingController::class, 'trialBalancePdf']);
        Route::get('reports/income-statement', [AccountingController::class, 'incomeStatement']);
        Route::get('reports/income-statement/pdf', [AccountingController::class, 'incomeStatementPdf']);
        Route::get('reports/balance-sheet', [AccountingController::class, 'balanceSheet']);
        Route::get('audit-trail', [AccountingController::class, 'auditTrail']);
    });

    // WAREHOUSE
    Route::prefix('warehouse')->middleware(['auth:sanctum', 'role:warehouse,admin'])->group(function () {
        Route::get('categories', [WarehouseController::class, 'indexCategories']);
        Route::post('categories', [WarehouseController::class, 'storeCategory']);

        Route::get('items', [WarehouseController::class, 'indexItems']);
        Route::post('items', [WarehouseController::class, 'storeItem']);
        Route::get('items/{id}', [WarehouseController::class, 'showItem']);
        Route::patch('items/{id}', [WarehouseController::class, 'updateItem']);

        Route::get('movements', [WarehouseController::class, 'indexMovements']);
        Route::post('movements', [WarehouseController::class, 'storeMovement']);

        Route::get('purchase-requests', [WarehouseController::class, 'indexPurchaseRequests']);
        Route::post('purchase-requests', [WarehouseController::class, 'storePurchaseRequest']);
        Route::patch(
            'purchase-requests/{id}/review',
            [WarehouseController::class, 'reviewPurchaseRequest']
        )->middleware('role:admin');

        Route::get('inventory-counts', [WarehouseController::class, 'indexCounts']);
        Route::post('inventory-counts', [WarehouseController::class, 'storeCounts']);

        Route::get('dashboard', [WarehouseController::class, 'dashboard']);

        Route::get('reports/consumption', [WarehouseController::class, 'consumptionReport']);
        Route::get('reports/consumption/pdf', [WarehouseController::class, 'consumptionReportPdf']);
        Route::get('reports/inventory', [WarehouseController::class, 'inventoryReport']);
        Route::get('reports/inventory/pdf', [WarehouseController::class, 'inventoryReportPdf']);
    });

    // HR
    Route::middleware('role:hr,admin')->prefix('hr')->group(function () {
        Route::get('/dashboard', [HrPayrollController::class, 'dashboard'])->middleware('perm:hr.employees.view');
        // Legacy staff endpoints keep their role guard for deployed clients; all new sensitive
        // sub-resources below use granular permissions and controller-level field redaction.
        Route::get('/staff', [HrController::class, 'staff']);
        Route::get('/staff/{id}', [HrController::class, 'showStaff']);
        Route::patch('/staff/{id}', [HrController::class, 'updateStaff']);
        Route::get('/staff/{id}/contracts', [HrPayrollController::class, 'contractHistory'])->middleware('perm:hr.contracts.view');
        Route::post('/staff/{id}/contracts', [HrPayrollController::class, 'storeContract'])->middleware('perm:hr.contracts.manage');
        Route::get('/contracts', [HrPayrollController::class, 'contracts'])->middleware('perm:hr.contracts.view');
        Route::post('/contracts/{id}/renew', [HrPayrollController::class, 'renewContract'])->middleware('perm:hr.contracts.manage');
        Route::get('/warnings', [HrPayrollController::class, 'warnings'])->middleware('perm:hr.warnings.view');
        Route::post('/warnings', [HrPayrollController::class, 'storeWarning'])->middleware('perm:hr.warnings.create');
        Route::get('/warnings/{id}', [HrPayrollController::class, 'showWarning'])->middleware('perm:hr.warnings.view');
        Route::post('/warnings/{id}/{action}', [HrPayrollController::class, 'transitionWarning'])
            ->whereIn('action', ['submit', 'approve', 'receive', 'object', 'cancel'])->middleware('perm:hr.warnings.approve');
        Route::get('/payroll-reports/{type}', [HrPayrollController::class, 'report'])->middleware('perm:payroll.reports.view');
        Route::get('/requests', [HrController::class, 'requests']);
        Route::patch('/requests/{id}/review', [HrController::class, 'reviewRequest']);
        Route::get('/leave-requests', [HrController::class, 'leaveRequests']);
        Route::patch('/leave-requests/{id}/review', [HrController::class, 'reviewRequest']);
        Route::get('/leave-balances', [HrController::class, 'leaveBalances']);
        Route::match(['get', 'post'], '/staff-attendance', [HrController::class, 'staffAttendance']);
        Route::get('/staff-attendance/report', [HrController::class, 'staffMonthlyReport']);

        // Performance Evaluations
        Route::get('/evaluations', [HrController::class, 'evaluations']);
        Route::post('/evaluations', [HrController::class, 'createEvaluation']);
        Route::get('/evaluations/{id}', [HrController::class, 'showEvaluation']);

        // Recruitment
        Route::match(['get', 'post'], '/jobs', [HrController::class, 'jobs']);
        Route::get('/applications', [HrController::class, 'applications']);
        Route::patch('/applications/{id}/status', [HrController::class, 'updateApplicationStatus']);
    });
});

// Payment Webhook (public, secured by Stripe signature). Throttled as
// defense-in-depth: the signature check is the real control, but a per-IP
// limit bounds resource use under a flood. Stripe treats 429 as a failed
// delivery and retries with backoff, so legitimate events are not lost.
Route::post('/webhooks/payment', [PaymentController::class, 'handleWebhook'])
    ->middleware('throttle:120,1');
