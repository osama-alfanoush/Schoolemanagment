<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('academic_years', function (Blueprint $t) {
            $t->id();
            $t->string('name'); // e.g. 2025-2026
            $t->date('start_date');
            $t->date('end_date');
            $t->boolean('is_current')->default(false);
            $t->timestamps();
        });

        Schema::create('semesters', function (Blueprint $t) {
            $t->id();
            $t->foreignId('academic_year_id')->constrained()->cascadeOnDelete();
            $t->string('name'); // S1, S2
            $t->date('start_date');
            $t->date('end_date');
            $t->timestamps();
        });

        Schema::create('class_rooms', function (Blueprint $t) {
            $t->id();
            $t->string('name');
            $t->string('grade');
            $t->string('section')->nullable();
            $t->integer('capacity')->default(30);
            $t->foreignId('academic_year_id')->nullable()->constrained()->nullOnDelete();
            $t->foreignId('homeroom_teacher_id')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamps();
        });

        Schema::create('subjects', function (Blueprint $t) {
            $t->id();
            $t->string('name');
            $t->string('code')->unique();
            $t->timestamps();
        });

        Schema::create('student_profiles', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->unique()->constrained()->cascadeOnDelete();
            $t->foreignId('class_room_id')->nullable()->constrained()->nullOnDelete();
            $t->string('admission_no')->unique();
            $t->date('date_of_birth')->nullable();
            $t->string('gender')->nullable();
            $t->text('address')->nullable();
            $t->text('medical_notes')->nullable();
            $t->string('emergency_contact_name')->nullable();
            $t->string('emergency_contact_phone')->nullable();
            $t->timestamps();
        });

        Schema::create('parent_student', function (Blueprint $t) {
            $t->id();
            $t->foreignId('parent_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->string('relation')->default('parent'); // mother/father/guardian
            $t->timestamps();
            $t->unique(['parent_user_id', 'student_user_id']);
        });

        Schema::create('staff_profiles', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->unique()->constrained()->cascadeOnDelete();
            $t->string('department')->nullable();
            $t->string('position')->nullable();
            $t->date('hire_date')->nullable();
            $t->string('contract_type')->nullable(); // full-time, part-time, contract
            $t->date('contract_end')->nullable();
            $t->decimal('base_salary', 12, 2)->default(0);
            $t->json('qualifications')->nullable();
            $t->integer('annual_leave_balance')->default(20);
            $t->integer('sick_leave_balance')->default(10);
            $t->timestamps();
        });

        Schema::create('class_subject_teacher', function (Blueprint $t) {
            $t->id();
            $t->foreignId('class_room_id')->constrained()->cascadeOnDelete();
            $t->foreignId('subject_id')->constrained()->cascadeOnDelete();
            $t->foreignId('teacher_user_id')->constrained('users')->cascadeOnDelete();
            $t->timestamps();
            $t->unique(['class_room_id', 'subject_id'], 'cst_class_subject_unique');
        });

        Schema::create('timetable_entries', function (Blueprint $t) {
            $t->id();
            $t->foreignId('class_room_id')->constrained()->cascadeOnDelete();
            $t->foreignId('subject_id')->constrained()->cascadeOnDelete();
            $t->foreignId('teacher_user_id')->constrained('users')->cascadeOnDelete();
            $t->tinyInteger('day_of_week'); // 1=Mon..7=Sun
            $t->time('start_time');
            $t->time('end_time');
            $t->string('room')->nullable();
            $t->timestamps();
        });

        Schema::create('attendance_records', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('class_room_id')->constrained()->cascadeOnDelete();
            $t->foreignId('subject_id')->nullable()->constrained()->nullOnDelete();
            $t->date('date');
            $t->string('status'); // present, absent, late, excused
            $t->foreignId('marked_by')->constrained('users');
            $t->text('note')->nullable();
            $t->timestamps();
            $t->unique(['student_user_id', 'date', 'subject_id'], 'attn_unique');
        });

        Schema::create('staff_attendance', function (Blueprint $t) {
            $t->id();
            $t->foreignId('staff_user_id')->constrained('users')->cascadeOnDelete();
            $t->date('date');
            $t->string('status');
            $t->time('check_in')->nullable();
            $t->time('check_out')->nullable();
            $t->timestamps();
            $t->unique(['staff_user_id', 'date']);
        });

        Schema::create('assignments', function (Blueprint $t) {
            $t->id();
            $t->foreignId('teacher_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('class_room_id')->constrained()->cascadeOnDelete();
            $t->foreignId('subject_id')->constrained()->cascadeOnDelete();
            $t->string('title');
            $t->text('instructions');
            $t->string('attachment_path')->nullable();
            $t->timestamp('due_at');
            $t->decimal('max_score', 6, 2)->default(100);
            $t->timestamps();
        });

        Schema::create('submissions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('assignment_id')->constrained()->cascadeOnDelete();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->text('content_text')->nullable();
            $t->string('file_path')->nullable();
            $t->timestamp('submitted_at')->nullable();
            $t->string('status')->default('pending'); // pending, submitted, late, graded
            $t->decimal('score', 6, 2)->nullable();
            $t->text('feedback')->nullable();
            $t->foreignId('graded_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamps();
            $t->unique(['assignment_id', 'student_user_id']);
        });

        Schema::create('grade_components', function (Blueprint $t) {
            $t->id();
            $t->foreignId('class_room_id')->constrained()->cascadeOnDelete();
            $t->foreignId('subject_id')->constrained()->cascadeOnDelete();
            $t->foreignId('semester_id')->nullable()->constrained()->nullOnDelete();
            $t->string('name'); // Quiz 1, Midterm, Final
            $t->string('type'); // quiz, homework, exam
            $t->decimal('weight', 5, 2)->default(0);
            $t->decimal('max_score', 6, 2)->default(100);
            $t->timestamps();
        });

        Schema::create('grades', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('grade_component_id')->constrained()->cascadeOnDelete();
            $t->decimal('score', 6, 2);
            $t->foreignId('entered_by')->constrained('users');
            $t->timestamps();
            $t->unique(['student_user_id', 'grade_component_id'], 'grade_unique');
        });

        Schema::create('conduct_logs', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('teacher_user_id')->constrained('users');
            $t->string('category'); // positive, warning, incident
            $t->string('title');
            $t->text('note');
            $t->timestamps();
        });

        Schema::create('fee_structures', function (Blueprint $t) {
            $t->id();
            $t->string('name'); // Tuition, Bus, Activities
            $t->string('grade')->nullable(); // null = all grades
            $t->string('billing_cycle'); // monthly, semester, yearly, one-time
            $t->decimal('amount', 12, 2);
            $t->boolean('is_active')->default(true);
            $t->timestamps();
        });

        Schema::create('invoices', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('fee_structure_id')->nullable()->constrained()->nullOnDelete();
            $t->string('invoice_no')->unique();
            $t->string('description');
            $t->decimal('amount', 12, 2);
            $t->decimal('paid_amount', 12, 2)->default(0);
            $t->date('due_date');
            $t->string('status')->default('pending'); // pending, partial, paid, overdue, cancelled
            $t->timestamps();
        });

        Schema::create('payments', function (Blueprint $t) {
            $t->id();
            $t->foreignId('invoice_id')->constrained()->cascadeOnDelete();
            $t->decimal('amount', 12, 2);
            $t->string('method'); // cash, bank_transfer, card, online
            $t->string('reference')->nullable();
            $t->foreignId('recorded_by')->constrained('users');
            $t->timestamp('paid_at');
            $t->text('note')->nullable();
            $t->timestamps();
        });

        Schema::create('payroll_records', function (Blueprint $t) {
            $t->id();
            $t->foreignId('staff_user_id')->constrained('users')->cascadeOnDelete();
            $t->integer('year');
            $t->tinyInteger('month');
            $t->decimal('base_salary', 12, 2);
            $t->decimal('allowances', 12, 2)->default(0);
            $t->decimal('deductions', 12, 2)->default(0);
            $t->decimal('advance_deduction', 12, 2)->default(0);
            $t->decimal('net_pay', 12, 2);
            $t->string('status')->default('draft'); // draft, processed, paid
            $t->timestamp('paid_at')->nullable();
            $t->timestamps();
            $t->unique(['staff_user_id', 'year', 'month']);
        });

        Schema::create('hr_requests', function (Blueprint $t) {
            $t->id();
            $t->foreignId('teacher_user_id')->constrained('users')->cascadeOnDelete();
            $t->string('type'); // leave_sick, leave_annual, leave_emergency, salary_advance, general
            $t->date('start_date')->nullable();
            $t->date('end_date')->nullable();
            $t->decimal('amount', 12, 2)->nullable();
            $t->string('subject');
            $t->text('reason');
            $t->string('status')->default('pending'); // pending, approved, rejected
            $t->text('admin_response')->nullable();
            $t->foreignId('reviewed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('reviewed_at')->nullable();
            $t->timestamps();
        });

        Schema::create('announcements', function (Blueprint $t) {
            $t->id();
            $t->foreignId('sender_user_id')->constrained('users')->cascadeOnDelete();
            $t->string('audience'); // all, role:teacher, class:1, parents
            $t->string('title');
            $t->text('body');
            $t->timestamps();
        });

        Schema::create('messages', function (Blueprint $t) {
            $t->id();
            $t->foreignId('sender_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('recipient_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('about_student_user_id')->nullable()->constrained('users')->nullOnDelete();
            $t->text('body');
            $t->timestamp('read_at')->nullable();
            $t->timestamps();
        });

        Schema::create('push_tokens', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->constrained()->cascadeOnDelete();
            $t->string('token');
            $t->string('platform'); // ios, android, web
            $t->timestamps();
            $t->unique(['user_id', 'token']);
        });

        Schema::create('notifications', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->constrained()->cascadeOnDelete();
            $t->string('type');
            $t->string('title');
            $t->text('body');
            $t->json('data')->nullable();
            $t->timestamp('read_at')->nullable();
            $t->timestamps();
            $t->index(['user_id', 'read_at']);
        });

        Schema::create('audit_logs', function (Blueprint $t) {
            $t->id();
            $t->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $t->string('action');
            $t->string('entity_type')->nullable();
            $t->unsignedBigInteger('entity_id')->nullable();
            $t->json('changes')->nullable();
            $t->string('ip', 45)->nullable();
            $t->text('user_agent')->nullable();
            $t->timestamps();
        });

        Schema::create('exams', function (Blueprint $t) {
            $t->id();
            $t->foreignId('class_room_id')->constrained()->cascadeOnDelete();
            $t->foreignId('subject_id')->constrained()->cascadeOnDelete();
            $t->foreignId('semester_id')->nullable()->constrained()->nullOnDelete();
            $t->string('title');
            $t->date('exam_date');
            $t->time('start_time');
            $t->time('end_time');
            $t->string('room')->nullable();
            $t->timestamps();
        });

        Schema::create('calendar_events', function (Blueprint $t) {
            $t->id();
            $t->string('title');
            $t->text('description')->nullable();
            $t->string('type'); // holiday, exam, event, semester_start, semester_end
            $t->date('start_date');
            $t->date('end_date')->nullable();
            $t->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('calendar_events');
        Schema::dropIfExists('exams');
        Schema::dropIfExists('audit_logs');
        Schema::dropIfExists('notifications');
        Schema::dropIfExists('push_tokens');
        Schema::dropIfExists('messages');
        Schema::dropIfExists('announcements');
        Schema::dropIfExists('hr_requests');
        Schema::dropIfExists('payroll_records');
        Schema::dropIfExists('payments');
        Schema::dropIfExists('invoices');
        Schema::dropIfExists('fee_structures');
        Schema::dropIfExists('conduct_logs');
        Schema::dropIfExists('grades');
        Schema::dropIfExists('grade_components');
        Schema::dropIfExists('submissions');
        Schema::dropIfExists('assignments');
        Schema::dropIfExists('staff_attendance');
        Schema::dropIfExists('attendance_records');
        Schema::dropIfExists('timetable_entries');
        Schema::dropIfExists('class_subject_teacher');
        Schema::dropIfExists('staff_profiles');
        Schema::dropIfExists('parent_student');
        Schema::dropIfExists('student_profiles');
        Schema::dropIfExists('subjects');
        Schema::dropIfExists('class_rooms');
        Schema::dropIfExists('semesters');
        Schema::dropIfExists('academic_years');
    }
};
