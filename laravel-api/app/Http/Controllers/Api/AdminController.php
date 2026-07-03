<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\Announcement;
use App\Models\AttendanceRecord;
use App\Models\AuditLog;
use App\Models\HrRequest;
use App\Models\Invoice;
use App\Models\User;
use App\Services\UserManagementService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class AdminController extends Controller
{
    public function __construct(private UserManagementService $users) {}

    public function listUsers(Request $request)
    {
        $result = $this->users->listUsers($request);

        return response()->json($result);
    }

    public function createUser(Request $request)
    {
        $result = $this->users->createUser($request);

        return response()->json($result['data'], $result['status'] ?? 201);
    }

    public function updateUser(Request $request, int $id)
    {
        $result = $this->users->updateUser($request, $id);

        return response()->json($result['data']);
    }

    public function deactivateUser(Request $request, int $id)
    {
        $this->users->deactivateUser($request, $id);

        return ApiResponse::deleted();
    }

    public function linkParentStudent(Request $request)
    {
        $result = $this->users->linkParentStudent($request);

        return response()->json($result);
    }

    public function bulkImportStudents(Request $request)
    {
        $result = $this->users->bulkImportStudents($request);

        return response()->json($result);
    }

    public function classes(Request $request)
    {
        if ($request->isMethod('post')) {
            $result = $this->users->createClass($request);

            return response()->json($result['data'], $result['status'] ?? 201);
        }
        $result = $this->users->listClasses($request);

        return response()->json($result['data']);
    }

    public function assignSubjectTeacher(Request $request, int $classId)
    {
        $result = $this->users->assignSubjectTeacher($request, $classId);

        return response()->json($result);
    }

    public function timetable(Request $request, int $classId)
    {
        if ($request->isMethod('post')) {
            $result = $this->users->createTimetableEntry($request, $classId);

            return response()->json($result['data'], $result['status'] ?? 201);
        }
        $result = $this->users->listTimetable($request, $classId);

        return response()->json($result['data']);
    }

    public function calendar(Request $request)
    {
        if ($request->isMethod('post')) {
            $result = $this->users->createCalendarEvent($request);

            return response()->json($result['data'], $result['status'] ?? 201);
        }
        $result = $this->users->listCalendar();

        return response()->json($result['data']);
    }

    public function attendanceDashboard(Request $request)
    {
        $data = Cache::remember('admin:attendance_dashboard:'.today()->format('Y-m-d'), 120, function () {
            $today = AttendanceRecord::whereDate('date', today())
                ->select('status')
                ->selectRaw('count(*) as count')
                ->groupBy('status')->pluck('count', 'status');
            $byClass = AttendanceRecord::whereDate('date', today())
                ->select('class_room_id', 'status')
                ->selectRaw('count(*) as count')
                ->groupBy('class_room_id', 'status')->get();

            return ['today' => $today, 'by_class' => $byClass];
        });

        return response()->json($data);
    }

    public function hrRequests(Request $request)
    {
        return response()->json(HrRequest::with('teacher:id,name')->orderBy('status')->latest()->paginate(50));
    }

    public function reviewHrRequest(Request $request, int $id)
    {
        return response()->json(['message' => 'Only HR can review HR requests.'], 403);
    }

    public function dashboardKpis()
    {
        $kpis = Cache::remember('admin:kpis', 300, function () {
            return [
                'students' => User::where('role', 'student')->count(),
                'teachers' => User::where('role', 'teacher')->count(),
                'staff' => User::whereIn('role', ['teacher', 'admin', 'finance', 'hr'])->count(),
                'today_attendance_rate' => $this->todayAttendanceRate(),
                'pending_hr_requests' => HrRequest::where('status', 'pending')->count(),
                'outstanding_fees' => Invoice::whereIn('status', ['pending', 'partial', 'overdue'])->sum(DB::raw('amount - paid_amount')),
            ];
        });

        return ApiResponse::withSummary($kpis, ['generated_at' => now()->toIso8601String()]);
    }

    private function todayAttendanceRate(): float
    {
        $rows = AttendanceRecord::whereDate('date', today())
            ->selectRaw("count(case when status = 'present' then 1 end) as p, count(*) as t")->first();

        return $rows && $rows->t > 0 ? round((float) $rows->p / (float) $rows->t * 100, 2) : 0.0;
    }

    public function announce(Request $request)
    {
        $data = $request->validate([
            'audience' => 'required|string',
            'title' => 'required|string', 'body' => 'required|string',
        ]);
        $a = Announcement::create(array_merge($data, ['sender_user_id' => $request->user()->id]));

        return response()->json($a, 201);
    }

    public function monthlyReport(Request $request)
    {
        $month = (int) $request->query('month', now()->month);
        $year = (int) $request->query('year', now()->year);
        $attn = AttendanceRecord::whereYear('date', $year)->whereMonth('date', $month)
            ->select('status')
            ->selectRaw('count(*) as count')
            ->groupBy('status')->pluck('count', 'status');
        $finance = Invoice::whereYear('created_at', $year)->whereMonth('created_at', $month)
            ->selectRaw('COALESCE(sum(amount), 0) as total, COALESCE(sum(paid_amount), 0) as paid')->first();

        return response()->json([
            'month' => $month, 'year' => $year,
            'attendance' => $attn,
            'finance' => ['billed' => (float) $finance->total, 'collected' => (float) $finance->paid],
            'hr_pending' => HrRequest::where('status', 'pending')->count(),
        ]);
    }

    public function auditLogs()
    {
        return response()->json(
            Cache::remember('admin:audit_logs', 60, function () {
                return AuditLog::with('user:id,name,role')->latest()->paginate(50);
            })
        );
    }

    public function subjects(Request $request)
    {
        if ($request->isMethod('post')) {
            $result = $this->users->createSubject($request);

            return response()->json($result['data'], $result['status'] ?? 201);
        }
        $result = $this->users->listSubjects();

        return response()->json($result['data']);
    }

    public function exams(Request $request)
    {
        if ($request->isMethod('post')) {
            $result = $this->users->createExam($request);

            return response()->json($result['data'], $result['status'] ?? 201);
        }
        $result = $this->users->listExams();

        return response()->json($result['data']);
    }

    public function academicYears(Request $request)
    {
        if ($request->isMethod('post')) {
            $result = $this->users->createAcademicYear($request);

            return response()->json($result['data'], $result['status'] ?? 201);
        }
        $result = $this->users->listAcademicYears();

        return response()->json($result['data']);
    }

    public function getAnnouncements(Request $request)
    {
        $result = $this->users->getAnnouncements($request);

        return response()->json($result['data']);
    }

    public function getSchoolSettings()
    {
        $result = $this->users->getSchoolSettings();

        return response()->json($result['data']);
    }

    public function updateSchoolSettings(Request $request)
    {
        $result = $this->users->updateSchoolSettings($request);

        return response()->json($result['data']);
    }

    // ── Update / Delete: Classes ──────────────────────────────────────

    public function updateClass(Request $request, int $id)
    {
        $result = $this->users->updateClass($request, $id);

        return response()->json($result['data']);
    }

    public function deleteClass(Request $request, int $id)
    {
        $this->users->deleteClass($request, $id);

        return ApiResponse::deleted();
    }

    // ── Update / Delete: Subjects ─────────────────────────────────────

    public function updateSubject(Request $request, int $id)
    {
        $result = $this->users->updateSubject($request, $id);

        return response()->json($result['data']);
    }

    public function deleteSubject(Request $request, int $id)
    {
        $this->users->deleteSubject($request, $id);

        return ApiResponse::deleted();
    }

    // ── Update / Delete: Exams ────────────────────────────────────────

    public function updateExam(Request $request, int $id)
    {
        $result = $this->users->updateExam($request, $id);

        return response()->json($result['data']);
    }

    public function deleteExam(Request $request, int $id)
    {
        $this->users->deleteExam($request, $id);

        return ApiResponse::deleted();
    }

    // ── Update / Delete: Academic Years ───────────────────────────────

    public function updateAcademicYear(Request $request, int $id)
    {
        $result = $this->users->updateAcademicYear($request, $id);

        return response()->json($result['data']);
    }

    public function deleteAcademicYear(Request $request, int $id)
    {
        $this->users->deleteAcademicYear($request, $id);

        return ApiResponse::deleted();
    }

    // ── Delete: Timetable Entry ──────────────────────────────────────

    public function deleteTimetableEntry(Request $request, int $classId, int $id)
    {
        $this->users->deleteTimetableEntry($request, $classId, $id);

        return ApiResponse::deleted();
    }

    // ── Update / Delete: Calendar Events ─────────────────────────────

    public function updateCalendarEvent(Request $request, int $id)
    {
        $result = $this->users->updateCalendarEvent($request, $id);

        return response()->json($result['data']);
    }

    public function deleteCalendarEvent(Request $request, int $id)
    {
        $this->users->deleteCalendarEvent($request, $id);

        return ApiResponse::deleted();
    }

    // ── Delete: Announcements ────────────────────────────────────────

    public function deleteAnnouncement(Request $request, int $id)
    {
        $this->users->deleteAnnouncement($request, $id);

        return ApiResponse::deleted();
    }
}
