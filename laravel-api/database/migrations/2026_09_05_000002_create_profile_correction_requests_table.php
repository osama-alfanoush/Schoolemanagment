<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * A guardian asking the office to fix something on their child's record.
 *
 * A request, not an edit. A parent cannot change a student profile — an
 * admission number or a date of birth a family can rewrite is not a record
 * anyone can rely on — so this is the message that asks a human to look.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('profile_correction_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained('schools')->restrictOnDelete();
            $table->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('requested_by')->constrained('users')->restrictOnDelete();

            /** Which field the guardian says is wrong, and what they say it is. */
            $table->string('field', 64);
            $table->text('detail');

            $table->string('status', 20)->default('open');
            $table->uuid('idempotency_key')->unique();
            $table->timestamps();

            $table->index(['school_id', 'status']);
            $table->index(['student_user_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('profile_correction_requests');
    }
};
