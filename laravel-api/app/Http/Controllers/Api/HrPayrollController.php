<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\DisciplinaryWarning;
use App\Models\EmployeeAdvance;
use App\Models\EmployeeContract;
use App\Models\PayrollRecord;
use App\Models\PayrollRun;
use App\Models\StaffProfile;
use App\Services\AuditLogger;
use App\Services\EmployeeAdvanceService;
use App\Services\EmployeeContractService;
use App\Services\Notifier;
use App\Services\SchoolContext;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class HrPayrollController extends Controller
{
    public function __construct(
        private EmployeeContractService $contracts,
        private EmployeeAdvanceService $advances,
        private SchoolContext $schools,
    ) {}

    public function dashboard(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $today = now()->toDateString();

        return response()->json([
            'active_staff' => StaffProfile::where('school_id', $schoolId)->where('employment_status', 'active')->count(),
            'terminated_staff' => StaffProfile::where('school_id', $schoolId)->where('employment_status', 'terminated')->count(),
            'contracts_expiring_soon' => EmployeeContract::where('school_id', $schoolId)->where('is_current', true)->whereBetween('end_date', [$today, now()->addDays(30)->toDateString()])->count(),
            'expired_contracts' => EmployeeContract::where('school_id', $schoolId)->where('is_current', true)->whereDate('end_date', '<', $today)->count(),
            'uninsured_staff' => StaffProfile::where('school_id', $schoolId)->where('employment_status', 'active')->where('social_insurance_registered', false)->count(),
            'pending_advances' => EmployeeAdvance::where('school_id', $schoolId)->where('status', 'requested')->count(),
            'pending_warnings' => DisciplinaryWarning::where('school_id', $schoolId)->where('status', 'pending_approval')->count(),
            'current_payroll_run' => PayrollRun::where('school_id', $schoolId)->where('year', now()->year)->where('month', now()->month)->latest()->first(),
            'expiring_contracts' => EmployeeContract::with('staffProfile.user:id,name')->where('school_id', $schoolId)->where('is_current', true)
                ->whereBetween('end_date', [$today, now()->addDays(90)->toDateString()])->orderBy('end_date')->limit(10)->get(),
        ]);
    }

    public function contracts(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = EmployeeContract::where('school_id', $schoolId)->with(['staffProfile.user:id,name,email', 'renewedFrom:id,contract_no']);
        if ($staff = $request->integer('staff_profile_id')) {
            $q->where('staff_profile_id', $staff);
        }
        if ($days = $request->integer('expiring_within')) {
            $q->whereBetween('end_date', [now()->toDateString(), now()->addDays($days)->toDateString()]);
        }
        if ($status = $request->query('status')) {
            if ($status === 'expired') {
                $q->whereDate('end_date', '<', now());
            } elseif ($status === 'indefinite') {
                $q->whereNull('end_date');
            } else {
                $q->where('status', $status);
            }
        }
        if ($term = $request->query('q')) {
            $q->where(fn ($query) => $query->where('contract_no', 'like', "%{$term}%")
                ->orWhereHas('staffProfile.user', fn ($user) => $user->where('name', 'like', "%{$term}%")));
        }

        return response()->json($q->orderByRaw('case when end_date is null then 1 else 0 end')->orderBy('end_date')
            ->paginate($this->perPage($request, 20)));
    }

    public function contractHistory(Request $request, int $userId)
    {
        $schoolId = $this->schools->forUser($request->user());
        $profile = StaffProfile::where('school_id', $schoolId)->where('user_id', $userId)->firstOrFail();

        return response()->json([
            'employment' => $profile->only(['hire_date', 'termination_date', 'employment_status']),
            'contracts' => $profile->contracts()->with('creator:id,name')->get(),
        ]);
    }

    public function storeContract(Request $request, int $userId)
    {
        $schoolId = $this->schools->forUser($request->user());
        $profile = StaffProfile::where('school_id', $schoolId)->where('user_id', $userId)->firstOrFail();
        $data = $this->contractData($request);
        $allowOverlap = $request->boolean('allow_overlap') && $request->user()->role === 'admin' && filled($request->input('overlap_reason'));
        $contract = $this->contracts->createOrRenew($profile, $data, $request->user()->id, null, $allowOverlap);
        AuditLogger::log($request, 'create_employee_contract', 'employee_contract', $contract->id, ['new' => $contract->toArray(), 'overlap_reason' => $request->input('overlap_reason')]);

        return response()->json($contract, 201);
    }

    public function renewContract(Request $request, int $id)
    {
        $old = EmployeeContract::with('staffProfile')->findOrFail($id);
        $this->schools->authorize($request->user(), (int) $old->school_id);
        $data = $this->contractData($request);
        $contract = $this->contracts->createOrRenew($old->staffProfile, $data, $request->user()->id, $old);
        AuditLogger::log($request, 'renew_employee_contract', 'employee_contract', $contract->id, ['old_contract_id' => $old->id, 'new' => $contract->toArray()]);

        return response()->json($contract, 201);
    }

    public function warnings(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = DisciplinaryWarning::where('school_id', $schoolId)->with(['staffProfile.user:id,name', 'issuer:id,name', 'approver:id,name']);
        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }
        if ($staff = $request->integer('staff_profile_id')) {
            $q->where('staff_profile_id', $staff);
        }

        return response()->json($q->latest('issued_date')->paginate($this->perPage($request, 20)));
    }

    public function showWarning(Request $request, int $id)
    {
        $schoolId = $this->schools->forUser($request->user());

        return response()->json(DisciplinaryWarning::where('school_id', $schoolId)->with(['staffProfile.user:id,name', 'issuer:id,name', 'approver:id,name'])->findOrFail($id));
    }

    public function storeWarning(Request $request)
    {
        $data = $request->validate([
            'staff_profile_id' => 'required|exists:staff_profiles,id', 'warning_type' => 'required|string|max:100',
            'offence' => 'required|string|max:255', 'incident_description' => 'required|string',
            'incident_date' => 'required|date', 'issued_date' => 'required|date', 'level' => 'required|string|max:50',
            'attachments' => 'nullable|array', 'effect_expires_at' => 'nullable|date',
            'previous_warning_id' => 'nullable|exists:disciplinary_warnings,id',
        ]);
        $schoolId = $this->schools->forUser($request->user());
        abort_unless(StaffProfile::where('school_id', $schoolId)->whereKey($data['staff_profile_id'])->exists(), 422, 'The employee belongs to another school.');
        if (! empty($data['previous_warning_id'])) {
            abort_unless(DisciplinaryWarning::where('school_id', $schoolId)->whereKey($data['previous_warning_id'])->exists(), 422, 'The previous warning belongs to another school.');
        }
        $warning = DisciplinaryWarning::create([...$data, 'school_id' => $schoolId, 'warning_no' => 'WRN-'.now()->format('Y').'-'.strtoupper(str()->random(6)), 'issued_by' => $request->user()->id, 'status' => 'draft']);
        AuditLogger::log($request, 'create_disciplinary_warning', 'disciplinary_warning', $warning->id, ['new' => $warning->toArray()]);

        return response()->json($warning->load('staffProfile.user:id,name'), 201);
    }

    public function transitionWarning(Request $request, int $id, string $action)
    {
        $allowed = [
            'submit' => ['draft', 'pending_approval'], 'approve' => ['pending_approval', 'issued'],
            'receive' => ['issued', 'received'], 'object' => ['issued', 'objected'], 'cancel' => [null, 'cancelled'],
        ];
        abort_unless(isset($allowed[$action]), 404);

        return DB::transaction(function () use ($request, $id, $action, $allowed) {
            $warning = DisciplinaryWarning::lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $warning->school_id);
            [$from, $to] = $allowed[$action];
            if ($from !== null && $warning->status !== $from) {
                abort(422, "Warning cannot be {$action} from {$warning->status}.");
            }
            if ($action === 'approve' && $warning->issued_by === $request->user()->id) {
                abort(422, 'The issuer cannot approve the same warning.');
            }
            $old = $warning->toArray();
            $changes = ['status' => $to];
            if ($action === 'approve') {
                $changes += ['approved_by' => $request->user()->id, 'approved_at' => now()];
            }
            if ($action === 'receive') {
                $changes['received_at'] = now();
            }
            if ($action === 'object') {
                $changes['employee_comments'] = $request->validate(['employee_comments' => 'required|string'])['employee_comments'];
            }
            if ($action === 'cancel') {
                $changes['cancellation_reason'] = $request->validate(['reason' => 'required|string'])['reason'];
            }
            $warning->update($changes);
            Notifier::send($warning->staffProfile->user_id, 'disciplinary_warning_'.$action, 'تحديث إنذار وظيفي', "تم تحديث الإنذار {$warning->warning_no} إلى {$to}", ['warning_id' => $warning->id]);
            AuditLogger::log($request, $action.'_disciplinary_warning', 'disciplinary_warning', $warning->id, ['old' => $old, 'new' => $warning->fresh()->toArray()]);

            return response()->json($warning->fresh());
        });
    }

    public function advances(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = EmployeeAdvance::where('school_id', $schoolId)->with(['staffProfile.user:id,name', 'installments']);
        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }
        if ($staff = $request->integer('staff_profile_id')) {
            $q->where('staff_profile_id', $staff);
        }

        return response()->json($q->latest()->paginate($this->perPage($request, 20)));
    }

    public function showAdvance(Request $request, int $id)
    {
        $schoolId = $this->schools->forUser($request->user());

        return response()->json(EmployeeAdvance::where('school_id', $schoolId)->with(['staffProfile.user:id,name', 'installments.payrollRecord'])->findOrFail($id));
    }

    public function storeAdvance(Request $request)
    {
        $data = $request->validate([
            'staff_profile_id' => 'required|exists:staff_profiles,id', 'original_amount' => 'required|numeric|money|min:0.01',
            'reason' => 'required|string', 'requested_at' => 'required|date', 'installment_count' => 'required|integer|min:1|max:120',
            'first_deduction_month' => 'required|date', 'receivable_account_code' => 'nullable|string|max:50',
            'cash_account_code' => 'nullable|string|max:50', 'attachments' => 'nullable|array', 'notes' => 'nullable|string',
        ]);
        $schoolId = $this->schools->forUser($request->user());
        abort_unless(StaffProfile::where('school_id', $schoolId)->whereKey($data['staff_profile_id'])->exists(), 422, 'The employee belongs to another school.');
        $totalCents = (int) round($data['original_amount'] * 100);
        $regularCents = intdiv($totalCents, $data['installment_count']);
        $advance = EmployeeAdvance::create([
            ...$data, 'school_id' => $schoolId, 'advance_no' => 'ADV-'.now()->format('Y').'-'.strtoupper(str()->random(6)),
            'remaining_balance' => $data['original_amount'], 'installment_amount' => $regularCents / 100,
            'requested_by' => $request->user()->id, 'status' => 'draft',
        ]);
        AuditLogger::log($request, 'create_employee_advance', 'employee_advance', $advance->id, ['new' => $advance->toArray()]);

        return response()->json($advance, 201);
    }

    public function submitAdvance(Request $request, int $id)
    {
        $advance = EmployeeAdvance::where('status', 'draft')->findOrFail($id);
        $this->schools->authorize($request->user(), (int) $advance->school_id);
        $advance->update(['status' => 'requested']);
        AuditLogger::log($request, 'request_employee_advance', 'employee_advance', $advance->id, ['old' => ['status' => 'draft'], 'new' => ['status' => 'requested']]);

        return response()->json($advance);
    }

    public function approveAdvance(Request $request, int $id)
    {
        $advance = EmployeeAdvance::findOrFail($id);
        $this->schools->authorize($request->user(), (int) $advance->school_id);

        return response()->json($this->advances->approve($request, $advance));
    }

    public function disburseAdvance(Request $request, int $id)
    {
        $data = $request->validate(['method' => 'required|string|max:50']);

        $advance = EmployeeAdvance::findOrFail($id);
        $this->schools->authorize($request->user(), (int) $advance->school_id);

        return response()->json($this->advances->disburse($request, $advance, $data['method']));
    }

    public function settleAdvance(Request $request, int $id)
    {
        $data = $request->validate(['method' => 'required|string|max:50']);

        $advance = EmployeeAdvance::findOrFail($id);
        $this->schools->authorize($request->user(), (int) $advance->school_id);

        return response()->json($this->advances->settle($request, $advance, $data['method']));
    }

    public function rejectAdvance(Request $request, int $id)
    {
        $data = $request->validate(['reason' => 'required|string|max:1000']);
        $advance = EmployeeAdvance::where('status', 'requested')->findOrFail($id);
        $this->schools->authorize($request->user(), (int) $advance->school_id);
        $advance->update(['status' => 'rejected', 'closure_reason' => $data['reason']]);
        AuditLogger::log($request, 'reject_employee_advance', 'employee_advance', $advance->id, ['old' => ['status' => 'requested'], 'new' => ['status' => 'rejected'], 'reason' => $data['reason']]);

        return response()->json($advance);
    }

    public function cancelAdvance(Request $request, int $id)
    {
        $data = $request->validate(['reason' => 'required|string|max:1000']);
        $advance = EmployeeAdvance::whereIn('status', ['draft', 'requested', 'approved'])->findOrFail($id);
        $this->schools->authorize($request->user(), (int) $advance->school_id);
        $advance->installments()->delete();
        $advance->update(['status' => 'cancelled', 'closure_reason' => $data['reason']]);
        AuditLogger::log($request, 'cancel_employee_advance', 'employee_advance', $advance->id, ['new' => ['status' => 'cancelled'], 'reason' => $data['reason']]);

        return response()->json($advance);
    }

    public function rescheduleAdvance(Request $request, int $id)
    {
        $data = $request->validate(['installment_count' => 'required|integer|min:1|max:120', 'first_deduction_month' => 'required|date', 'reason' => 'required|string|max:1000']);
        $advance = DB::transaction(function () use ($request, $id, $data) {
            $advance = EmployeeAdvance::with('installments')->lockForUpdate()->findOrFail($id);
            $this->schools->authorize($request->user(), (int) $advance->school_id);
            abort_unless(in_array($advance->status, ['disbursed', 'active'], true), 422, 'Only a disbursed or active advance can be rescheduled.');
            abort_if($advance->installments->contains('status', 'reserved'), 422, 'A payroll run currently reserves an installment; reverse or complete that run first.');
            $advance->installments()->whereIn('status', ['due', 'overdue'])->delete();
            $offset = (int) $advance->installments()->max('installment_no');
            $remaining = (int) round((float) $advance->remaining_balance * 100);
            $regular = intdiv($remaining, $data['installment_count']);
            $date = Carbon::parse($data['first_deduction_month'])->startOfMonth();
            for ($i = 1; $i <= $data['installment_count']; $i++) {
                $amount = $i === $data['installment_count'] ? $remaining : $regular;
                $advance->installments()->create(['school_id' => $advance->school_id, 'installment_no' => $offset + $i, 'due_date' => $date->copy()->addMonthsNoOverflow($i - 1)->endOfMonth(), 'amount' => $amount / 100, 'status' => 'due']);
                $remaining -= $amount;
            }
            $advance->update(['installment_count' => $offset + $data['installment_count'], 'installment_amount' => $regular / 100, 'first_deduction_month' => $data['first_deduction_month'], 'notes' => trim(($advance->notes ? $advance->notes."\n" : '').'Rescheduled: '.$data['reason'])]);
            AuditLogger::log($request, 'reschedule_employee_advance', 'employee_advance', $advance->id, ['new_installment_count' => $data['installment_count'], 'reason' => $data['reason']]);

            return $advance->fresh('installments');
        });

        return response()->json($advance);
    }

    public function report(Request $request, string $type)
    {
        $perPage = $this->perPage($request, 25);
        $schoolId = $this->schools->forUser($request->user());

        return match ($type) {
            'contracts' => $this->contracts($request),
            'warnings' => $this->warnings($request),
            'advances' => $this->advances($request),
            'uninsured' => response()->json(StaffProfile::with('user:id,name,email')->where('school_id', $schoolId)->where('employment_status', 'active')->where('social_insurance_registered', false)->paginate($perPage)),
            'payroll' => response()->json(PayrollRun::where('school_id', $schoolId)->withCount('records')->orderByDesc('year')->orderByDesc('month')->paginate($perPage)),
            'payroll-reconciliation' => response()->json(PayrollRun::where('school_id', $schoolId)
                ->when($request->integer('run_id'), fn ($q, $runId) => $q->whereKey($runId))
                ->with(['accrualJournal.lines', 'paymentJournal.lines'])->whereIn('status', ['approved', 'paid', 'reversed'])
                ->orderByDesc('year')->orderByDesc('month')->paginate($perPage)),
            'payroll-detail', 'social-insurance', 'components', 'employee-cost' => $this->payrollRecordReport($request, $type, $perPage),
            default => abort(404),
        };
    }

    private function payrollRecordReport(Request $request, string $type, int $perPage)
    {
        $schoolId = $this->schools->forUser($request->user());
        $query = PayrollRecord::query()->where('school_id', $schoolId)->with(['staff:id,name,email', 'staff.staffProfile:id,user_id,employee_no,department,school_id']);
        if ($type === 'components') {
            $query->with('components');
        }
        foreach (['year', 'month'] as $field) {
            if ($value = $request->integer($field)) {
                $query->where($field, $value);
            }
        }
        if ($department = $request->query('department')) {
            $query->whereHas('staff.staffProfile', fn ($profile) => $profile->where('department', $department));
        }

        $paginator = $query->orderByDesc('year')->orderByDesc('month')->orderBy('staff_user_id')->paginate($perPage);
        $paginator->setCollection($paginator->getCollection()->map(function (PayrollRecord $record) use ($type) {
            $profile = $record->staff?->staffProfile;
            $row = [
                'id' => $record->id,
                'year' => $record->year,
                'month' => $record->month,
                'employee_no' => $profile?->employee_no,
                'employee_name' => $record->staff?->name,
                'department' => $profile?->department,
                'school_id' => $profile?->school_id,
                'status' => $record->status,
            ];

            return match ($type) {
                'social-insurance' => $row + [
                    'insurable_wage' => $record->insurable_wage,
                    'employee_social_insurance' => $record->employee_social_insurance,
                    'employer_social_insurance' => $record->employer_social_insurance,
                ],
                'components' => $row + [
                    'base_salary' => $record->base_salary,
                    'total_earnings' => $record->total_earnings,
                    'other_deductions' => $record->other_deductions,
                    'component_breakdown' => $record->components->map(fn ($component) => [
                        'code' => $component->component_code,
                        'name' => $component->name_ar,
                        'category' => $component->category,
                        'amount' => $component->amount,
                    ])->values(),
                ],
                'employee-cost' => $row + [
                    'gross_salary' => $record->gross_salary,
                    'employer_social_insurance' => $record->employer_social_insurance,
                    'employer_contributions' => $record->employer_contributions,
                    'employer_cost' => $record->employer_cost,
                ],
                default => $row + [
                    'base_salary' => $record->base_salary,
                    'total_earnings' => $record->total_earnings,
                    'gross_salary' => $record->gross_salary,
                    'employee_social_insurance' => $record->employee_social_insurance,
                    'other_deductions' => $record->other_deductions,
                    'advance_deduction' => $record->advance_deduction,
                    'net_pay' => $record->net_pay,
                    'employer_cost' => $record->employer_cost,
                ],
            };
        }));

        return response()->json($paginator);
    }

    private function contractData(Request $request): array
    {
        $schoolId = $this->schools->forUser($request->user());

        return $request->validate([
            'contract_no' => ['required', 'string', 'max:100', Rule::unique('employee_contracts')->where('school_id', $schoolId)],
            'contract_type' => 'required|in:fixed_term,indefinite', 'start_date' => 'required|date',
            'end_date' => 'nullable|required_if:contract_type,fixed_term|date|after_or_equal:start_date',
            'probation_days' => 'nullable|integer|min:0|max:730', 'probation_end' => 'nullable|date|after_or_equal:start_date',
            'base_salary' => 'required|numeric|money|min:0', 'payment_method' => 'nullable|string|max:50',
            'bank_name' => 'nullable|string|max:100', 'bank_account' => 'nullable|string|max:150',
            'attachments' => 'nullable|array', 'notes' => 'nullable|string', 'is_current' => 'sometimes|boolean',
        ]);
    }
}
