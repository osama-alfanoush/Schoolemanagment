<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\HrRequest;
use App\Models\JobApplication;
use App\Models\JobPosting;
use App\Models\PerformanceEvaluation;
use App\Models\StaffAttendance;
use App\Models\StaffProfile;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\Notifier;
use Illuminate\Http\Request;

class HrController extends Controller
{
    private const REQUESTER_ROLES = ['teacher', 'admin', 'finance', 'hr', 'warehouse'];

    public function myRequests(Request $request)
    {
        return response()->json(
            HrRequest::where('teacher_user_id', $request->user()->id)
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
            'amount' => 'nullable|numeric|min:0',
        ]);

        $hrRequest = HrRequest::create([
            ...$data,
            'teacher_user_id' => $request->user()->id,
            'status' => 'pending',
        ]);

        User::where('role', 'hr')->where('is_active', true)->pluck('id')->each(
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
        $q = User::whereIn('role', self::REQUESTER_ROLES)->with('staffProfile');
        if ($r = $request->query('role')) {
            $q->where('role', $r);
        }
        if ($s = $request->query('q')) {
            $q->where('name', 'ilike', "%$s%");
        }

        return response()->json($q->orderBy('name')->paginate(50));
    }

    public function showStaff(int $id)
    {
        return response()->json(User::with('staffProfile')->findOrFail($id));
    }

    public function updateStaff(Request $request, int $id)
    {
        $user = User::with('staffProfile')->findOrFail($id);
        $data = $request->validate([
            'department' => 'sometimes|string', 'position' => 'sometimes|string',
            'hire_date' => 'sometimes|date', 'contract_type' => 'sometimes|string',
            'contract_end' => 'sometimes|date|nullable', 'base_salary' => 'sometimes|numeric',
            'qualifications' => 'sometimes|array',
            'annual_leave_balance' => 'sometimes|integer', 'sick_leave_balance' => 'sometimes|integer',
        ]);
        if ($user->staffProfile) {
            $user->staffProfile->update($data);
        } else {
            $user->staffProfile()->create($data);
        }
        AuditLogger::log($request, 'update_staff_profile', 'user', $user->id, $data);

        return response()->json($user->fresh('staffProfile'));
    }

    public function leaveRequests(Request $request)
    {
        $q = HrRequest::whereIn('type', ['leave_sick', 'leave_annual', 'leave_emergency'])
            ->with(['requester:id,name,role', 'teacher:id,name,role', 'reviewer:id,name,role']);
        if ($s = $request->query('status')) {
            $q->where('status', $s);
        }

        return response()->json($q->latest()->paginate(50));
    }

    public function requests(Request $request)
    {
        $q = HrRequest::with(['requester:id,name,role', 'teacher:id,name,role', 'reviewer:id,name,role']);
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

    public function leaveBalances()
    {
        return response()->json(StaffProfile::with('user:id,name,role')->get(['id', 'user_id', 'annual_leave_balance', 'sick_leave_balance']));
    }

    public function staffAttendance(Request $request)
    {
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'records' => 'required|array',
                'records.*.staff_user_id' => 'required|exists:users,id',
                'records.*.date' => 'required|date',
                'records.*.status' => 'required|in:present,absent,late,leave',
                'records.*.check_in' => 'nullable',
                'records.*.check_out' => 'nullable',
            ]);
            foreach ($data['records'] as $r) {
                StaffAttendance::updateOrCreate(
                    ['staff_user_id' => $r['staff_user_id'], 'date' => $r['date']],
                    array_intersect_key($r, array_flip(['status', 'check_in', 'check_out']))
                );
            }
            AuditLogger::log($request, 'mark_staff_attendance', 'staff_attendance', null, ['records' => count($data['records'])]);

            return response()->json(['message' => 'Saved']);
        }
        $month = (int) $request->query('month', now()->month);
        $year = (int) $request->query('year', now()->year);
        $records = StaffAttendance::whereMonth('date', $month)->whereYear('date', $year)
            ->with('staff:id,name,role')->get();

        return response()->json($records);
    }

    public function staffMonthlyReport(Request $request)
    {
        $month = (int) $request->query('month', now()->month);
        $year = (int) $request->query('year', now()->year);
        $rows = StaffAttendance::whereMonth('date', $month)->whereYear('date', $year)
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
