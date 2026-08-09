<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payment_plans', function (Blueprint $t) {
            $t->id();
            $t->string('plan_no')->unique(); // format: PLAN-2026-0001
            $t->foreignId('student_user_id')->constrained('users')->cascadeOnDelete();
            $t->foreignId('invoice_id')->nullable()->constrained('invoices')->nullOnDelete();
            $t->decimal('total_amount', 12, 2);
            $t->decimal('down_payment', 12, 2)->default(0);
            $t->unsignedTinyInteger('num_installments');
            $t->string('frequency')->default('monthly'); // monthly, quarterly
            $t->date('start_date');
            $t->string('status')->default('active'); // active, completed, defaulted, cancelled
            $t->foreignId('created_by')->constrained('users');
            $t->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamps();
            $t->softDeletes();

            $t->index(['student_user_id', 'status']);
        });

        Schema::create('installments', function (Blueprint $t) {
            $t->id();
            $t->foreignId('payment_plan_id')->constrained('payment_plans')->cascadeOnDelete();
            $t->unsignedTinyInteger('sequence_no');
            $t->date('due_date');
            $t->decimal('amount', 12, 2);
            $t->decimal('paid_amount', 12, 2)->default(0);
            $t->string('status')->default('pending'); // pending, partial, paid, overdue, waived
            $t->foreignId('payment_id')->nullable()->constrained('payments')->nullOnDelete();
            $t->timestamp('paid_at')->nullable();
            $t->timestamp('reminder_sent_at')->nullable();
            $t->timestamps();

            $t->unique(['payment_plan_id', 'sequence_no']);
            $t->index(['status', 'due_date']); // reminder scan
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('installments');
        Schema::dropIfExists('payment_plans');
    }
};
