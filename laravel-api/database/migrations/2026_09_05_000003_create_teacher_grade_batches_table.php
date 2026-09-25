<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * One offline grade submission from a teacher's phone.
 *
 * Attendance already has `attendance_submission_batches`; grades had nothing,
 * because on the web a teacher enters one mark at a time on a connection that
 * is up. On a phone a whole column is queued and sent once, and the same send
 * is retried after a timeout that may well have succeeded.
 *
 * The unique index on `idempotency_key` is what makes the retry harmless. It
 * matters more here than for attendance: `Grade` carries an optimistic
 * `version`, so simply replaying the writes would 409 on the second attempt
 * and read to the teacher as data loss. A replay is answered from this row
 * instead, without touching a single grade.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('teacher_grade_batches', function (Blueprint $table) {
            $table->id();
            $table->uuid('idempotency_key')->unique();
            $table->foreignId('school_id')->constrained('schools')->restrictOnDelete();
            $table->foreignId('gradebook_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('class_room_id')->constrained()->restrictOnDelete();
            $table->foreignId('subject_id')->constrained()->restrictOnDelete();
            $table->foreignId('submitted_by')->constrained('users')->restrictOnDelete();

            /**
             * The hash refuses a key reused with different marks. Answering the
             * first payload to a second, different one would silently drop the
             * teacher's corrections.
             */
            $table->string('payload_hash', 64);
            $table->unsignedInteger('record_count');

            /** What the first attempt returned, replayed verbatim to retries. */
            $table->json('result');
            $table->timestamp('committed_at')->nullable();
            $table->timestamps();

            $table->index(['school_id', 'submitted_by']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('teacher_grade_batches');
    }
};
