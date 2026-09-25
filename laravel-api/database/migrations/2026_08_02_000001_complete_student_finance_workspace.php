<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payment_receipts', function (Blueprint $table) {
            $table->id();
            $table->string('receipt_no')->unique();
            $table->foreignId('student_user_id')->constrained('users')->restrictOnDelete();
            $table->decimal('amount', 12, 2);
            $table->string('method');
            $table->date('receipt_date');
            $table->string('reference')->nullable();
            $table->string('cash_account')->nullable();
            $table->text('note')->nullable();
            $table->string('status')->default('draft');
            $table->uuid('idempotency_key')->unique();
            $table->string('idempotency_payload_hash', 64);
            $table->foreignId('created_by')->constrained('users')->restrictOnDelete();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('posted_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('reversed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->timestamp('posted_at')->nullable();
            $table->timestamp('reversed_at')->nullable();
            $table->text('reversal_reason')->nullable();
            $table->timestamps();

            $table->index(['student_user_id', 'receipt_date']);
            $table->index(['status', 'receipt_date']);
        });

        Schema::create('payment_receipt_allocations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payment_receipt_id')->constrained('payment_receipts')->cascadeOnDelete();
            $table->foreignId('invoice_id')->constrained('invoices')->restrictOnDelete();
            $table->foreignId('installment_id')->nullable()->constrained('installments')->restrictOnDelete();
            $table->decimal('amount', 12, 2);
            $table->timestamps();

            $table->index(['payment_receipt_id', 'invoice_id']);
        });

        Schema::table('payments', function (Blueprint $table) {
            $table->foreignId('payment_receipt_id')->nullable()->constrained('payment_receipts')->nullOnDelete();
            $table->string('status')->default('posted');
            $table->timestamp('reversed_at')->nullable();
            $table->index(['status', 'paid_at']);
        });

        Schema::create('student_financial_adjustments', function (Blueprint $table) {
            $table->id();
            $table->string('adjustment_no')->unique();
            $table->foreignId('student_user_id')->constrained('users')->restrictOnDelete();
            $table->foreignId('invoice_id')->nullable()->constrained('invoices')->restrictOnDelete();
            $table->string('type'); // discount, adjustment, refund
            $table->string('direction'); // debit increases due, credit reduces it
            $table->string('calculation_type')->default('amount'); // amount, percentage
            $table->decimal('value', 12, 4);
            $table->decimal('amount', 12, 2);
            $table->string('reason');
            $table->string('status')->default('draft');
            $table->foreignId('created_by')->constrained('users')->restrictOnDelete();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('posted_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('reversed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->timestamp('posted_at')->nullable();
            $table->timestamp('reversed_at')->nullable();
            $table->text('reversal_reason')->nullable();
            $table->timestamps();

            $table->index(['student_user_id', 'status']);
            $table->index(['invoice_id', 'status']);
        });

        Schema::create('journal_batches', function (Blueprint $table) {
            $table->id();
            $table->string('reference_no')->unique();
            $table->date('entry_date');
            $table->string('description');
            $table->string('source')->default('manual');
            $table->unsignedBigInteger('source_id')->nullable();
            $table->foreignId('academic_year_id')->nullable()->constrained('academic_years')->nullOnDelete();
            $table->string('branch_reference')->nullable();
            $table->string('status')->default('draft');
            $table->foreignId('created_by')->constrained('users')->restrictOnDelete();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('posted_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('reversed_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('reversal_of_id')->nullable()->constrained('journal_batches')->nullOnDelete();
            $table->timestamp('approved_at')->nullable();
            $table->timestamp('posted_at')->nullable();
            $table->timestamp('reversed_at')->nullable();
            $table->text('reversal_reason')->nullable();
            $table->timestamps();

            $table->index(['entry_date', 'status']);
            $table->index(['source', 'source_id']);
        });

        Schema::table('journal_entries', function (Blueprint $table) {
            $table->foreignId('journal_batch_id')->nullable()->constrained('journal_batches')->nullOnDelete();
            $table->string('line_description')->nullable();
            $table->string('cost_center')->nullable();
            $table->index(['journal_batch_id', 'type']);
        });
    }

    public function down(): void
    {
        Schema::table('journal_entries', function (Blueprint $table) {
            $table->dropForeign(['journal_batch_id']);
            $table->dropIndex(['journal_batch_id', 'type']);
            $table->dropColumn(['journal_batch_id', 'line_description', 'cost_center']);
        });
        Schema::dropIfExists('journal_batches');
        Schema::dropIfExists('student_financial_adjustments');
        Schema::table('payments', function (Blueprint $table) {
            $table->dropForeign(['payment_receipt_id']);
            $table->dropIndex(['status', 'paid_at']);
            $table->dropColumn(['payment_receipt_id', 'status', 'reversed_at']);
        });
        Schema::dropIfExists('payment_receipt_allocations');
        Schema::dropIfExists('payment_receipts');
    }
};
