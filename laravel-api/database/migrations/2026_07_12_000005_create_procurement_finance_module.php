<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('supplier_invoices', function (Blueprint $t) {
            $t->id();
            $t->string('invoice_no')->unique(); // format: SINV-2026-0001
            $t->string('supplier_invoice_ref')->nullable(); // the supplier's own number
            $t->foreignId('supplier_id')->constrained('suppliers');
            $t->foreignId('purchase_order_id')->nullable()->constrained('purchase_orders')->nullOnDelete();
            $t->date('invoice_date');
            $t->date('due_date');
            $t->decimal('amount', 14, 2);
            $t->decimal('paid_amount', 14, 2)->default(0);
            $t->string('status')->default('pending'); // pending, partial, paid, overdue, cancelled
            $t->text('notes')->nullable();
            $t->foreignId('created_by')->constrained('users');
            $t->timestamps();
            $t->softDeletes();

            $t->index(['supplier_id', 'status']);
            $t->index(['status', 'due_date']); // AP aging
        });

        Schema::create('supplier_payments', function (Blueprint $t) {
            $t->id();
            $t->foreignId('supplier_invoice_id')->constrained('supplier_invoices')->cascadeOnDelete();
            $t->decimal('amount', 14, 2);
            $t->string('method'); // cash, bank_transfer, cheque
            $t->string('reference')->nullable();
            $t->foreignId('recorded_by')->constrained('users');
            $t->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('paid_at');
            $t->text('note')->nullable();
            $t->timestamps();

            $t->index(['supplier_invoice_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('supplier_payments');
        Schema::dropIfExists('supplier_invoices');
    }
};
