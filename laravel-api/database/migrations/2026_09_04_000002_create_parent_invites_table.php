<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * School-issued codes that let a guardian activate the app without a password.
 *
 * Jordanian parents will not manage a password reset. Every failure becomes a
 * phone call to the school office, and the school blames the app. A code the
 * office hands over in person is the flow that actually completes.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('parent_invites', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained('schools')->restrictOnDelete();

            // The one guardian this code activates. A code is bound to a person
            // at issue time; it cannot be handed to someone else and used.
            $table->foreignId('guardian_user_id')->constrained('users')->cascadeOnDelete();

            // Keyed HMAC of the normalised code, never the code itself. Indexed
            // because it is the only lookup path; deterministic because a
            // salted hash cannot be looked up at all.
            $table->string('code_hash', 64);

            $table->timestamp('expires_at');
            $table->timestamp('redeemed_at')->nullable();

            // Which device redeemed it, for the audit trail.
            $table->string('redeemed_device_id', 255)->nullable();

            $table->unsignedSmallInteger('attempts')->default(0);
            $table->foreignId('issued_by')->constrained('users')->restrictOnDelete();
            $table->timestamps();

            $table->unique('code_hash');
            $table->index(['school_id', 'guardian_user_id']);
            $table->index(['guardian_user_id', 'redeemed_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('parent_invites');
    }
};
