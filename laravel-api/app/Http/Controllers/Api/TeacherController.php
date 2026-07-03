<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Responses\ApiResponse;
use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\ClassRoom;
use App\Models\ConductLog;
use App\Models\GradeComponent;
use App\Models\HrRequest;
use App\Models\StudentProfile;
use App\Models\Submission;
use App\Models\TimetableEntry;
use App\Models\User;
use App\Services\AssignmentService;
use App\Services\AttendanceService;
use App\Services\AuditLogger;
use App\Services\GradeService;
use App\Services\Notifier;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Spatie\SimpleExcel\SimpleExcelWriter;

class TeacherController extends Controller
{
    public function __construct(
        private readonly GradeService $grades,
        private readonly AttendanceService $attendance,
        private readonly AssignmentService $assignments,
    ) {}

    /* ---------- AUTHORIZATION HELPERS ---------- */

    protected function teacherCanAccessClassSubject(int $teacherId, int $classRoomId, ?int $subjectId = null): bool
    {
        if (ClassRoom::where('id', $classRoomId)->where('homeroom_teacher_id', $teacherId)->exists()) {
            return true;
        }
        $q = DB::table('class_subject_teacher')
            ->where('class_room_id', $classRoomId)
            ->where('teacher_user_id', $teacherId);
        if ($subjectId !== null) {
            $q->where('subject_id', $subjectId);
        }

        return $q->exists();
    }

    protected function assertCanAccessClassSubject(int $teacherId, int $classRoomId, ?int $subjectId = null): void
    {
        if (! $this->teacherCanAccessClassSubject($teacherId, $classRoomId, $subjectId)) {
            throw new AuthorizationException('You are not assigned to this class/subject.');
        }
    }

    /* ---------- ENDPOINTS ---------- */

    public function myClasses(Request $request)
    {
        $teacherId = $request->user()->id;
        $classes = ClassRoom::whereHas('subjects', function ($q) use ($teacherId) {
            $q->where('class_subject_teacher.teacher_user_id', $teacherId);
        })->orWhere('homeroom_teacher_id', $teacherId)
            ->withCount('students')
            ->with(['subjects' => fn ($q) => $q->wherePivot('teacher_user_id', $teacherId)])
            ->get();

        return ApiResponse::success($classes);
    }

    public function myTimetable(Request $request)
    {
        $entries = TimetableEntry::where('teacher_user_id', $request->user()->id)
            ->with(['classRoom', 'subject'])->orderBy('day_of_week')->orderBy('start_time')->get();

        return ApiResponse::success($entries);
    }

    public function classStudents(Request $request, int $classRoomId)
    {
        $this->assertCanAccessClassSubject($request->user()->id, $classRoomId);
        $students = User::where('role', 'student')
            ->whereHas('studentProfile', fn ($q) => $q->where('class_room_id', $classRoomId))
            ->with('studentProfile')->orderBy('name')->get();

        return response()->json($students);
    }

    public function createAssignment(Request $request)
    {
        $data = $request->validate([
            'class_room_ids' => 'required|array|min:1',
            'class_room_ids.*' => 'integer|exists:class_rooms,id',
            'subject_id' => 'required|integer|exists:subjects,id',
            'title' => 'required|string|max:255',
            'instructions' => 'required|string',
            'due_at' => 'required|date',
            'max_score' => 'nullable|numeric|min:0',
            'attachment' => 'nullable|file|max:20480',
        ]);
        $teacherId = $request->user()->id;
        foreach ($data['class_room_ids'] as $classId) {
            $this->assertCanAccessClassSubject($teacherId, $classId, $data['subject_id']);
        }
        $path = $request->hasFile('attachment') ? $request->file('attachment')->store('assignments') : null;
        $created = $this->assignments->create($data, $teacherId, $path);

        return response()->json($created, 201);
    }

