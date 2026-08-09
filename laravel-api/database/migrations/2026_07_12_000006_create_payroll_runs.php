<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payroll_runs', function (Blueprint $t) {
            $t->id();
            $t->string('run_no')->unique(); // format: RUN-2026-07
            $t->integer('year');
            $t->tinyInteger('month');
            $t->string('status')->default('draft'); // draft, processed, approved, paid
            $t->decimal('total_gross', 14, 2)->default(0);
            $t->decimal('total_deductions', 14, 2)->default(0);
            $t->decimal('total_net', 14, 2)->default(0);
            $t->foreignId('processed_by')->nullable()->constrained('users')->nullOnDelete();
            $t->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $t->timestamp('approved_at')->nullable();
            $t->timestamps();

            $t->unique(['year', 'month']);
        });

        Schema::table('payroll_records', function (Blueprint $t) {
            // Nullable: pre-existing records stay valid without a run header.
            $t->foreignId('payroll_run_id')->nullable()
                ->constrained('payroll_runs')->nullOnDelete();
        });

        // Backfill: one run per historic (year, month), linked and marked paid.
        // Portable query-builder SQL — runs identically on PostgreSQL and SQLite.
        $periods = DB::table('payroll_records')
            ->select('year', 'month')
            ->selectRaw('SUM(base_salary + allowances) as gross')
            ->selectRaw('SUM(deductions + advance_deduction) as deducted')
            ->selectRaw('SUM(net_pay) as net')
            ->groupBy('year', 'month')
            ->get();

        foreach ($periods as $p) {
            $runId = DB::table('payroll_runs')->insertGetId([
                'run_no' => sprintf('RUN-%d-%02d', $p->year, $p->month),
                'year' => $p->year,
                'month' => $p->month,
                'status' => 'paid',
                'total_gross' => $p->gross,
                'total_deductions' => $p->deducted,
                'total_net' => $p->net,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            DB::table('payroll_records')
                ->where('year', $p->year)->where('month', $p->month)
                ->update(['payroll_run_id' => $runId]);
        }
    }

    public function down(): void
    {
        Schema::table('payroll_records', function (Blueprint $t) {
            $t->dropConstrainedForeignId('payroll_run_id');
        });
        Schema::dropIfExists('payroll_runs');
    }
};
