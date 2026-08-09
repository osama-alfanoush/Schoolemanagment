<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('suppliers', function (Blueprint $t) {
            $t->id();
            $t->string('code')->unique(); // format: SUP-2026-0001
            $t->string('name');
            $t->string('contact_person')->nullable();
            $t->string('phone');
            $t->string('secondary_phone')->nullable();
            $t->string('email')->nullable();
            $t->text('address')->nullable();
            $t->string('tax_number')->nullable();
            $t->boolean('is_active')->default(true);
            $t->timestamps();
            $t->softDeletes();

            $t->index(['is_active']);
        });

        Schema::create('supplier_accounts', function (Blueprint $t) {
            $t->id();
            $t->foreignId('supplier_id')->unique()->constrained('suppliers')->cascadeOnDelete();
            $t->decimal('balance', 14, 2)->default(0); // positive = payable to supplier
            $t->decimal('credit_limit', 14, 2)->nullable();
            $t->string('payment_terms')->default('net_30'); // cash, net_15, net_30, net_60
            $t->text('notes')->nullable();
            $t->timestamps();
        });

        Schema::create('supplier_transactions', function (Blueprint $t) {
            $t->id();
            $t->foreignId('supplier_account_id')->constrained('supplier_accounts')->cascadeOnDelete();
            $t->string('type'); // invoice, payment, credit_note, adjustment
            $t->decimal('amount', 14, 2); // signed: invoice +, payment -
            $t->decimal('balance_after', 14, 2);
            $t->string('reference_no')->nullable();
            $t->string('source_type')->nullable();
            $t->unsignedBigInteger('source_id')->nullable();
            $t->string('description')->nullable();
            $t->foreignId('performed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('transaction_date');
            $t->timestamps();

            $t->index(['supplier_account_id', 'transaction_date']);
            $t->index(['source_type', 'source_id']);
        });

        Schema::create('purchase_orders', function (Blueprint $t) {
            $t->id();
            $t->string('po_no')->unique(); // format: PO-2026-0001
            $t->foreignId('supplier_id')->constrained('suppliers');
            // draft, pending_approval, approved, partially_received, received, closed, cancelled
            $t->string('status')->default('draft');
            $t->date('order_date');
            $t->date('expected_date')->nullable();
            $t->decimal('subtotal', 14, 2)->default(0);
            $t->decimal('tax', 14, 2)->default(0);
            $t->decimal('total', 14, 2)->default(0);
            $t->text('notes')->nullable();
            $t->foreignId('purchase_request_id')->nullable()
                ->constrained('purchase_requests')->nullOnDelete();
            $t->foreignId('requested_by')->constrained('users');
            $t->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('approved_at')->nullable();
            $t->timestamps();
            $t->softDeletes();

            $t->index(['status']);
            $t->index(['supplier_id', 'status']);
        });

        Schema::create('purchase_order_items', function (Blueprint $t) {
            $t->id();
            $t->foreignId('purchase_order_id')->constrained('purchase_orders')->cascadeOnDelete();
            $t->foreignId('warehouse_item_id')->constrained('warehouse_items');
            $t->string('description')->nullable();
            $t->decimal('quantity_ordered', 10, 2);
            $t->decimal('quantity_received', 10, 2)->default(0);
            $t->string('unit');
            $t->decimal('unit_cost', 12, 2);
            $t->decimal('line_total', 14, 2);
            $t->string('warehouse_location')->nullable();
            $t->timestamps();

            $t->index(['purchase_order_id']);
            $t->index(['warehouse_item_id']);
        });

        Schema::create('goods_receipts', function (Blueprint $t) {
            $t->id();
            $t->string('grn_no')->unique(); // format: GRN-2026-0001
            $t->foreignId('purchase_order_id')->constrained('purchase_orders');
            $t->string('status')->default('posted'); // draft, posted
            $t->text('notes')->nullable();
            $t->foreignId('received_by')->constrained('users');
            $t->timestamp('received_at');
            $t->timestamps();

            $t->index(['purchase_order_id']);
        });

        Schema::create('goods_receipt_items', function (Blueprint $t) {
            $t->id();
            $t->foreignId('goods_receipt_id')->constrained('goods_receipts')->cascadeOnDelete();
            $t->foreignId('purchase_order_item_id')->constrained('purchase_order_items');
            $t->decimal('quantity_received', 10, 2);
            $t->decimal('unit_cost', 12, 2);
            $t->foreignId('stock_movement_id')->nullable()
                ->constrained('stock_movements')->nullOnDelete();
            $t->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('goods_receipt_items');
        Schema::dropIfExists('goods_receipts');
        Schema::dropIfExists('purchase_order_items');
        Schema::dropIfExists('purchase_orders');
        Schema::dropIfExists('supplier_transactions');
        Schema::dropIfExists('supplier_accounts');
        Schema::dropIfExists('suppliers');
    }
};
