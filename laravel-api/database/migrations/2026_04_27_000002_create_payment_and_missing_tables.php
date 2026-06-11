<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // Payment transactions for gateway tracking
        Schema::create('payment_transactions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('invoice_id')->constrained()->cascadeOnDelete();
            $t->string('provider'); // stripe, paypal, etc.
            $t->string('provider_transaction_id')->index();
            $t->decimal('amount', 12, 2);
            $t->string('currency', 3)->default('USD');
            $t->string('status')->default('pending'); // pending, completed, failed, refunded
            $t->json('metadata')->nullable();
            $t->text('error_message')->nullable();
            $t->timestamp('completed_at')->nullable();
            $t->decimal('refunded_amount', 12, 2)->default(0);
            $t->timestamps();

            $t->index(['invoice_id', 'status']);
            $t->index(['provider_transaction_id', 'provider']);
        });

        // Library module
        Schema::create('library_books', function (Blueprint $t) {
            $t->id();
            $t->string('isbn')->nullable()->unique();
            $t->string('title');
            $t->string('author');
            $t->string('publisher')->nullable();
            $t->year('publication_year')->nullable();
            $t->string('category')->nullable();
            $t->text('description')->nullable();
            $t->string('cover_image')->nullable();
            $t->integer('total_copies')->default(1);
            $t->integer('available_copies')->default(1);
            $t->string('location')->nullable(); // shelf location
            $t->boolean('is_active')->default(true);
            $t->timestamps();
        });

        Schema::create('library_borrowings', function (Blueprint $t) {
            $t->id();
            $t->foreignId('book_id')->constrained('library_books')->cascadeOnDelete();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->date('borrowed_date');
            $t->date('due_date');
            $t->date('returned_date')->nullable();
            $t->decimal('fine_amount', 8, 2)->default(0);
            $t->boolean('is_returned')->default(false);
            $t->foreignId('issued_by')->constrained('users');
            $t->foreignId('returned_to')->nullable()->constrained('users')->nullOnDelete();
            $t->text('notes')->nullable();
            $t->timestamps();

            $t->index(['student_user_id', 'is_returned']);
            $t->index(['due_date', 'is_returned']);
        });

        // Transportation module
        Schema::create('transport_routes', function (Blueprint $t) {
            $t->id();
            $t->string('name');
            $t->text('description')->nullable();
            $t->time('departure_time');
            $t->time('return_time');
            $t->decimal('fee', 10, 2)->default(0);
            $t->integer('capacity');
            $t->boolean('is_active')->default(true);
            $t->timestamps();
        });

        Schema::create('transport_vehicles', function (Blueprint $t) {
            $t->id();
            $t->string('registration_number')->unique();
            $t->string('model')->nullable();
            $t->string('type'); // bus, van, etc.
            $t->integer('capacity');
            $t->foreignId('route_id')->nullable()->constrained('transport_routes')->nullOnDelete();
            $t->foreignId('driver_id')->nullable()->constrained('users')->nullOnDelete();
            $t->string('gps_device_id')->nullable();
            $t->boolean('is_active')->default(true);
            $t->timestamps();
        });

        Schema::create('transport_assignments', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('route_id')->constrained('transport_routes')->cascadeOnDelete();
            $t->foreignId('pickup_stop_id')->nullable();
            $t->foreignId('dropoff_stop_id')->nullable();
            $t->date('start_date');
            $t->date('end_date')->nullable();
            $t->boolean('is_active')->default(true);
            $t->timestamps();

            $t->unique(['student_user_id', 'route_id']);
        });

        Schema::create('transport_stops', function (Blueprint $t) {
            $t->id();
            $t->foreignId('route_id')->constrained('transport_routes')->cascadeOnDelete();
            $t->string('name');
            $t->text('address');
            $t->decimal('latitude', 10, 8)->nullable();
            $t->decimal('longitude', 11, 8)->nullable();
            $t->time('pickup_time');
            $t->time('dropoff_time');
            $t->integer('sequence_number');
            $t->timestamps();
        });

        // Medical records enhancement
        Schema::create('medical_records', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->text('allergies')->nullable();
            $t->text('chronic_conditions')->nullable();
            $t->text('medications')->nullable();
            $t->string('blood_type', 5)->nullable();
            $t->string('primary_doctor_name')->nullable();
            $t->string('primary_doctor_phone')->nullable();
            $t->string('insurance_provider')->nullable();
            $t->string('insurance_policy_number')->nullable();
            $t->text('emergency_instructions')->nullable();
            $t->timestamps();
        });

        Schema::create('medical_visits', function (Blueprint $t) {
            $t->id();
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->date('visit_date');
            $t->text('symptoms');
            $t->text('diagnosis')->nullable();
            $t->text('treatment')->nullable();
            $t->text('medications_given')->nullable();
            $t->foreignId('attended_by')->constrained('users');
            $t->text('notes')->nullable();
            $t->boolean('parent_notified')->default(false);
            $t->timestamp('notified_at')->nullable();
            $t->timestamps();
        });

        // Performance evaluations
        Schema::create('performance_evaluations', function (Blueprint $t) {
            $t->id();
            $t->foreignId('staff_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('evaluator_id')->constrained('users');
            $t->date('evaluation_date');
            $t->string('period'); // Q1 2026, Annual 2026, etc.
            $t->json('criteria_scores'); // [{criteria: "communication", score: 4}]
            $t->decimal('overall_score', 3, 2)->nullable();
            $t->text('strengths')->nullable();
            $t->text('areas_for_improvement')->nullable();
            $t->text('goals')->nullable();
            $t->text('evaluator_comments')->nullable();
            $t->foreignId('reviewed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('reviewed_at')->nullable();
            $t->timestamps();
        });

        // Recruitment
        Schema::create('job_postings', function (Blueprint $t) {
            $t->id();
            $t->string('title');
            $t->text('description');
            $t->text('requirements');
            $t->string('department');
            $t->string('position_type'); // full-time, part-time, contract
            $t->date('posting_date');
            $t->date('closing_date')->nullable();
            $t->string('status')->default('open'); // open, closed, filled
            $t->foreignId('posted_by')->constrained('users');
            $t->timestamps();
        });

        Schema::create('job_applications', function (Blueprint $t) {
            $t->id();
            $t->foreignId('job_posting_id')->constrained()->cascadeOnDelete();
            $t->string('applicant_name');
            $t->string('applicant_email');
            $t->string('applicant_phone');
            $t->text('cover_letter')->nullable();
            $t->string('cv_path');
            $t->string('status')->default('new'); // new, reviewing, interviewed, accepted, rejected
            $t->text('notes')->nullable();
            $t->date('interview_date')->nullable();
            $t->foreignId('reviewed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('job_applications');
        Schema::dropIfExists('job_postings');
        Schema::dropIfExists('performance_evaluations');
        Schema::dropIfExists('medical_visits');
        Schema::dropIfExists('medical_records');
        Schema::dropIfExists('transport_stops');
        Schema::dropIfExists('transport_assignments');
        Schema::dropIfExists('transport_vehicles');
        Schema::dropIfExists('transport_routes');
        Schema::dropIfExists('library_borrowings');
        Schema::dropIfExists('library_books');
        Schema::dropIfExists('payment_transactions');
    }
};
