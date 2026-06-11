<?php

namespace App\Services;

use App\Models\BudgetPlan;
use App\Models\Payment;
use App\Models\PayrollRecord;
use App\Models\User;
use Illuminate\Http\Request;

class BudgetService
{
    public function listBudget(Request $request): array
    {
        $year = (int) $request->query('fiscal_year', now()->year);
        $plans = BudgetPlan::where('fiscal_year', $year)->get();
        $totalPlanned = (float) $plans->sum('planned_amount');
        $totalActual = (float) $plans->sum('actual_amount');

        return [
            'data' => $plans,
            'summary' => [
                'total_planned' => $totalPlanned,
                'total_actual' => $totalActual,
                'total_variance' => $totalPlanned - $totalActual,
            ],
        ];
    }

    public function createBudget(Request $request): array
    {
        $data = $request->validate([
            'fiscal_year' => 'required|integer',
            'category' => 'required|string',
            'sub_category' => 'nullable|string',
            'planned_amount' => 'required|numeric|min:1',
            'actual_amount' => 'nullable|numeric',
            'created_by' => 'nullable|exists:users,id',
        ]);
        $data['actual_amount'] = $data['actual_amount'] ?? 0;
        $data['created_by'] = $data['created_by'] ?? $request->user()->id;
        $plan = BudgetPlan::create($data);
        AuditLogger::log($request, 'create_budget_plan', 'budget_plan', $plan->id, $data);

        return ['data' => $plan, 'status' => 201];
    }

    public function updateBudget(Request $request, int $id): array
    {
        $plan = BudgetPlan::findOrFail($id);
        $data = $request->validate([
            'fiscal_year' => 'sometimes|integer',
            'category' => 'sometimes|string',
            'sub_category' => 'nullable|string',
            'planned_amount' => 'sometimes|numeric|min:1',
            'actual_amount' => 'sometimes|numeric',
        ]);
        $plan->update($data);
        AuditLogger::log($request, 'update_budget_plan', 'budget_plan', $plan->id, $data);

        return ['data' => $plan];
    }

    public function syncActuals(Request $request): array
    {
        $data = $request->validate([
            'fiscal_year' => 'required|integer',
            'alert_threshold' => 'integer',
        ]);
        $year = $data['fiscal_year'];
        $threshold = $data['alert_threshold'] ?? 90;

        $paymentTotal = (float) Payment::whereYear('paid_at', $year)->sum('amount');
        $payrollTotal = (float) PayrollRecord::where('year', $year)->sum('net_pay');

        $plans = BudgetPlan::where('fiscal_year', $year)->get();
        $updated = [];

        foreach ($plans as $plan) {
            $actual = 0;
            $cat = strtolower($plan->category);
            if (str_contains($cat, 'salaries') || str_contains($cat, 'payroll')) {
                $actual = $payrollTotal;
            } else {
                $actual = $paymentTotal;
            }
            $plan->update(['actual_amount' => $actual]);
            $updated[] = [
                'id' => $plan->id,
                'category' => $plan->category,
                'actual_amount' => $actual,
                'usage_percent' => $plan->usage_percent,
            ];
        }

        $overrunPlans = BudgetPlan::where('fiscal_year', $year)->get()
            ->filter(fn($p) => $p->usage_percent >= $threshold);

        $recipientIds = User::whereIn('role', ['accounting', 'admin'])
            ->where('is_active', true)->pluck('id')->toArray();

        foreach ($overrunPlans as $overrun) {
            NotificationService::sendToMany($recipientIds, 'budget_overrun', [
                'category' => $overrun->category,
                'usage_percent' => $overrun->usage_percent,
                'planned' => (float) $overrun->planned_amount,
                'actual' => (float) $overrun->actual_amount,
            ]);
        }

        AuditLogger::log($request, 'sync_budget_actuals', 'budget_plan', null, [
            'fiscal_year' => $year, 'updated' => count($updated), 'overruns' => $overrunPlans->count(),
        ]);

        return [
            'data' => [
                'updated' => $updated,
                'overruns' => $overrunPlans->count(),
            ],
        ];
    }
}