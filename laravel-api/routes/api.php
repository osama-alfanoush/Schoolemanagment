<?php

use App\Http\Controllers\Api\AccountingController;
use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\FinanceController;
use App\Http\Controllers\Api\HrController;
use App\Http\Controllers\Api\LibraryController;
use App\Http\Controllers\Api\MedicalController;
use App\Http\Controllers\Api\MessagingController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\ParentController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\StudentController;
use App\Http\Controllers\Api\TeacherController;
use App\Http\Controllers\Api\TransportController;
use App\Http\Controllers\Api\WarehouseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/healthz', fn() => response()->json(['status' => 'ok', 'service' => 'school-management-api']));
Route::get('/health', \App\Http\Controllers\Api\HealthController::class);

// Public auth endpoints with rate limiting
Route::post('/auth/login', [AuthController::class, 'login'])
    ->middleware(['throttle:10,1', \App\Http\Middleware\AccountLockout::class]);
Route::post('/auth/forgot-password', [AuthController::class, 'forgotPassword'])
    ->middleware('throttle:3,5');
Route::post('/auth/reset-password', [AuthController::class, 'resetPassword'])
    ->middleware('throttle:5,30');
// Stub named route the framework references when generating reset-link emails.
// In a real client app the user is sent here with the token + email, then POSTs to /api/auth/reset-password.
Route::get('/auth/password/reset/{token}', fn(string $token) => response()->json([
    'message' => 'Use POST /api/auth/reset-password with this token, your email, and the new password.',
    'token' => $token,
]))->name('password.reset');
// Refresh has its own throttle — high limit since it's used frequently for token rotation
Route::post('/auth/refresh', [AuthController::class, 'refresh'])
    ->middleware(['auth:sanctum', 'throttle:30,1']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/auth/me', [AuthController::class, 'me']);
    Route::post('/auth/logout', [AuthController::class, 'logout']);
    Route::patch('/auth/profile', [AuthController::class, 'updateProfile']);
    Route::post('/auth/profile/photo', [AuthController::class, 'uploadProfilePhoto']);
    Route::post('/auth/change-password', [AuthController::class, 'changePassword']);
    Route::post('/auth/push-token', [AuthController::class, 'registerPushToken']);
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

        // Transport
        Route::get('/transport/my-route', [TransportController::class, 'myRoute']);

        // Medical
        Route::get('/medical/my-records', [MedicalController::class, 'myRecords']);
    });

    // PARENT
    Route::middleware(['role:parent', \App\Http\Middleware\EnsureParentOwnsChild::class])->prefix('parent')->group(function () {
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

        // Medical
        Route::get('/children/{id}/medical', [MedicalController::class, 'childMedicalRecords']);
        Route::get('/children/{id}/medical-visits', [MedicalController::class, 'childMedicalVisits']);

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
        Route::post('/conduct', [TeacherController::class, 'logConduct']);
        Route::get('/announcements', [TeacherController::class, 'getAnnouncements']);
        Route::post('/announcements', [TeacherController::class, 'announce']);
        Route::post('/hr-requests', [HrController::class, 'submitRequest']);
        Route::get('/hr-requests', [HrController::class, 'myRequests']);
    });

    // ADMIN
    Route::middleware('role:admin')->prefix('admin')->group(function () {
        Route::get('/users', [AdminController::class, 'listUsers']);
        Route::post('/users', [AdminController::class, 'createUser']);
        Route::patch('/users/{id}', [AdminController::class, 'updateUser']);
        Route::delete('/users/{id}', [AdminController::class, 'deactivateUser']);
        Route::post('/users/link-parent', [AdminController::class, 'linkParentStudent']);
        Route::post('/users/import-students', [AdminController::class, 'bulkImportStudents']);
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

        // Medical Management
        Route::get('/medical/records', [MedicalController::class, 'allRecords']);
        Route::get('/medical/visits', [MedicalController::class, 'allVisits']);
        Route::post('/medical/notify-parent/{visitId}', [MedicalController::class, 'notifyParent']);
    });

    // FINANCE
    Route::middleware('role:finance,admin')->prefix('finance')->group(function () {
        Route::match(['get', 'post'], '/fee-structures', [FinanceController::class, 'feeStructures']);
        Route::get('/invoices', [FinanceController::class, 'invoices']);
        Route::post('/invoices/generate', [FinanceController::class, 'generateInvoices']);
        Route::post('/invoices/{id}/payments', [FinanceController::class, 'recordPayment']);
        Route::get('/invoices/{id}/receipt-pdf', [FinanceController::class, 'invoiceReceipt']);
        Route::post('/invoices/send-reminders', [FinanceController::class, 'sendReminders']);
        Route::get('/outstanding', [FinanceController::class, 'outstandingByStudent']);
        Route::get('/payroll', [FinanceController::class, 'payroll']);
        Route::post('/payroll/process', [FinanceController::class, 'processPayroll']);
        Route::get('/reports', [FinanceController::class, 'financialReports']);
    });

    // ACCOUNTING
    Route::prefix('accounting')->middleware(['auth:sanctum', 'role:accounting,admin'])->group(function () {
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
        Route::get('/staff', [HrController::class, 'staff']);
        Route::get('/staff/{id}', [HrController::class, 'showStaff']);
        Route::patch('/staff/{id}', [HrController::class, 'updateStaff']);
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

// Payment Webhook (public, secured by signature)
Route::post('/webhooks/payment', [PaymentController::class, 'handleWebhook']);
