<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PaymentReconciliationService
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function run(?int $requestedBy = null): array
    {
        $schoolId = $this->currentSchool->id();
        $rows = DB::table('invoices as i')
            ->leftJoinSub(DB::table('payment_allocations')->where('school_id', $schoolId)->selectRaw('invoice_id, SUM(amount) allocated')->groupBy('invoice_id'), 'a', 'a.invoice_id', '=', 'i.id')
            ->leftJoinSub(DB::table('payment_reversals as r')->where('r.school_id', $schoolId)->join('payments as p', 'p.id', '=', 'r.payment_id')->selectRaw('p.invoice_id, SUM(r.amount) reversed')->groupBy('p.invoice_id'), 'r', 'r.invoice_id', '=', 'i.id')
            ->where('i.school_id', $schoolId)
            ->selectRaw('i.id, i.invoice_no, i.paid_amount stored, COALESCE(a.allocated,0)-COALESCE(r.reversed,0) calculated')
            ->get();
        $mismatches = $rows->filter(fn ($row) => abs((float) $row->stored - (float) $row->calculated) > 0.005)->values();
        $runId = (string) Str::uuid();
        DB::table('payment_reconciliation_runs')->insert([
            'school_id' => $schoolId,
            'run_id' => $runId, 'invoice_count' => $rows->count(), 'mismatch_count' => $mismatches->count(),
            'mismatches' => json_encode($mismatches, JSON_THROW_ON_ERROR), 'requested_by' => $requestedBy,
            'completed_at' => now(), 'created_at' => now(), 'updated_at' => now(),
        ]);

        return ['run_id' => $runId, 'invoice_count' => $rows->count(), 'mismatch_count' => $mismatches->count(), 'mismatches' => $mismatches];
    }
}
