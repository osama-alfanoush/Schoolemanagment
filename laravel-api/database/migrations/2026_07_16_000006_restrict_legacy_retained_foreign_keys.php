<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Retained education, health, communication, HR, and financial records must
     * never disappear because a parent/configuration row was physically deleted.
     */
    public function up(): void
    {
        $constraints = [
            ['semesters', 'academic_year_id', 'academic_years'],
            ['student_profiles', 'user_id', 'users'],
            ['parent_student', 'parent_user_id', 'users'], ['parent_student', 'student_user_id', 'users'],
            ['staff_profiles', 'user_id', 'users'],
            ['class_subject_teacher', 'class_room_id', 'class_rooms'], ['class_subject_teacher', 'subject_id', 'subjects'], ['class_subject_teacher', 'teacher_user_id', 'users'],
            ['timetable_entries', 'class_room_id', 'class_rooms'], ['timetable_entries', 'subject_id', 'subjects'], ['timetable_entries', 'teacher_user_id', 'users'],
            ['attendance_records', 'student_user_id', 'users'], ['attendance_records', 'class_room_id', 'class_rooms'],
            ['staff_attendance', 'staff_user_id', 'users'],
            ['assignments', 'teacher_user_id', 'users'], ['assignments', 'class_room_id', 'class_rooms'], ['assignments', 'subject_id', 'subjects'],
            ['submissions', 'assignment_id', 'assignments'], ['submissions', 'student_user_id', 'users'],
            ['grade_components', 'class_room_id', 'class_rooms'], ['grade_components', 'subject_id', 'subjects'],
            ['grades', 'student_user_id', 'users'], ['grades', 'grade_component_id', 'grade_components'],
            ['conduct_logs', 'student_user_id', 'users'],
            ['invoices', 'student_user_id', 'users'], ['payments', 'invoice_id', 'invoices'],
            ['payroll_records', 'staff_user_id', 'users'], ['hr_requests', 'teacher_user_id', 'users'],
            ['announcements', 'sender_user_id', 'users'], ['messages', 'sender_user_id', 'users'], ['messages', 'recipient_user_id', 'users'],
            ['notifications', 'user_id', 'users'], ['notification_deliveries', 'notification_id', 'notifications'],
            ['scheduled_notifications', 'sender_id', 'users'],
            ['exams', 'class_room_id', 'class_rooms'], ['exams', 'subject_id', 'subjects'],
            ['payment_transactions', 'invoice_id', 'invoices'],
            ['library_borrowings', 'book_id', 'library_books'], ['library_borrowings', 'student_user_id', 'users'],
            ['transport_assignments', 'student_user_id', 'users'], ['transport_assignments', 'route_id', 'transport_routes'],
            ['transport_stops', 'route_id', 'transport_routes'],
            ['medical_records', 'student_user_id', 'users'], ['medical_visits', 'student_user_id', 'users'],
            ['performance_evaluations', 'staff_user_id', 'users'], ['job_applications', 'job_posting_id', 'job_postings'],
            ['journal_entries', 'created_by', 'users'], ['budget_plans', 'created_by', 'users'],
            ['warehouse_items', 'category_id', 'warehouse_categories'], ['stock_movements', 'item_id', 'warehouse_items'],
            ['supplier_accounts', 'supplier_id', 'suppliers'], ['supplier_transactions', 'supplier_account_id', 'supplier_accounts'],
            ['purchase_order_items', 'purchase_order_id', 'purchase_orders'], ['goods_receipt_items', 'goods_receipt_id', 'goods_receipts'],
            ['supplier_payments', 'supplier_invoice_id', 'supplier_invoices'],
            ['payment_plans', 'student_user_id', 'users'], ['installments', 'payment_plan_id', 'payment_plans'],
        ];

        foreach ($constraints as [$table, $column, $parent]) {
            Schema::table($table, function (Blueprint $blueprint) use ($column, $parent) {
                $blueprint->dropForeign([$column]);
                $blueprint->foreign($column)->references('id')->on($parent)->restrictOnDelete();
            });
        }
    }

    public function down(): void
    {
        // Deliberately irreversible: rollback must not silently restore destructive
        // cascade behavior. Restore the previous database snapshot for a full rollback.
    }
};
