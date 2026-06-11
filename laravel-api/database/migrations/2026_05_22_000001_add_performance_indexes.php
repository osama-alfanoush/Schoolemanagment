<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        $this->safeIndex('users', ['email', 'is_active']);

        $this->safeIndex('student_profiles', ['class_room_id']);

        $this->safeIndex('attendance_records', ['date', 'status']);
        $this->safeIndex('attendance_records', ['student_user_id', 'date']);

        $this->safeIndex('grades', ['student_user_id', 'grade_component_id']);

        $this->safeIndex('assignments', ['class_room_id']);
        $this->safeIndex('assignments', ['due_at']);

        $this->safeIndex('submissions', ['assignment_id', 'student_user_id']);

        $this->safeIndex('invoices', ['student_user_id', 'status']);
        $this->safeIndex('invoices', ['due_date']);

        $this->safeIndex('payments', ['invoice_id', 'paid_at']);

        $this->safeIndex('stock_movements', ['item_id', 'movement_date']);
        $this->safeIndex('stock_movements', ['movement_type']);

        $this->safeIndex('messages', ['sender_user_id', 'recipient_user_id']);

        $this->safeIndex('audit_logs', ['entity_type', 'entity_id']);

        $this->safeIndex('journal_entries', ['account_code']);

        $this->safeIndex('class_subject_teacher', ['teacher_user_id']);
    }

    public function down(): void
    {
        $this->safeDropIndex('users', ['email', 'is_active']);
        $this->safeDropIndex('student_profiles', ['class_room_id']);
        $this->safeDropIndex('attendance_records', ['date', 'status']);
        $this->safeDropIndex('attendance_records', ['student_user_id', 'date']);
        $this->safeDropIndex('grades', ['student_user_id', 'grade_component_id']);
        $this->safeDropIndex('assignments', ['class_room_id']);
        $this->safeDropIndex('assignments', ['due_at']);
        $this->safeDropIndex('submissions', ['assignment_id', 'student_user_id']);
        $this->safeDropIndex('invoices', ['student_user_id', 'status']);
        $this->safeDropIndex('invoices', ['due_date']);
        $this->safeDropIndex('payments', ['invoice_id', 'paid_at']);
        $this->safeDropIndex('stock_movements', ['item_id', 'movement_date']);
        $this->safeDropIndex('stock_movements', ['movement_type']);
        $this->safeDropIndex('messages', ['sender_user_id', 'recipient_user_id']);
        $this->safeDropIndex('audit_logs', ['entity_type', 'entity_id']);
        $this->safeDropIndex('journal_entries', ['account_code']);
        $this->safeDropIndex('class_subject_teacher', ['teacher_user_id']);
    }

    private function indexName(string $table, array $columns): string
    {
        return $table . '_' . implode('_', $columns) . '_index';
    }

    private function safeIndex(string $table, array $columns): void
    {
        $name = $this->indexName($table, $columns);
        try {
            Schema::table($table, function (Blueprint $t) use ($columns, $name) {
                $t->index($columns, $name);
            });
        } catch (\Exception $e) {
            // Index may already exist — safe to ignore
        }
    }

    private function safeDropIndex(string $table, array $columns): void
    {
        $name = $this->indexName($table, $columns);
        try {
            Schema::table($table, function (Blueprint $t) use ($name) {
                $t->dropIndex($name);
            });
        } catch (\Exception $e) {
            // Index may not exist — safe to ignore
        }
    }
};
