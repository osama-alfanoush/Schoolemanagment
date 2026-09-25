<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\PayrollRecord;
use App\Models\PayrollRun;
use App\Models\StaffProfile;
use App\Services\AuditLogger;
use App\Services\LedgerService;
use App\Services\PayrollAccountingService;
use App\Services\PayrollCalculationService;
use App\Services\PayrollStateService;
use App\Services\SchoolContext;
use Barryvdh\DomPDF\Facade\Pdf;
use Carbon\Carbon;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

/** Existing run workflow, extended with immutable calculation snapshots and journals. */
class PayrollController extends Controller
{
    public function __construct(
        private PayrollCalculationService $calculator,
        private PayrollAccountingService $accounting,
        private LedgerService $ledger,
        private SchoolContext $schools,
        private PayrollStateService $states,
    ) {}

    public function indexRuns(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = PayrollRun::query()->where('school_id', $schoolId)->with(['creator:id,name', 'processedBy:id,name', 'approvedBy:id,name', 'accrualJournal:id,reference_no,status', 'paymentJournal:id,reference_no,status']);
        if ($year = $request->query('year')) {
            $q->where('year', $year);
        }
        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }

        return response()->json($q->orderByDesc('year')->orderByDesc('month')->paginate($this->perPage($request, 20)));
    }

    public function showRun(Request $request, int $id)
    {
        $schoolId = $this->schools->forUser($request->user());

        return response()->json(PayrollRun::where('school_id', $schoolId)->with([
            'records.staff:id,name,role', 'records.components', 'records.advanceInstallments.advance:id,advance_no',
            'creator:id,name', 'processedBy:id,name', 'approvedBy:id,name', 'paidBy:id,name',
            'accrualJournal.lines', 'paymentJournal.lines',
        ])->findOrFail($id));
    }

    public function storeRun(Request $request)
    {
        $data = $request->validate(['year' => 'required|integer|between:2000,2100', 'month' => 'required|integer|between:1,12']);
        $schoolId = $this->schools->forUser($request->user());
        $scope = 'school:'.$schoolId;
        $start = Carbon::create($data['year'], $data['month'], 1)->startOfMonth();
        $end = $start->copy()->endOfMonth();

        try {
            $run = DB::transaction(function () use ($data, $schoolId, $scope, $start, $end, $request) {
                $baseRunNo = sprintf('RUN-S%d-%d-%02d', $schoolId, $data['year'], $data['month']);
                $run = PayrollRun::create([
                    'run_no' => PayrollRun::where('run_no', $baseRunNo)->exists() ? $baseRunNo.'-'.strtoupper(str()->random(6)) : $baseRunNo,
                    'scope_key' => $scope, 'school_id' => $schoolId, 'year' => $data['year'], 'month' => $data['month'],
                    'period_start' => $start, 'period_end' => $end, 'status' => 'draft',
                    'created_by' => $request->user()->id, 'processed_by' => $request->user()->id,
                    'policy_snapshot' => ['generated_at' => now()->toISOString()],
                ]);
                $profiles = StaffProfile::with(['user', 'contracts', 'payrollComponents.component'])
                    ->whereHas('user', fn ($q) => $q->where('is_active', true))
                    ->whereIn('employment_status', ['active', 'on_leave'])
                    ->where(fn ($q) => $q->whereNull('hire_date')->orWhereDate('hire_date', '<=', $end))
                    ->where(fn ($q) => $q->whereNull('termination_date')->orWhereDate('termination_date', '>=', $start));
                $profiles->where('school_id', $schoolId);

                foreach ($profiles->get() as $profile) {
                    $record = PayrollRecord::create([
                        'school_id' => $schoolId, 'staff_user_id' => $profile->user_id, 'year' => $data['year'], 'month' => $data['month'],
                        'payroll_run_id' => $run->id, 'base_salary' => $profile->base_salary, 'allowances' => 0,
                        'deductions' => 0, 'advance_deduction' => 0, 'net_pay' => $profile->base_salary, 'status' => 'draft',
                    ]);
                    $this->calculator->calculate($record, $profile, $start, $end, false);
                }
                $this->refreshTotals($run);

                return $run;
            });
        } catch (QueryException $e) {
            $message = $e->getMessage();
            $activePeriodConflict = str_contains($message, 'payroll_record_active_school_period_unique')
                || str_contains($message, 'payroll_run_active_school_period_unique')
                || str_contains($message, 'payroll_records.school_id, payroll_records.staff_user_id, payroll_records.year, payroll_records.month')
                || str_contains($message, 'payroll_runs.school_id, payroll_runs.year, payroll_runs.month');
            if (in_array($e->getCode(), ['23000', '23505'], true) && $activePeriodConflict) {
                throw ValidationException::withMessages(['period' => 'An active payroll run or employee record already exists for this school and period.']);
            }
            throw $e;
        }
        AuditLogger::log($request, 'create_payroll_run', 'payroll_run', $run->id, ['new' => $run->toArray()]);

        return response()->json($run->load('records.staff:id,name,role', 'records.components'), 201);
    }

    public function updateRecord(Request $request, int $id)
    {
        $data = $request->validate(['allowances' => 'sometimes|numeric|money|min:0', 'deductions' => 'sometimes|numeric|money|min:0', 'reason' => 'required|string|max:500']);
        $record = DB::transaction(function () use ($request, $id, $data) {
            $record = PayrollRecord::with(['run', 'staff.staffProfile'])->lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $record->school_id);
            if (! $record->run || $record->run->status !== 'draft') {
                abort(422, 'Records can only be adjusted while their run is a draft.');
            }
            $old = $record->toArray();
            $record->fill(collect($data)->only(['allowances', 'deductions'])->all())->save();
            $this->calculator->calculate($record, $record->staff->staffProfile, $record->run->period_start, $record->run->period_end, false);
            $this->refreshTotals($record->run);
            AuditLogger::log($request, 'update_payroll_record', 'payroll_record', $record->id, ['old' => $old, 'new' => $record->fresh()->toArray(), 'reason' => $data['reason']]);

            return $record->fresh(['run', 'components']);
        });

        return response()->json($record);
    }

    public function processRun(Request $request, int $id)
    {
        $run = DB::transaction(function () use ($request, $id) {
            $run = PayrollRun::lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $run->school_id);
            $this->states->assertAllowed($run, 'process');
            foreach ($run->records()->with('staff.staffProfile')->lockForUpdate()->get() as $record) {
                $this->calculator->calculate($record, $record->staff->staffProfile, $run->period_start, $run->period_end, true);
                $record->update(['status' => 'processed']);
            }
            $this->refreshTotals($run);
            $run->update(['status' => 'processed', 'processed_by' => $request->user()->id, 'processed_at' => now()]);

            return $run->fresh('records.components');
        });
        AuditLogger::log($request, 'process_payroll_run', 'payroll_run', $run->id, ['new' => ['status' => 'processed']]);

        return response()->json($run);
    }

    public function approveRun(Request $request, int $id)
    {
        $run = DB::transaction(function () use ($request, $id) {
            $run = PayrollRun::lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $run->school_id);
            $this->states->assertAllowed($run, 'approve');
            // Segregation of duty. Enforced by default; a school with a single
            // finance user may switch it off, which is a business decision
            // recorded in docs/decision-register.md rather than a code change.
            if (config('policy.payroll.creator_cannot_approve', true)
                && ($run->created_by ?? $run->processed_by) === $request->user()->id) {
                abort(422, 'You cannot approve a payroll run you drafted. Another authorised user must review it.');
            }
            $journalId = $this->accounting->postAccrual($run, $request->user()->id);
            $run->records()->update(['status' => 'approved']);
            $run->update(['status' => 'approved', 'approved_by' => $request->user()->id, 'approved_at' => now(), 'accrual_journal_batch_id' => $journalId]);

            return $run->fresh(['records.components', 'accrualJournal.lines']);
        });
        AuditLogger::log($request, 'approve_payroll_run', 'payroll_run', $run->id, ['journal_batch_id' => $run->accrual_journal_batch_id]);

        return response()->json($run);
    }

    public function payRun(Request $request, int $id)
    {
        $run = DB::transaction(function () use ($request, $id) {
            $run = PayrollRun::lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $run->school_id);
            $this->states->assertAllowed($run, 'pay');
            $journalId = $this->accounting->postPayment($run, $request->user()->id);
            $this->accounting->collectReservedAdvances($run);
            $run->records()->update(['status' => 'paid', 'paid_at' => now()]);
            $run->update(['status' => 'paid', 'paid_by' => $request->user()->id, 'paid_at' => now(), 'payment_journal_batch_id' => $journalId]);

            return $run->fresh(['records.components', 'accrualJournal.lines', 'paymentJournal.lines']);
        });
        AuditLogger::log($request, 'pay_payroll_run', 'payroll_run', $run->id, ['total_net' => $run->total_net, 'journal_batch_id' => $run->payment_journal_batch_id]);

        return response()->json($run);
    }

    public function reverseRun(Request $request, int $id)
    {
        $data = $request->validate(['reason' => 'required|string|max:1000']);
        $run = DB::transaction(function () use ($request, $id, $data) {
            $run = PayrollRun::with(['accrualJournal', 'paymentJournal'])->lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $run->school_id);
            $this->states->assertAllowed($run, 'reverse');
            if ($run->paymentJournal) {
                $this->ledger->reverseBatch($run->paymentJournal, $request->user()->id, $data['reason']);
            }
            if ($run->accrualJournal) {
                $this->ledger->reverseBatch($run->accrualJournal, $request->user()->id, $data['reason']);
            }
            $this->accounting->releaseOrRestoreAdvances($run);
            $run->records()->update(['status' => 'reversed']);
            $run->update(['status' => 'reversed', 'reversed_by' => $request->user()->id, 'reversed_at' => now(), 'reversal_reason' => $data['reason']]);

            return $run->fresh(['accrualJournal.lines', 'paymentJournal.lines']);
        });
        AuditLogger::log($request, 'reverse_payroll_run', 'payroll_run', $run->id, ['reason' => $data['reason']]);

        return response()->json($run);
    }

    public function payslip(Request $request, int $recordId)
    {
        $schoolId = $this->schools->forUser($request->user());
        $record = PayrollRecord::where('school_id', $schoolId)->with(['staff.staffProfile', 'run', 'components'])->findOrFail($recordId);

        return Pdf::loadView('pdf.payroll-payslip', ['record' => $record])->setPaper('a4')->stream("payslip-{$record->year}-{$record->month}-{$record->staff_user_id}.pdf");
    }

    private function refreshTotals(PayrollRun $run): void
    {
        $records = $run->records()->get();
        $run->update([
            'total_gross' => number_format($records->sum(fn ($r) => (int) round((float) $r->gross_salary * 100)) / 100, 2, '.', ''),
            'total_deductions' => number_format($records->sum(fn ($r) => (int) round(((float) $r->employee_social_insurance + (float) $r->other_deductions + (float) $r->advance_deduction) * 100)) / 100, 2, '.', ''),
            'total_net' => number_format($records->sum(fn ($r) => (int) round((float) $r->net_pay * 100)) / 100, 2, '.', ''),
        ]);
    }
}
