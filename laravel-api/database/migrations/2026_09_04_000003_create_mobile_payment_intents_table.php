<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * A guardian's intent to pay one installment.
 *
 * The unique index on `idempotency_key` is the whole guarantee. A parent on a
 * bad connection taps pay, sees nothing happen, and taps again; the phone may
 * also retry the request itself. Every one of those attempts carries the same
 * key, and the database — not the application, and not a check-then-insert —
 * is what makes exactly one of them win.
 *
 * `request_hash` exists so a key cannot be replayed against a *different*
 * amount. Same key and same body is the retry we want to absorb; same key and
 * a different body is a bug or an attack, and is refused.
 */
return new class extends Migration
{
    public function up(): void
    {
        Schema::create('mobile_payment_intents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained('schools')->restrictOnDelete();

            $table->uuid('idempotency_key')->unique();
            $table->string('request_hash', 64);

            // Human-quotable, so a parent phoning the office can name it.
            $table->string('reference', 40)->unique();

            $table->foreignId('guardian_user_id')->constrained('users')->restrictOnDelete();
            $table->foreignId('student_user_id')->constrained('users')->restrictOnDelete();
            $table->foreignId('installment_id')->constrained('installments')->restrictOnDelete();

            // Integer minor units. There is deliberately no decimal column here:
            // this row is created from a decimal one and must not re-introduce
            // the rounding it was converted away from.
            $table->unsignedBigInteger('amount_minor');
            $table->string('currency', 3);
            $table->unsignedTinyInteger('decimals');

            $table->string('status', 20)->default('created');
            $table->timestamps();

            $table->index(['school_id', 'guardian_user_id']);
            $table->index(['installment_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('mobile_payment_intents');
    }
};
