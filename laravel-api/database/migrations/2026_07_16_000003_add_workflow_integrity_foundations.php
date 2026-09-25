<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('gradebooks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->foreignId('course_section_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('class_room_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('subject_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('grading_period_id')->constrained()->restrictOnDelete();
            $table->string('state')->default('draft');
            $table->unsignedInteger('version')->default(1);
            $table->foreignId('submitted_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('submitted_at')->nullable();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->foreignId('finalized_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('finalized_at')->nullable();
            $table->foreignId('reopened_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('reopened_until')->nullable();
            $table->text('reopen_reason')->nullable();
            $table->timestamps();
            $table->unique(['course_section_id', 'grading_period_id'], 'section_period_gradebook_unique');
            $table->index(['class_room_id', 'subject_id', 'grading_period_id'], 'legacy_gradebook_lookup');
        });

        Schema::table('grade_components', function (Blueprint $table) {
            $table->foreignId('gradebook_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('grading_period_id')->nullable()->constrained()->restrictOnDelete();
        });
        Schema::table('grades', function (Blueprint $table) {
            $table->unsignedInteger('version')->default(1);
        });

        Schema::create('grade_change_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('grade_id')->constrained()->restrictOnDelete();
            $table->decimal('old_score', 6, 2)->nullable();
            $table->decimal('new_score', 6, 2);
            $table->unsignedInteger('old_version')->default(0);
            $table->unsignedInteger('new_version');
            $table->foreignId('actor_id')->constrained('users')->restrictOnDelete();
            $table->text('reason');
            $table->timestamps();
            $table->index(['grade_id', 'created_at']);
        });

        Schema::create('report_card_issues', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_enrollment_id')->constrained()->restrictOnDelete();
            $table->foreignId('grading_period_id')->constrained()->restrictOnDelete();
            $table->unsignedInteger('issue_version');
            $table->json('snapshot');
            $table->string('document_path')->nullable();
            $table->string('checksum', 64)->nullable();
            $table->text('correction_reason')->nullable();
            $table->foreignId('issued_by')->constrained('users')->restrictOnDelete();
            $table->timestamp('issued_at');
            $table->timestamps();
            $table->unique(['student_enrollment_id', 'grading_period_id', 'issue_version'], 'report_card_issue_unique');
        });

        Schema::create('attendance_submission_batches', function (Blueprint $table) {
            $table->id();
            $table->uuid('idempotency_key')->unique();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->foreignId('class_room_id')->constrained()->restrictOnDelete();
            $table->foreignId('course_section_id')->nullable()->constrained()->restrictOnDelete();
            $table->date('attendance_date');
            $table->foreignId('submitted_by')->constrained('users')->restrictOnDelete();
            $table->string('payload_hash', 64);
            $table->unsignedInteger('record_count');
            $table->timestamp('committed_at')->nullable();
            $table->timestamps();
        });
        Schema::table('attendance_records', function (Blueprint $table) {
            $table->foreignId('student_enrollment_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('course_section_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('submission_batch_id')->nullable()->constrained('attendance_submission_batches')->restrictOnDelete();
            $table->string('scope_key')->default('daily');
            $table->unsignedInteger('version')->default(1);
            $table->index(['class_room_id', 'date', 'scope_key'], 'attendance_roster_lookup');
            $table->unique(['student_user_id', 'date', 'scope_key'], 'attendance_scope_unique');
        });

        Schema::create('billing_periods', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->string('name');
            $table->date('start_date');
            $table->date('end_date');
            $table->date('due_date');
            $table->string('status')->default('open');
            $table->timestamps();
            $table->unique(['school_id', 'name', 'start_date']);
        });
        Schema::create('invoice_generation_batches', function (Blueprint $table) {
            $table->id();
            $table->uuid('idempotency_key')->unique();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->foreignId('billing_period_id')->constrained()->restrictOnDelete();
            $table->foreignId('created_by')->constrained('users')->restrictOnDelete();
            $table->string('status')->default('processing');
            $table->unsignedInteger('generated_count')->default(0);
            $table->timestamps();
        });
        Schema::table('invoices', function (Blueprint $table) {
            $table->foreignId('student_enrollment_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('billing_period_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('generation_batch_id')->nullable()->constrained('invoice_generation_batches')->restrictOnDelete();
            $table->unsignedInteger('generation_version')->default(1);
            $table->decimal('credits', 12, 2)->default(0);
            $table->unique(['student_enrollment_id', 'fee_structure_id', 'billing_period_id', 'generation_version'], 'invoice_business_key');
        });

        Schema::create('outbox_events', function (Blueprint $table) {
            $table->id();
            $table->uuid('event_id')->unique();
            $table->string('type');
            $table->string('aggregate_type');
            $table->unsignedBigInteger('aggregate_id');
            $table->json('payload');
            $table->string('deduplication_key')->unique();
            $table->unsignedSmallInteger('attempts')->default(0);
            $table->timestamp('available_at');
            $table->timestamp('processed_at')->nullable();
            $table->text('last_error')->nullable();
            $table->timestamps();
            $table->index(['processed_at', 'available_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('outbox_events');
        Schema::table('invoices', function (Blueprint $table) {
            $table->dropUnique('invoice_business_key');
            foreach (['generation_batch_id', 'billing_period_id', 'student_enrollment_id'] as $column) {
                $table->dropConstrainedForeignId($column);
            }
            $table->dropColumn(['generation_version', 'credits']);
        });
        Schema::dropIfExists('invoice_generation_batches');
        Schema::dropIfExists('billing_periods');
        Schema::table('attendance_records', function (Blueprint $table) {
            $table->dropUnique('attendance_scope_unique');
            $table->dropIndex('attendance_roster_lookup');
            foreach (['submission_batch_id', 'course_section_id', 'student_enrollment_id'] as $column) {
                $table->dropConstrainedForeignId($column);
            }
            $table->dropColumn(['scope_key', 'version']);
        });
        Schema::dropIfExists('attendance_submission_batches');
        Schema::dropIfExists('report_card_issues');
        Schema::dropIfExists('grade_change_history');
        Schema::table('grades', fn (Blueprint $table) => $table->dropColumn('version'));
        Schema::table('grade_components', function (Blueprint $table) {
            $table->dropConstrainedForeignId('grading_period_id');
            $table->dropConstrainedForeignId('gradebook_id');
        });
        Schema::dropIfExists('gradebooks');
    }
};
