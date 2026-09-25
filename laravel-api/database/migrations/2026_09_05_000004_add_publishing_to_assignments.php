<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

/**
 * Drafts, and writes that survive being sent twice.
 *
 * An assignment written on a phone between lessons is not finished when the
 * teacher is interrupted, and a half-written one that has already notified
 * thirty families is worse than no app at all. `published_at` separates the
 * two states; everything that exists today was live the moment it was created,
 * so it is backfilled rather than hidden.
 *
 * The idempotency keys are nullable because the web creates these rows without
 * one. Unique where present, which is what makes a retried mobile send land
 * once.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::table('assignments', function (Blueprint $table) {
            $table->timestamp('published_at')->nullable()->after('due_at');
            $table->uuid('idempotency_key')->nullable()->unique();
        });

        // Existing assignments are live. Leaving them null would retract every
        // piece of homework in the school on deploy.
        DB::table('assignments')->update(['published_at' => DB::raw('created_at')]);

        Schema::table('announcements', function (Blueprint $table) {
            $table->string('template_key', 64)->nullable()->after('audience');
            $table->uuid('idempotency_key')->nullable()->unique();
        });
    }

    public function down(): void
    {
        Schema::table('assignments', function (Blueprint $table) {
            $table->dropUnique(['idempotency_key']);
            $table->dropColumn(['published_at', 'idempotency_key']);
        });
        Schema::table('announcements', function (Blueprint $table) {
            $table->dropUnique(['idempotency_key']);
            $table->dropColumn(['template_key', 'idempotency_key']);
        });
    }
};
