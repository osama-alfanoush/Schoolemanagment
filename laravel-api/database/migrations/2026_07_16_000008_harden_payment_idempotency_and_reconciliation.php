<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            $table->uuid('idempotency_key')->nullable()->unique();
            $table->string('idempotency_payload_hash', 64)->nullable();
        });
        Schema::table('payment_transactions', function (Blueprint $table) {
            $table->unique(['provider', 'provider_transaction_id'], 'payment_provider_transaction_unique');
        });
        Schema::create('payment_allocations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payment_id')->unique()->constrained()->restrictOnDelete();
            $table->foreignId('invoice_id')->constrained()->restrictOnDelete();
            $table->decimal('amount', 12, 2);
            $table->timestamps();
            $table->index(['invoice_id', 'created_at']);
        });
        Schema::create('payment_reversals', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payment_id')->constrained()->restrictOnDelete();
            $table->decimal('amount', 12, 2);
            $table->string('provider_reference')->unique();
            $table->text('reason');
            $table->timestamp('reversed_at');
            $table->timestamps();
        });
        Schema::create('payment_webhook_events', function (Blueprint $table) {
            $table->id();
            $table->string('provider');
            $table->string('event_id');
            $table->string('payload_hash', 64);
            $table->string('status')->default('pending');
            $table->unsignedSmallInteger('attempts')->default(0);
            $table->timestamp('processed_at')->nullable();
            $table->text('last_error')->nullable();
            $table->timestamps();
            $table->unique(['provider', 'event_id']);
        });
        Schema::create('payment_reconciliation_runs', function (Blueprint $table) {
            $table->id();
            $table->uuid('run_id')->unique();
            $table->unsignedInteger('invoice_count');
            $table->unsignedInteger('mismatch_count');
            $table->json('mismatches');
            $table->foreignId('requested_by')->nullable()->constrained('users')->restrictOnDelete();
            $table->timestamp('completed_at');
            $table->timestamps();
        });

        DB::table('payments')->orderBy('id')->each(function ($payment) {
            DB::table('payment_allocations')->insertOrIgnore([
                'payment_id' => $payment->id, 'invoice_id' => $payment->invoice_id,
                'amount' => $payment->amount, 'created_at' => $payment->created_at, 'updated_at' => $payment->updated_at,
            ]);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payment_reconciliation_runs');
        Schema::dropIfExists('payment_webhook_events');
        Schema::dropIfExists('payment_reversals');
        Schema::dropIfExists('payment_allocations');
        Schema::table('payment_transactions', fn (Blueprint $table) => $table->dropUnique('payment_provider_transaction_unique'));
        Schema::table('payments', function (Blueprint $table) {
            $table->dropUnique(['idempotency_key']);
            $table->dropColumn('idempotency_key');
            $table->dropColumn('idempotency_payload_hash');
        });
    }
};