    public function assignmentSubmissions(Request $request, int $assignmentId)
    {
        $a = Assignment::with('classRoom')->findOrFail($assignmentId);
        $teacherId = $request->user()->id;
        if ($a->teacher_user_id !== $teacherId) {
            $this->assertCanAccessClassSubject($teacherId, $a->class_room_id, $a->subject_id);
        }
        $students = User::where('role', 'student')
            ->whereHas('studentProfile', fn ($q) => $q->where('class_room_id', $a->class_room_id))
            ->with(['studentProfile', 'submissions' => fn ($q) => $q->where('assignment_id', $assignmentId)])
            ->get();

        return response()->json(['assignment' => $a, 'students' => $students]);
    }

    public function gradeSubmission(Request $request, int $submissionId)
    {
        $data = $request->validate(['score' => 'required|numeric|min:0', 'feedback' => 'nullable|string']);
        $sub = Submission::with('assignment')->findOrFail($submissionId);
        $teacherId = $request->user()->id;
        if ($sub->assignment->teacher_user_id !== $teacherId) {
            $this->assertCanAccessClassSubject($teacherId, $sub->assignment->class_room_id, $sub->assignment->subject_id);
        }
        if ((float) $data['score'] > (float) $sub->assignment->max_score) {
            return response()->json(['message' => 'Score exceeds assignment max_score'], 422);
        }
        $sub = $this->grades->gradeSubmission($submissionId, $data, $teacherId);

        return response()->json($sub);
    }

    public function markAttendance(Request $request)
    {
        $data = $request->validate([
            'class_room_id' => 'required|exists:class_rooms,id',
            'subject_id' => 'nullable|exists:subjects,id',
            'date' => 'required|date',
            'records' => 'required|array',
            'records.*.student_user_id' => 'required|integer',
            'records.*.status' => 'required|in:present,absent,late,excused',
            'records.*.note' => 'nullable|string',
        ]);
        $teacherId = $request->user()->id;
        $this->assertCanAccessClassSubject($teacherId, $data['class_room_id'], $data['subject_id'] ?? null);

        $this->attendance->markAttendance($data, $teacherId);

        AuditLogger::log($request, 'mark_attendance', 'attendance', $data['class_room_id'], [
            'date' => $data['date'], 'subject_id' => $data['subject_id'] ?? null, 'records' => count($data['records']),
        ]);

        return response()->json(['message' => 'Attendance saved']);
    }

    public function gradeComponents(Request $request, int $classRoomId, int $subjectId)
    {
        $this->assertCanAccessClassSubject($request->user()->id, $classRoomId, $subjectId);
        if ($request->isMethod('post')) {
            $data = $request->validate([
                'name' => 'required|string',
                'type' => 'required|in:quiz,homework,exam',
                'weight' => 'required|numeric',
                'max_score' => 'required|numeric',
                'semester_id' => 'nullable|exists:semesters,id',
            ]);
            $c = $this->grades->createComponent($data, $classRoomId, $subjectId);

            return response()->json($c, 201);
        }
        $components = $this->grades->gradeComponents($classRoomId, $subjectId);

        return response()->json($components);
    }

    public function enterGrade(Request $request)
    {
        $data = $request->validate([
            'student_user_id' => 'required|exists:users,id',
            'grade_component_id' => 'required|exists:grade_components,id',
            'score' => 'required|numeric|min:0',
        ]);
        $component = GradeComponent::findOrFail($data['grade_component_id']);
        $teacherId = $request->user()->id;
        $this->assertCanAccessClassSubject($teacherId, $component->class_room_id, $component->subject_id);
        if (! StudentProfile::where('user_id', $data['student_user_id'])
            ->where('class_room_id', $component->class_room_id)->exists()) {
            return response()->json(['message' => 'Student is not in this class.'], 422);
        }
        if ((float) $data['score'] > (float) $component->max_score) {
            return response()->json(['message' => 'Score exceeds component max_score'], 422);
        }
        $g = $this->grades->enter($data, $teacherId);

        return response()->json($g);
    }

