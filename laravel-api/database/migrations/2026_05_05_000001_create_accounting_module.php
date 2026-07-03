<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('journal_entries', function (Blueprint $t) {
            $t->id();
            $t->date('entry_date');
            $t->string('reference_no')->unique(); // format: JE-2026-0001
            $t->string('description');
            $t->enum('type', ['debit', 'credit']);
            $t->string('account_code');
            $t->string('account_name');
            $t->decimal('amount', 12, 2);
            $t->enum('source', ['manual', 'invoice', 'payroll', 'expense'])->default('manual');
            $t->unsignedBigInteger('source_id')->nullable(); // FK to invoices or payroll_records
            $t->foreignId('created_by')->constrained('users')->cascadeOnDelete();
            $t->timestamps();
            $t->softDeletes();

            $t->index(['entry_date', 'type']);
        });

        Schema::create('chart_of_accounts', function (Blueprint $t) {
            $t->id();
            $t->string('account_code')->unique();
            $t->string('account_name');
            $t->enum('account_type', ['asset', 'liability', 'equity', 'income', 'expense']);
            $t->text('description')->nullable();
            $t->boolean('is_active')->default(true);
            $t->timestamps();
        });

        Schema::create('budget_plans', function (Blueprint $t) {
            $t->id();
            $t->year('fiscal_year');
            $t->string('category'); // salaries, operations, activities, maintenance
            $t->string('sub_category')->nullable();
            $t->decimal('planned_amount', 12, 2);
            $t->decimal('actual_amount', 12, 2)->default(0);
            $t->foreignId('created_by')->constrained('users')->cascadeOnDelete();
            $t->timestamps();

            $t->unique(['fiscal_year', 'category', 'sub_category']);
        });

        Schema::create('financial_closings', function (Blueprint $t) {
            $t->id();
            $t->unsignedTinyInteger('month');
            $t->year('year');
            $t->enum('status', ['open', 'closed', 'audited'])->default('open');
            $t->text('notes')->nullable();
            $t->foreignId('closed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('closed_at')->nullable();
            $t->timestamps();

            $t->unique(['month', 'year']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('financial_closings');
        Schema::dropIfExists('budget_plans');
        Schema::dropIfExists('chart_of_accounts');
        Schema::dropIfExists('journal_entries');
    }
};
