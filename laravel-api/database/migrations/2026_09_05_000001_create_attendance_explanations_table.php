<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * A guardian's explanation for an absence.
 *
 * A separate row rather than a write into `attendance_records.note`: that note
 * is the teacher's record of what they observed, and a parent's account of why
 * is a different claim by a different person. Overwriting one with the other
 * loses the register's own evidence.
 *
 * Nothing here changes the attendance status. Only the school decides whether
 * an absence becomes excused; this is the message that asks.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('attendance_explanations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained('schools')->restrictOnDelete();
            $table->foreignId('attendance_record_id')->constrained('attendance_records')->cascadeOnDelete();
            $table->foreignId('guardian_user_id')->constrained('users')->restrictOnDelete();

            $table->text('reason');

            // Same shape as every other write on this surface: a phone that
            // retries must not file the explanation twice.
            $table->uuid('idempotency_key')->unique();

            $table->timestamps();

            $table->index(['school_id', 'attendance_record_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('attendance_explanations');
    }
};
