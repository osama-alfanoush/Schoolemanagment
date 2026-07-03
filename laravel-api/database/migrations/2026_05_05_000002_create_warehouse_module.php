<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('warehouse_categories', function (Blueprint $t) {
            $t->id();
            $t->string('name')->unique();
            $t->text('description')->nullable();
            $t->timestamps();
        });

        Schema::create('warehouse_items', function (Blueprint $t) {
            $t->id();
            $t->string('sku')->unique();
            $t->string('name');
            $t->text('description')->nullable();
            $t->foreignId('category_id')->constrained('warehouse_categories')->cascadeOnDelete();
            $t->string('unit'); // piece, box, ream, liter, kg
            $t->decimal('current_qty', 10, 2)->default(0);
            $t->decimal('min_stock_qty', 10, 2)->default(0);
            $t->string('location')->nullable();
            $t->boolean('is_active')->default(true);
            $t->timestamps();

            $t->index(['is_active']);
        });

        Schema::create('stock_movements', function (Blueprint $t) {
            $t->id();
            $t->foreignId('item_id')->constrained('warehouse_items')->cascadeOnDelete();
            $t->enum('movement_type', ['in', 'out', 'adjustment', 'return']);
            $t->decimal('quantity', 10, 2);
            $t->decimal('qty_before', 10, 2);
            $t->decimal('qty_after', 10, 2);
            $t->string('department')->nullable();
            $t->string('recipient_name')->nullable();
            $t->text('reason')->nullable();
            $t->string('reference_no')->nullable();
            $t->string('supplier')->nullable();
            $t->foreignId('performed_by')->constrained('users');
            $t->timestamp('movement_date');
            $t->timestamps();

            $t->index(['item_id', 'movement_type']);
        });

        Schema::create('purchase_requests', function (Blueprint $t) {
            $t->id();
            $t->string('request_no')->unique();
            $t->foreignId('item_id')->constrained('warehouse_items');
            $t->decimal('quantity_requested', 10, 2);
            $t->string('unit');
            $t->text('justification')->nullable();
            $t->decimal('estimated_cost', 12, 2)->nullable();
            $t->enum('status', ['pending', 'approved', 'rejected', 'purchased'])->default('pending');
            $t->text('admin_notes')->nullable();
            $t->foreignId('requested_by')->constrained('users');
            $t->foreignId('reviewed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('reviewed_at')->nullable();
            $t->timestamps();

            $t->index(['status']);
        });

        Schema::create('inventory_counts', function (Blueprint $t) {
            $t->id();
            $t->string('count_ref')->unique();
            $t->enum('count_type', ['monthly', 'annual', 'spot'])->default('monthly');
            $t->date('count_date');
            $t->foreignId('item_id')->constrained('warehouse_items');
            $t->decimal('system_qty', 10, 2);
            $t->decimal('physical_qty', 10, 2);
            $t->text('notes')->nullable();
            $t->foreignId('counted_by')->constrained('users');
            $t->timestamps();

            $t->index(['count_date', 'count_type']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('inventory_counts');
        Schema::dropIfExists('purchase_requests');
        Schema::dropIfExists('stock_movements');
        Schema::dropIfExists('warehouse_items');
        Schema::dropIfExists('warehouse_categories');
    }
};
