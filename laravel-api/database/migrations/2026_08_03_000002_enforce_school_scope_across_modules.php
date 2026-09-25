<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public $withinTransaction = true;

    /** Tables that already had school_id before this migration. */
    private const EXISTING_SCHOOL_TABLES = [
        'academic_years',
        'announcements',
        'attendance_submission_batches',
        'billing_periods',
        'class_rooms',
        'courses',
        'disciplinary_warnings',
        'employee_advance_installments',
        'employee_advances',
        'employee_contracts',
        'financial_closings',
        'gradebooks',
        'hr_payroll_settings',
        'hr_requests',
        'invoice_generation_batches',
        'invoices',
        'journal_batches',
        'journal_entries',
        'payroll_account_settings',
        'payroll_components',
        'payroll_record_components',
        'payroll_records',
        'payroll_runs',
        'social_insurance_schemes',
        'staff_attendance',
        'staff_payroll_components',
        'staff_profiles',
        'student_enrollments',
        'subjects',
        'timetable_entries',
    ];

    /** School-owned tables that previously relied only on indirect relations. */
    private const NEW_SCHOOL_TABLES = [
        'assignments',
        'attendance_records',
        'audit_logs',
        'budget_plans',
        'calendar_events',
        'chart_of_accounts',
        'class_subject_teacher',
        'conduct_logs',
        'contract_alert_deliveries',
        'course_sections',
        'exams',
        'fee_structures',
        'goods_receipt_items',
        'goods_receipts',
        'grade_change_history',
        'grade_components',
        'grades',
        'grading_periods',
        'installments',
        'inventory_counts',
        'job_applications',
        'job_postings',
        'library_books',
        'library_borrowings',
        'medical_records',
        'medical_visits',
        'messages',
        'mfa_recovery_requests',
        'notification_deliveries',
        'notification_templates',
        'notifications',
        'outbox_events',
        'parent_student',
        'payment_allocations',
        'payment_plans',
        'payment_receipt_allocations',
        'payment_receipts',
        'payment_reconciliation_runs',
        'payment_reversals',
        'payment_transactions',
        'payments',
        'performance_evaluations',
        'purchase_order_items',
        'purchase_orders',
        'purchase_requests',
        'report_card_issues',
        'role_permissions',
        'school_settings',
        'section_enrollments',
        'section_teachers',
        'semesters',
        'stock_movements',
        'student_financial_adjustments',
        'student_profiles',
        'submissions',
        'supplier_accounts',
        'supplier_invoices',
        'supplier_payments',
        'supplier_transactions',
        'suppliers',
        'terms',
        'transport_assignments',
        'transport_routes',
        'transport_stops',
        'transport_vehicles',
        'user_permissions',
        'warehouse_categories',
        'warehouse_items',
    ];

    /** Legacy global business identifiers that must be reusable per school. */
    private const TENANT_UNIQUES = [
        'subjects' => ['code'],
        'student_profiles' => ['admission_no'],
        'parent_student' => ['parent_user_id', 'student_user_id'],
        'invoices' => ['invoice_no'],
        'journal_entries' => ['reference_no'],
        'chart_of_accounts' => ['account_code'],
        'budget_plans' => ['fiscal_year', 'category', 'sub_category'],
        'warehouse_categories' => ['name'],
        'warehouse_items' => ['sku'],
        'purchase_requests' => ['request_no'],
        'inventory_counts' => ['count_ref'],
        'suppliers' => ['code'],
        'purchase_orders' => ['po_no'],
        'goods_receipts' => ['grn_no'],
        'supplier_invoices' => ['invoice_no'],
        'payment_plans' => ['plan_no'],
        'library_books' => ['isbn'],
        'transport_vehicles' => ['registration_number'],
        'payment_receipts' => ['receipt_no'],
        'student_financial_adjustments' => ['adjustment_no'],
        'journal_batches' => ['reference_no'],
        'staff_profiles' => ['employee_no'],
        'employee_contracts' => ['contract_no'],
        'disciplinary_warnings' => ['warning_no'],
        'employee_advances' => ['advance_no'],
        'payroll_runs' => ['run_no'],
    ];

    public function up(): void
    {
        foreach (self::NEW_SCHOOL_TABLES as $tableName) {
            if (! Schema::hasTable($tableName) || Schema::hasColumn($tableName, 'school_id')) {
                continue;
            }

            Schema::table($tableName, function (Blueprint $table): void {
                $table->foreignId('school_id')->nullable()->constrained('schools')->restrictOnDelete();
            });
        }

        $schoolIds = DB::table('schools')->orderBy('id')->pluck('id');
        if ($schoolIds->isEmpty()) {
            throw new RuntimeException('School-scope migration aborted: no school exists.');
        }

        $tables = array_values(array_filter(
            array_merge(self::EXISTING_SCHOOL_TABLES, self::NEW_SCHOOL_TABLES),
            fn (string $table): bool => Schema::hasTable($table) && Schema::hasColumn($table, 'school_id'),
        ));

        if ($schoolIds->count() === 1) {
            $schoolId = (int) $schoolIds->first();
            foreach ($tables as $tableName) {
                DB::table($tableName)->whereNull('school_id')->update(['school_id' => $schoolId]);
            }
        } else {
            $unresolved = [];
            foreach ($tables as $tableName) {
                $ids = DB::table($tableName)->whereNull('school_id')->limit(25)->pluck('id');
                if ($ids->isNotEmpty()) {
                    $unresolved[] = $tableName.':null_school_ids=['.$ids->implode(',').']';
                }
            }

            if ($unresolved !== []) {
                throw new RuntimeException(
                    "School-scope migration aborted. Resolve ownership without guessing:\n".implode("\n", $unresolved),
                );
            }
        }

        foreach ($tables as $tableName) {
            Schema::table($tableName, function (Blueprint $table): void {
                $table->unsignedBigInteger('school_id')->nullable(false)->change();
            });
        }

        foreach (self::NEW_SCHOOL_TABLES as $tableName) {
            if (! Schema::hasTable($tableName) || ! Schema::hasColumn($tableName, 'school_id')) {
                continue;
            }
            if ($tableName === 'school_settings') {
                continue;
            }

            Schema::table($tableName, function (Blueprint $table) use ($tableName): void {
                $table->index('school_id', $tableName.'_tenant_school_idx');
            });
        }

        $duplicateDelivery = DB::table('notification_deliveries')
            ->select('notification_id', 'channel')
            ->groupBy('notification_id', 'channel')
            ->havingRaw('COUNT(*) > 1')
            ->first();
        if ($duplicateDelivery) {
            throw new RuntimeException(
                "School-scope migration aborted: duplicate notification delivery for notification {$duplicateDelivery->notification_id} channel {$duplicateDelivery->channel}.",
            );
        }

        $this->replaceUnique('role_permissions', ['role', 'permission_id'], ['school_id', 'role', 'permission_id']);
        $this->replaceUnique('user_permissions', ['user_id', 'permission_id'], ['school_id', 'user_id', 'permission_id']);
        $this->replaceUnique('notification_templates', ['key'], ['school_id', 'key']);
        foreach (self::TENANT_UNIQUES as $tableName => $columns) {
            $this->replaceUnique($tableName, $columns, ['school_id', ...$columns]);
        }
        Schema::table('school_settings', fn (Blueprint $table) => $table->unique('school_id'));
        $this->replaceIndexWithUnique('notification_deliveries', ['notification_id', 'channel']);

        // SQLite rebuilds tables for change() and can silently turn partial
        // indexes into full unique indexes. Recreate every pre-existing
        // partial invariant explicitly; the same SQL is valid on PostgreSQL.
        DB::statement('DROP INDEX IF EXISTS enrollment_one_open_active');
        DB::statement("CREATE UNIQUE INDEX enrollment_one_open_active ON student_enrollments (student_user_id, school_id) WHERE status = 'active' AND end_date IS NULL");
        DB::statement('DROP INDEX IF EXISTS payroll_record_active_school_period_unique');
        DB::statement("CREATE UNIQUE INDEX payroll_record_active_school_period_unique ON payroll_records (school_id, staff_user_id, year, month) WHERE status <> 'reversed'");
        DB::statement('DROP INDEX IF EXISTS payroll_run_active_school_period_unique');
        DB::statement("CREATE UNIQUE INDEX payroll_run_active_school_period_unique ON payroll_runs (school_id, year, month) WHERE status <> 'reversed'");
    }

    public function down(): void
    {
        $this->replaceUniqueWithIndex('notification_deliveries', ['notification_id', 'channel']);
        Schema::table('school_settings', fn (Blueprint $table) => $table->dropUnique(['school_id']));
        foreach (array_reverse(self::TENANT_UNIQUES, true) as $tableName => $columns) {
            $this->replaceUnique($tableName, ['school_id', ...$columns], $columns);
        }
        $this->replaceUnique('notification_templates', ['school_id', 'key'], ['key']);
        $this->replaceUnique('user_permissions', ['school_id', 'user_id', 'permission_id'], ['user_id', 'permission_id']);
        $this->replaceUnique('role_permissions', ['school_id', 'role', 'permission_id'], ['role', 'permission_id']);

        foreach (array_reverse(self::NEW_SCHOOL_TABLES) as $tableName) {
            if (! Schema::hasTable($tableName) || ! Schema::hasColumn($tableName, 'school_id')) {
                continue;
            }

            Schema::table($tableName, function (Blueprint $table) use ($tableName): void {
                if ($tableName !== 'school_settings') {
                    $table->dropIndex($tableName.'_tenant_school_idx');
                }
                $table->dropConstrainedForeignId('school_id');
            });
        }
    }

    private function replaceUnique(string $tableName, array $oldColumns, array $newColumns): void
    {
        if (! Schema::hasTable($tableName)) {
            return;
        }

        Schema::table($tableName, function (Blueprint $table) use ($oldColumns, $newColumns): void {
            $table->dropUnique($oldColumns);
            $table->unique($newColumns);
        });
    }

    private function replaceIndexWithUnique(string $tableName, array $columns): void
    {
        if (! Schema::hasTable($tableName)) {
            return;
        }

        Schema::table($tableName, function (Blueprint $table) use ($columns): void {
            $table->dropIndex($columns);
            $table->unique($columns);
        });
    }

    private function replaceUniqueWithIndex(string $tableName, array $columns): void
    {
        if (! Schema::hasTable($tableName)) {
            return;
        }

        Schema::table($tableName, function (Blueprint $table) use ($columns): void {
            $table->dropUnique($columns);
            $table->index($columns);
        });
    }
};
