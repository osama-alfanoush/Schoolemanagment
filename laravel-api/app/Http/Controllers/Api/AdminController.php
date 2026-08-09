<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\AcademicYear;
use App\Models\Announcement;
use App\Models\AttendanceRecord;
use App\Models\AuditLog;
use App\Models\HrRequest;
use App\Models\Invoice;
use App\Models\Permission;
use App\Models\RolePermission;
use App\Models\User;
use App\Models\UserPermission;
use App\Services\AuditLogger;
use App\Services\CurrentSchool;
use App\Services\UserManagementService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class AdminController extends Controller
{
    public function __construct(
        private UserManagementService $users,
        private CurrentSchool $currentSchool,
    ) {}

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
        $data = Cache::remember($this->cacheKey('attendance_dashboard:'.today()->format('Y-m-d')), 120, function () {
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
        $kpis = Cache::remember($this->cacheKey('kpis'), 300, function () {
            return [
                'students' => $this->usersInCurrentSchool()->where('role', 'student')->count(),
                'teachers' => $this->usersInCurrentSchool()->where('role', 'teacher')->count(),
                'staff' => $this->usersInCurrentSchool()->whereIn('role', User::STAFF_ROLES)->count(),
                'academic_year' => AcademicYear::query()
                    ->where('is_current', true)
                    ->orderByDesc('start_date')
                    ->value('name'),
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
            Cache::remember($this->cacheKey('audit_logs'), 60, function () {
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
            Cache::forget($this->cacheKey('kpis'));

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
        Cache::forget($this->cacheKey('kpis'));

        return response()->json($result['data']);
    }

    public function deleteAcademicYear(Request $request, int $id)
    {
        $this->users->deleteAcademicYear($request, $id);
        Cache::forget($this->cacheKey('kpis'));

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

    // ── Granular permissions (procurement / finance sub-modules) ─────

    public function listPermissions()
    {
        return response()->json([
            'data' => Permission::orderBy('module')->orderBy('action')->get()->groupBy('module'),
        ]);
    }

    public function rolePermissions(string $role)
    {
        return response()->json([
            'role' => $role,
            'keys' => Permission::keysForRole($role),
        ]);
    }

    /** Replace a role's grants wholesale with the given permission keys. */
    public function updateRolePermissions(Request $request, string $role)
    {
        if (! in_array($role, User::ROLES, true) || $role === 'admin') {
            return response()->json(['message' => 'Unknown or non-editable role.'], 422);
        }
        $data = $request->validate([
            'keys' => 'present|array',
            'keys.*' => 'string|exists:permissions,key',
        ]);

        $revokedSessions = DB::transaction(function () use ($role, $data) {
            RolePermission::where('role', $role)->delete();
            $ids = Permission::whereIn('key', $data['keys'])->pluck('id');
            foreach ($ids as $id) {
                RolePermission::create(['role' => $role, 'permission_id' => $id]);
            }

            return $this->usersInCurrentSchool()->where('role', $role)->get()->sum(
                fn (User $user) => $user->tokens()->delete()
            );
        });
        Permission::clearRoleCache($role);
        AuditLogger::log($request, 'update_role_permissions', 'role', null, [
            'role' => $role, 'keys' => $data['keys'], 'revoked_session_count' => $revokedSessions,
        ]);

        return response()->json(['role' => $role, 'keys' => Permission::keysForRole($role)]);
    }

    /** A user's permission picture: role baseline, overrides, and the result. */
    public function userPermissions(int $id)
    {
        $user = $this->usersInCurrentSchool()->findOrFail($id);
        $overrides = UserPermission::with('permission:id,key')
            ->where('user_id', $user->id)->get();

        return response()->json([
            'user_id' => $user->id,
            'role' => $user->role,
            'role_keys' => $user->role === 'admin' ? ['*'] : Permission::keysForRole($user->role),
            'grants' => $overrides->where('granted', true)->pluck('permission.key')->values(),
            'denies' => $overrides->where('granted', false)->pluck('permission.key')->values(),
            'effective' => $user->allPermissionKeys(),
        ]);
    }

    /** Per-user grant/deny overrides on top of the role's set. */
    public function updateUserPermissions(Request $request, int $id)
    {
        $user = $this->usersInCurrentSchool()->findOrFail($id);
        $data = $request->validate([
            'grants' => 'present|array',
            'grants.*' => 'string|exists:permissions,key',
            'denies' => 'present|array',
            'denies.*' => 'string|exists:permissions,key',
        ]);

        $revokedSessions = DB::transaction(function () use ($user, $data) {
            UserPermission::where('user_id', $user->id)->delete();
            foreach (['grants' => true, 'denies' => false] as $field => $granted) {
                $ids = Permission::whereIn('key', $data[$field])->pluck('id');
                foreach ($ids as $permId) {
                    UserPermission::create([
                        'user_id' => $user->id, 'permission_id' => $permId, 'granted' => $granted,
                    ]);
                }
            }

            return $user->tokens()->delete();
        });
        AuditLogger::log($request, 'update_user_permissions', 'user', $user->id, $data + [
            'revoked_session_count' => $revokedSessions,
        ]);

        return response()->json([
            'user_id' => $user->id,
            'permissions' => $user->fresh()->allPermissionKeys(),
        ]);
    }

    private function usersInCurrentSchool()
    {
        $schoolId = $this->currentSchool->id();
        $today = now()->toDateString();

        return User::query()->whereHas('schoolRoles', fn ($query) => $query
            ->where('school_id', $schoolId)
            ->where(fn ($dates) => $dates->whereNull('starts_on')->orWhereDate('starts_on', '<=', $today))
            ->where(fn ($dates) => $dates->whereNull('ends_on')->orWhereDate('ends_on', '>=', $today)));
    }

    private function cacheKey(string $suffix): string
    {
        return 'school:'.$this->currentSchool->id().':admin:'.$suffix;
    }
}
