<?php

use App\Models\AcademicYear;
use App\Models\Announcement;
use App\Models\AppNotification;
use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\AttendanceSubmissionBatch;
use App\Models\AuditLog;
use App\Models\BudgetPlan;
use App\Models\CalendarEvent;
use App\Models\ChartOfAccount;
use App\Models\ClassRoom;
use App\Models\ConductLog;
use App\Models\ContractAlertDelivery;
use App\Models\DisciplinaryWarning;
use App\Models\EmployeeAdvance;
use App\Models\EmployeeAdvanceInstallment;
use App\Models\EmployeeContract;
use App\Models\Exam;
use App\Models\FeeStructure;
use App\Models\FinancialClosing;
use App\Models\GoodsReceipt;
use App\Models\GoodsReceiptItem;
use App\Models\Grade;
use App\Models\Gradebook;
use App\Models\GradeComponent;
use App\Models\HrPayrollSetting;
use App\Models\HrRequest;
use App\Models\Installment;
use App\Models\InventoryCount;
use App\Models\Invoice;
use App\Models\JobApplication;
use App\Models\JobPosting;
use App\Models\JournalBatch;
use App\Models\JournalEntry;
use App\Models\LibraryBook;
use App\Models\LibraryBorrowing;
use App\Models\MedicalRecord;
use App\Models\MedicalVisit;
use App\Models\Message;
use App\Models\Notification;
use App\Models\NotificationDelivery;
use App\Models\NotificationTemplate;
use App\Models\OutboxEvent;
use App\Models\Payment;
use App\Models\PaymentPlan;
use App\Models\PaymentReceipt;
use App\Models\PaymentReceiptAllocation;
use App\Models\PaymentTransaction;
use App\Models\PayrollAccountSetting;
use App\Models\PayrollComponent;
use App\Models\PayrollRecord;
use App\Models\PayrollRecordComponent;
use App\Models\PayrollRun;
use App\Models\PerformanceEvaluation;
use App\Models\PurchaseOrder;
use App\Models\PurchaseOrderItem;
use App\Models\PurchaseRequest;
use App\Models\ReportCardIssue;
use App\Models\RolePermission;
use App\Models\SchoolSetting;
use App\Models\SchoolUserRole;
use App\Models\Semester;
use App\Models\SocialInsuranceScheme;
use App\Models\StaffAttendance;
use App\Models\StaffPayrollComponent;
use App\Models\StaffProfile;
use App\Models\StockMovement;
use App\Models\StudentEnrollment;
use App\Models\StudentFinancialAdjustment;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\Submission;
use App\Models\Supplier;
use App\Models\SupplierAccount;
use App\Models\SupplierInvoice;
use App\Models\SupplierPayment;
use App\Models\SupplierTransaction;
use App\Models\TimetableEntry;
use App\Models\TransportAssignment;
use App\Models\TransportRoute;
use App\Models\TransportStop;
use App\Models\TransportVehicle;
use App\Models\UserPermission;
use App\Models\WarehouseCategory;
use App\Models\WarehouseItem;

return [
    /* Every model in this list must have a non-null school_id column. */
    'models' => [
        AcademicYear::class,
        Announcement::class,
        AppNotification::class,
        Assignment::class,
        AttendanceRecord::class,
        AttendanceSubmissionBatch::class,
        AuditLog::class,
        BudgetPlan::class,
        CalendarEvent::class,
        ChartOfAccount::class,
        ClassRoom::class,
        ConductLog::class,
        ContractAlertDelivery::class,
        DisciplinaryWarning::class,
        EmployeeAdvance::class,
        EmployeeAdvanceInstallment::class,
        EmployeeContract::class,
        Exam::class,
        FeeStructure::class,
        FinancialClosing::class,
        GoodsReceipt::class,
        GoodsReceiptItem::class,
        Grade::class,
        GradeComponent::class,
        Gradebook::class,
        HrPayrollSetting::class,
        HrRequest::class,
        Installment::class,
        InventoryCount::class,
        Invoice::class,
        JobApplication::class,
        JobPosting::class,
        JournalBatch::class,
        JournalEntry::class,
        LibraryBook::class,
        LibraryBorrowing::class,
        MedicalRecord::class,
        MedicalVisit::class,
        Message::class,
        Notification::class,
        NotificationDelivery::class,
        NotificationTemplate::class,
        OutboxEvent::class,
        Payment::class,
        PaymentPlan::class,
        PaymentReceipt::class,
        PaymentReceiptAllocation::class,
        PaymentTransaction::class,
        PayrollAccountSetting::class,
        PayrollComponent::class,
        PayrollRecord::class,
        PayrollRecordComponent::class,
        PayrollRun::class,
        PerformanceEvaluation::class,
        PurchaseOrder::class,
        PurchaseOrderItem::class,
        PurchaseRequest::class,
        ReportCardIssue::class,
        RolePermission::class,
        SchoolSetting::class,
        SchoolUserRole::class,
        Semester::class,
        SocialInsuranceScheme::class,
        StaffAttendance::class,
        StaffPayrollComponent::class,
        StaffProfile::class,
        StockMovement::class,
        StudentEnrollment::class,
        StudentFinancialAdjustment::class,
        StudentProfile::class,
        Subject::class,
        Submission::class,
        Supplier::class,
        SupplierAccount::class,
        SupplierInvoice::class,
        SupplierPayment::class,
        SupplierTransaction::class,
        TimetableEntry::class,
        TransportAssignment::class,
        TransportRoute::class,
        TransportStop::class,
        TransportVehicle::class,
        UserPermission::class,
        WarehouseCategory::class,
        WarehouseItem::class,
    ],
];
