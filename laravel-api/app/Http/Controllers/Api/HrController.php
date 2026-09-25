<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\HrRequest;
use App\Models\JobApplication;
use App\Models\JobPosting;
use App\Models\PerformanceEvaluation;
use App\Models\SocialInsuranceScheme;
use App\Models\StaffAttendance;
use App\Models\StaffProfile;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\Notifier;
use App\Services\SchoolContext;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class HrController extends Controller
{
    private const REQUESTER_ROLES = User::STAFF_ROLES;

    public function __construct(private SchoolContext $schools) {}

    public function myRequests(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());

        return response()->json(
            HrRequest::where('school_id', $schoolId)->where('teacher_user_id', $request->user()->id)
                ->with(['requester:id,name,role', 'reviewer:id,name,role'])
                ->latest()
                ->get()
        );
    }

    public function submitRequest(Request $request)
    {
        if (! in_array($request->user()->role, self::REQUESTER_ROLES, true)) {
            return response()->json(['message' => 'Only staff can submit HR requests.'], 403);
        }

        $data = $request->validate([
            'type' => 'required|in:leave_sick,leave_annual,leave_emergency,salary_advance,general',
            'subject' => 'required|string|max:255',
            'reason' => 'required|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'amount' => 'nullable|numeric|money|min:0',
        ]);
        $schoolId = $this->schools->forUser($request->user());

        $hrRequest = HrRequest::create([
            ...$data,
            'school_id' => $schoolId,
            'teacher_user_id' => $request->user()->id,
            'status' => 'pending',
        ]);

        User::where('role', 'hr')->where('is_active', true)
            ->whereHas('schoolRoles', fn ($q) => $q->where('school_id', $schoolId))
            ->pluck('id')->each(
                fn (int $hrUserId) => Notifier::send(
                    $hrUserId,
                    'hr_request_pending',
                    'New HR request',
                    "{$request->user()->name}: {$hrRequest->subject}",
                    ['request_id' => $hrRequest->id]
                )
            );

        AuditLogger::log($request, 'submit_hr_request', 'hr_request', $hrRequest->id, [
            'type' => $hrRequest->type,
            'subject' => $hrRequest->subject,
        ]);

        return response()->json($hrRequest->load(['requester:id,name,role']), 201);
    }

    public function staff(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = User::whereIn('role', self::REQUESTER_ROLES)->whereHas('staffProfile', fn ($q) => $q->where('school_id', $schoolId))
            ->with(['staffProfile.currentContract', 'staffProfile.supervisor:id,name']);
        if ($r = $request->query('role')) {
            $q->where('role', $r);
        }
        if ($s = $request->query('q')) {
            $q->where('name', 'like', "%$s%");
        }
        if ($status = $request->query('employment_status')) {
            $q->whereRelation('staffProfile', 'employment_status', $status);
        }
        if ($request->boolean('uninsured')) {
            $q->whereRelation('staffProfile', 'social_insurance_registered', false);
        }
        if ($days = $request->integer('contract_expires_within')) {
            $q->whereHas('staffProfile.currentContract', fn ($contract) => $contract->whereBetween('end_date', [now()->toDateString(), now()->addDays($days)->toDateString()]));
        }
        $page = $q->orderBy('name')->paginate($this->perPage($request, 50));
        if (! $request->user()->hasPermission('hr.salary.view')) {
            $page->getCollection()->each(function ($user) {
                $user->staffProfile?->makeHidden(['base_salary', 'bank_account', 'bank_name', 'payment_method']);
                $user->staffProfile?->currentContract?->makeHidden(['base_salary', 'bank_account', 'bank_name', 'payment_method']);
            });
        }

        return response()->json($page);
    }

    public function showStaff(Request $request, int $id)
    {
        $schoolId = $this->schools->forUser($request->user());
        $relations = ['staffProfile.supervisor:id,name', 'staffProfile.contracts.creator:id,name', 'staffProfile.currentContract',
            'staffProfile.payrollComponents.component', 'staffProfile.advances.installments'];
        if ($request->user()->hasPermission('hr.warnings.view')) {
            $relations[] = 'staffProfile.warnings.issuer:id,name';
        }
        $user = User::whereHas('staffProfile', fn ($q) => $q->where('school_id', $schoolId))->with($relations)->findOrFail($id);
        $profile = $user->staffProfile;
        if ($profile?->social_insurance_registered && $profile->social_insurance_scheme_code) {
            $scheme = SocialInsuranceScheme::where('school_id', $schoolId)->where('scheme_code', $profile->social_insurance_scheme_code)
                ->where('is_active', true)->whereDate('effective_from', '<=', now())
                ->where(fn ($q) => $q->whereNull('effective_to')->orWhereDate('effective_to', '>=', now()))
                ->latest('effective_from')->first();
            $user->setAttribute('effective_social_insurance', $scheme ? [
                ...$scheme->only(['id', 'scheme_code', 'name_ar', 'name_en', 'employee_rate', 'employer_rate', 'effective_from']),
                'estimated_insurable_wage' => $profile->base_salary,
                'estimated_employee_amount' => round((float) $profile->base_salary * (float) $scheme->employee_rate / 100, 2),
                'estimated_employer_amount' => round((float) $profile->base_salary * (float) $scheme->employer_rate / 100, 2),
            ] : null);
        }
        if (! $request->user()->hasPermission('hr.salary.view')) {
            $profile?->makeHidden(['base_salary', 'bank_account', 'bank_name', 'payment_method', 'payrollComponents']);
            $profile?->contracts->each->makeHidden(['base_salary', 'bank_account', 'bank_name', 'payment_method']);
            $user->makeHidden('effective_social_insurance');
        }

        return response()->json($user);
    }

    public function updateStaff(Request $request, int $id)
    {
        $schoolId = $this->schools->forUser($request->user());
        $user = User::whereHas('staffProfile', fn ($q) => $q->where('school_id', $schoolId))->with('staffProfile')->findOrFail($id);
        $data = $request->validate([
            'department' => 'sometimes|string', 'position' => 'sometimes|string',
            'hire_date' => 'sometimes|date', 'contract_type' => 'sometimes|string',
            'contract_end' => 'sometimes|date|nullable', 'base_salary' => 'sometimes|numeric|money',
            'qualifications' => 'sometimes|array',
            'annual_leave_balance' => 'sometimes|integer', 'sick_leave_balance' => 'sometimes|integer',
            'employee_no' => ['sometimes', 'nullable', 'string', 'max:100', Rule::unique('staff_profiles')->where('school_id', $schoolId)->ignore($user->staffProfile?->id)],
            'supervisor_user_id' => 'sometimes|nullable|exists:users,id', 'employment_type' => 'sometimes|nullable|string|max:50',
            'employment_status' => 'sometimes|in:active,suspended,on_leave,terminated', 'termination_date' => 'sometimes|nullable|date',
            'contract_start' => 'sometimes|nullable|date', 'probation_days' => 'sometimes|nullable|integer|min:0|max:730',
            'probation_end' => 'sometimes|nullable|date', 'payment_method' => 'sometimes|nullable|string|max:50',
            'bank_name' => 'sometimes|nullable|string|max:100', 'bank_account' => 'sometimes|nullable|string|max:150',
            'social_insurance_registered' => 'sometimes|boolean', 'social_insurance_number' => 'sometimes|nullable|string|max:100',
            'social_insurance_start' => 'sometimes|nullable|date', 'social_insurance_end' => 'sometimes|nullable|date|after_or_equal:social_insurance_start',
            'social_insurance_scheme_code' => 'sometimes|nullable|string|max:50', 'documents' => 'sometimes|nullable|array',
        ]);
        $salaryKeys = ['base_salary', 'payment_method', 'bank_name', 'bank_account', 'social_insurance_registered',
            'social_insurance_number', 'social_insurance_start', 'social_insurance_end', 'social_insurance_scheme_code'];
        abort_if(collect($salaryKeys)->contains(fn ($key) => array_key_exists($key, $data)) && ! $request->user()->hasPermission('hr.salary.edit'), 403);
        if ($user->staffProfile?->contracts()->exists() && (array_key_exists('contract_type', $data) || array_key_exists('contract_end', $data) || array_key_exists('contract_start', $data))) {
            return response()->json(['message' => 'Use the contract renewal endpoint to preserve contract history.'], 422);
        }
        $old = $user->staffProfile?->toArray() ?? [];
        if ($user->staffProfile) {
            $user->staffProfile->update($data);
        } else {
            $user->staffProfile()->create($data);
        }
        AuditLogger::log($request, 'update_staff_profile', 'user', $user->id, ['old' => $old, 'new' => $user->fresh('staffProfile')->staffProfile?->toArray() ?? [], 'reason' => $request->input('reason')]);

        return response()->json($user->fresh(['staffProfile.currentContract', 'staffProfile.supervisor:id,name']));
    }

    public function leaveRequests(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = HrRequest::where('school_id', $schoolId)->whereIn('type', ['leave_sick', 'leave_annual', 'leave_emergency'])
            ->with(['requester:id,name,role', 'teacher:id,name,role', 'reviewer:id,name,role']);
        if ($s = $request->query('status')) {
            $q->where('status', $s);
        }

        return response()->json($q->latest()->paginate(50));
    }

    public function requests(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $q = HrRequest::where('school_id', $schoolId)->with(['requester:id,name,role', 'teacher:id,name,role', 'reviewer:id,name,role']);
        if ($s = $request->query('status')) {
            $q->where('status', $s);
        }
        if ($type = $request->query('type')) {
            $q->where('type', $type);
        }

        return response()->json($q->orderByRaw("case when status = 'pending' then 0 else 1 end")->latest()->paginate(50));
    }

    public function reviewRequest(Request $request, int $id)
    {
        if ($request->user()->role !== 'hr') {
            return response()->json(['message' => 'Only HR can review HR requests.'], 403);
        }

        $data = $request->validate([
            'status' => 'required|in:approved,rejected',
            'response' => 'nullable|string',
            'admin_response' => 'nullable|string',
        ]);

        $hrRequest = HrRequest::findOrFail($id);
        $this->schools->authorize($request->user(), (int) $hrRequest->school_id);
        $response = $data['response'] ?? $data['admin_response'] ?? null;
        $hrRequest->update([
            'status' => $data['status'],
            'admin_response' => $response,
            'reviewed_by' => $request->user()->id,
            'reviewed_at' => now(),
        ]);

        Notifier::send(
            $hrRequest->teacher_user_id,
            'hr_request_'.$data['status'],
            'HR request '.$data['status'],
            $hrRequest->subject,
            ['request_id' => $hrRequest->id]
        );
        AuditLogger::log($request, 'review_hr_request', 'hr_request', $hrRequest->id, [
            'status' => $data['status'],
            'response' => $response,
        ]);

        return response()->json($hrRequest->load(['requester:id,name,role', 'reviewer:id,name,role']));
    }

    public function leaveBalances(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());

        return response()->json(StaffProfile::where('school_id', $schoolId)->with('user:id,name,role')->get(['id', 'school_id', 'user_id', 'annual_leave_balance', 'sick_leave_balance']));
    }

    public function staffAttendance(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'records' => 'required|array',
                'records.*.staff_user_id' => 'required|exists:users,id',
                'records.*.date' => 'required|date',
                'records.*.status' => 'required|in:present,absent,late,leave',
                'records.*.check_in' => 'nullable',
                'records.*.check_out' => 'nullable',
            ]);
            $staffIds = collect($data['records'])->pluck('staff_user_id')->unique();
            abort_unless(StaffProfile::where('school_id', $schoolId)->whereIn('user_id', $staffIds)->count() === $staffIds->count(), 422, 'One or more staff members belong to another school.');
            foreach ($data['records'] as $r) {
                StaffAttendance::updateOrCreate(
                    ['school_id' => $schoolId, 'staff_user_id' => $r['staff_user_id'], 'date' => $r['date']],
                    array_intersect_key($r, array_flip(['status', 'check_in', 'check_out']))
                );
            }
            AuditLogger::log($request, 'mark_staff_attendance', 'staff_attendance', null, ['records' => count($data['records'])]);

            return response()->json(['message' => 'Saved']);
        }
        $month = (int) $request->query('month', now()->month);
        $year = (int) $request->query('year', now()->year);
        $records = StaffAttendance::where('school_id', $schoolId)->whereMonth('date', $month)->whereYear('date', $year)
            ->with('staff:id,name,role')->get();

        return response()->json($records);
    }

    public function staffMonthlyReport(Request $request)
    {
        $schoolId = $this->schools->forUser($request->user());
        $month = (int) $request->query('month', now()->month);
        $year = (int) $request->query('year', now()->year);
        $rows = StaffAttendance::where('school_id', $schoolId)->whereMonth('date', $month)->whereYear('date', $year)
            ->selectRaw('staff_user_id, status, count(*) as count')
            ->groupBy('staff_user_id', 'status')->with('staff:id,name')->get();

        return response()->json($rows);
    }

    // Performance Evaluations
    public function evaluations(Request $request)
    {
        $q = PerformanceEvaluation::with(['staff:id,name', 'evaluator:id,name']);

        if ($staffId = $request->query('staff_id')) {
            $q->where('staff_user_id', $staffId);
        }

        if ($period = $request->query('period')) {
            $q->where('period', $period);
        }

        return response()->json($q->latest('evaluation_date')->paginate(50));
    }

    public function showEvaluation(int $id)
    {
        return response()->json(
            PerformanceEvaluation::with(['staff', 'evaluator', 'reviewer'])->findOrFail($id)
        );
    }

    public function createEvaluation(Request $request)
    {
        $data = $request->validate([
            'staff_user_id' => 'required|exists:users,id',
            'period' => 'required|string',
            'criteria_scores' => 'required|array',
            'criteria_scores.*.criteria' => 'required|string',
            'criteria_scores.*.score' => 'required|integer|between:1,5',
            'overall_score' => 'nullable|numeric|between:1,5',
            'strengths' => 'nullable|string',
            'areas_for_improvement' => 'nullable|string',
            'goals' => 'nullable|string',
            'evaluator_comments' => 'nullable|string',
        ]);

        $evaluation = PerformanceEvaluation::create([
            ...$data,
            'evaluator_id' => $request->user()->id,
            'evaluation_date' => now(),
        ]);

        AuditLogger::log($request, 'create_evaluation', 'performance_evaluation', $evaluation->id, $data);

        return response()->json($evaluation->load(['staff', 'evaluator']), 201);
    }

    // Recruitment
    public function jobs(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'title' => 'required|string',
                'description' => 'required|string',
                'requirements' => 'required|string',
                'department' => 'required|string',
                'position_type' => 'required|in:full-time,part-time,contract',
                'posting_date' => 'required|date',
                'closing_date' => 'nullable|date|after:posting_date',
            ]);

            $job = JobPosting::create([
                ...$data,
                'posted_by' => $request->user()->id,
            ]);

            return response()->json($job, 201);
        }

        $q = JobPosting::query();

        if ($request->query('active_only')) {
            $q->where('status', 'open');
        }

        return response()->json($q->latest()->paginate(50));
    }

    public function applications(Request $request)
    {
        $q = JobApplication::with('jobPosting');

        if ($jobId = $request->query('job_id')) {
            $q->where('job_posting_id', $jobId);
        }

        if ($status = $request->query('status')) {
            $q->where('status', $status);
        }

        return response()->json($q->latest()->paginate(50));
    }

    public function updateApplicationStatus(Request $request, int $id)
    {
        $application = JobApplication::findOrFail($id);

        $data = $request->validate([
            'status' => 'required|in:new,reviewing,interviewed,accepted,rejected',
            'notes' => 'nullable|string',
            'interview_date' => 'nullable|date',
        ]);

        $application->update([
            ...$data,
            'reviewed_by' => $request->user()->id,
        ]);

        return response()->json($application->load('jobPosting'));
    }
}
