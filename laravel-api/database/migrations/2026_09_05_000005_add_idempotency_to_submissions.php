<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * Makes a retried hand-in answerable rather than merely impossible.
 *
 * `(assignment_id, student_user_id)` is already unique, so a second submission
 * cannot exist. What was missing is a way to tell "the phone is retrying the
 * upload it already sent" from "the student is replacing their work": without
 * the key both look identical, and the retry either overwrites a newer file or
 * is refused as a conflict the student cannot act on.
 *
 * Nullable because the web submits without one.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::table('submissions', function (Blueprint $table) {
            $table->uuid('idempotency_key')->nullable()->after('status');
        });
    }

    public function down(): void
    {
        Schema::table('submissions', function (Blueprint $table) {
            $table->dropColumn('idempotency_key');
        });
    }
};
