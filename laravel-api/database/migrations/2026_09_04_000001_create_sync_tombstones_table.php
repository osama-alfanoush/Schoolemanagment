<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * Deletions the mobile delta feed has to report.
 *
 * A row that is simply gone from `grades` is invisible to a keyset scan over
 * `updated_at`, so a client that cached it would keep showing it forever. The
 * tombstone outlives the row and carries the scope keys the feed needs to
 * decide who is allowed to be told about the deletion — those keys cannot be
 * looked up afterwards, because the row they lived on no longer exists.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('sync_tombstones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained('schools')->restrictOnDelete();
            $table->string('entity_type', 64);
            $table->unsignedBigInteger('entity_id');

            // Scope keys captured at deletion time. Nullable because not every
            // entity type has both: an announcement has neither, a grade has a
            // student and a class, a notification has only a user.
            $table->unsignedBigInteger('subject_user_id')->nullable();
            $table->unsignedBigInteger('class_room_id')->nullable();

            $table->timestamp('deleted_at');

            // The feed's only access path: school, then type, then keyset on id.
            $table->index(['school_id', 'entity_type', 'id'], 'sync_tombstones_feed_idx');
            $table->index(['school_id', 'subject_user_id'], 'sync_tombstones_subject_idx');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sync_tombstones');
    }
};