    public function logConduct(Request $request)
    {
        $data = $request->validate([
            'student_user_id' => 'required|exists:users,id',
            'category' => 'required|in:positive,warning,incident',
            'title' => 'required|string',
            'note' => 'required|string',
        ]);
        $teacherId = $request->user()->id;
        $studentClass = StudentProfile::where('user_id', $data['student_user_id'])->value('class_room_id');
        if (! $studentClass || ! $this->teacherCanAccessClassSubject($teacherId, $studentClass)) {
            return response()->json(['message' => 'You may not log conduct for this student.'], 403);
        }
        $log = ConductLog::create(array_merge($data, ['teacher_user_id' => $teacherId]));
        $parentIds = DB::table('parent_student')->where('student_user_id', $data['student_user_id'])->pluck('parent_user_id');
        foreach ($parentIds as $pid) {
            Notifier::send($pid, 'conduct', "Conduct note: {$data['category']}", $data['title']);
        }

        return response()->json($log, 201);
    }

    public function announce(Request $request)
    {
        $data = $request->validate([
            'class_room_id' => 'required|exists:class_rooms,id',
            'title' => 'required|string',
            'body' => 'required|string',
        ]);
        $this->assertCanAccessClassSubject($request->user()->id, $data['class_room_id']);
        $a = Announcement::create([
            'sender_user_id' => $request->user()->id,
            'audience' => "class:{$data['class_room_id']}",
            'title' => $data['title'],
            'body' => $data['body'],
        ]);

        return response()->json($a, 201);
    }

    public function submitHrRequest(Request $request)
    {
        $data = $request->validate([
            'type' => 'required|in:leave_sick,leave_annual,leave_emergency,salary_advance,general',
            'subject' => 'required|string',
            'reason' => 'required|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'amount' => 'nullable|numeric|min:0',
        ]);
        $r = HrRequest::create(array_merge($data, ['teacher_user_id' => $request->user()->id]));

        return response()->json($r, 201);
    }

    public function myHrRequests(Request $request)
    {
        return response()->json(HrRequest::where('teacher_user_id', $request->user()->id)->latest()->get());
    }

    public function exportGrades(Request $request)
    {
        $data = $request->validate([
            'class_room_id' => 'required|integer|exists:class_rooms,id',
            'subject_id' => 'required|integer|exists:subjects,id',
            'format' => 'required|in:pdf,excel',
        ]);

        $teacherId = $request->user()->id;
        $this->assertCanAccessClassSubject($teacherId, $data['class_room_id'], $data['subject_id']);

        $exportData = $this->grades->exportGrades($data['class_room_id'], $data['subject_id']);

        if ($data['format'] === 'pdf') {
            $pdf = Pdf::loadView('reports.teacher-grades', $exportData);

            return $pdf->download("grades-{$data['class_room_id']}-{$data['subject_id']}.pdf");
        }

        $filename = "grades-{$data['class_room_id']}-{$data['subject_id']}.xlsx";
        $path = storage_path('app/'.$filename);

        $header = array_merge(['Student Name', 'Admission No'], $exportData['componentNames'], ['Total %']);
        $writer = SimpleExcelWriter::create($path);
        $writer->addRow($header);
        foreach ($exportData['rows'] as $r) {
            $dataRow = array_merge(
                [$r['name'], $r['admission_no']],
                array_map(fn ($name) => $r[$name] ?? '', $exportData['componentNames']),
                [$r['total_pct'] ?? '']
            );
            $writer->addRow($dataRow);
        }
        $writer->close();

        return response()->download($path, $filename)->deleteFileAfterSend();
    }

    public function getAnnouncements(Request $request)
    {
        $announcements = Announcement::where('sender_user_id', auth()->id())
            ->latest()
            ->paginate($request->per_page ?? 20);

        return response()->json($announcements);
    }
}
