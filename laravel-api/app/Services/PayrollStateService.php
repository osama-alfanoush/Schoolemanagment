<?php

namespace App\Services;

use App\Models\FinancialClosing;
use App\Models\PayrollRun;
use Illuminate\Validation\ValidationException;

final class PayrollStateService
{
    private const FROM = [
        'process' => ['draft'],
        'approve' => ['processed'],
        'pay' => ['approved'],
        'reverse' => ['approved', 'paid'],
    ];

    public function assertAllowed(PayrollRun $run, string $action): void
    {
        if (! in_array($run->status, self::FROM[$action] ?? [], true)) {
            throw ValidationException::withMessages([
                'status' => "Cannot {$action} a {$run->status} payroll run.",
            ]);
        }

        $closed = FinancialClosing::where('school_id', $run->school_id)
            ->where('year', $run->year)->where('month', $run->month)
            ->whereIn('status', ['closed', 'audited'])->exists();
        if ($closed) {
            throw ValidationException::withMessages(['period' => 'This school accounting period is closed.']);
        }
    }
}
