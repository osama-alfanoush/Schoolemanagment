<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('warehouse_items', function (Blueprint $t) {
            $t->decimal('unit_cost', 12, 2)->nullable()->after('min_stock_qty'); // weighted average
            $t->decimal('last_unit_cost', 12, 2)->nullable()->after('unit_cost');
            $t->foreignId('preferred_supplier_id')->nullable()
                ->constrained('suppliers')->nullOnDelete();
        });

        Schema::table('stock_movements', function (Blueprint $t) {
            $t->decimal('unit_cost', 12, 2)->nullable()->after('quantity');
            $t->foreignId('purchase_order_id')->nullable()
                ->constrained('purchase_orders')->nullOnDelete();
        });
    }

    public function down(): void
    {
        Schema::table('stock_movements', function (Blueprint $t) {
            $t->dropConstrainedForeignId('purchase_order_id');
            $t->dropColumn('unit_cost');
        });
        Schema::table('warehouse_items', function (Blueprint $t) {
            $t->dropConstrainedForeignId('preferred_supplier_id');
            $t->dropColumn(['unit_cost', 'last_unit_cost']);
        });
    }
};
