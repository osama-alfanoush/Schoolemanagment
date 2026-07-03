<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\CalendarEvent;
use App\Models\Grade;
use App\Models\StudentProfile;
use App\Models\Submission;
use App\Models\TimetableEntry;
use App\Services\PerformanceChartService;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class StudentController extends Controller
{
    public function dashboard(Request $request)
    {
        $student = $request->user();
        $classId = $student->studentProfile?->class_room_id;
        $upcoming = $classId ? Assignment::where('class_room_id', $classId)
            ->where('due_at', '>=', now())->orderBy('due_at')->limit(5)->with('subject')->get() : collect();
        $recentGrades = Grade::where('student_user_id', $student->id)->latest()->limit(5)->with('component.subject')->get();
        $today = AttendanceRecord::where('student_user_id', $student->id)->whereDate('date', today())->first();

        return response()->json([
            'upcoming_assignments' => $upcoming,
            'recent_grades' => $recentGrades,
            'today_attendance' => $today,
        ]);
    }

    public function timetable(Request $request)
    {
        $classId = $request->user()->studentProfile?->class_room_id;
        $entries = TimetableEntry::where('class_room_id', $classId)
            ->with(['subject', 'teacher:id,name'])->orderBy('day_of_week')->orderBy('start_time')->get();

        return response()->json($entries);
    }

    public function assignments(Request $request)
    {
        $classId = $request->user()->studentProfile?->class_room_id;
        $assignments = Assignment::where('class_room_id', $classId)
            ->with(['subject', 'teacher:id,name', 'submissions' => function ($q) use ($request) {
                $q->where('student_user_id', $request->user()->id);
            }])
            ->orderBy('due_at', 'desc')->paginate(20);

        return response()->json($assignments);
    }

    public function submitAssignment(Request $request, int $assignmentId)
    {
        $assignment = Assignment::findOrFail($assignmentId);
        $student = $request->user();
        if ($student->studentProfile?->class_room_id !== $assignment->class_room_id) {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $data = $request->validate([
            'content_text' => 'nullable|string',
            'file' => 'nullable|file|max:20480',
        ]);
        $filePath = null;
        if ($request->hasFile('file')) {
            $filePath = $request->file('file')->store("submissions/{$assignmentId}");
        }
        $status = now()->greaterThan($assignment->due_at) ? 'late' : 'submitted';
        $submission = Submission::updateOrCreate(
            ['assignment_id' => $assignmentId, 'student_user_id' => $student->id],
            [
                'content_text' => $data['content_text'] ?? null,
                'file_path' => $filePath ?? null,
                'submitted_at' => now(),
                'status' => $status,
            ]
        );

        return response()->json($submission, 201);
    }

    public function grades(Request $request)
    {
        $grades = Grade::where('student_user_id', $request->user()->id)
            ->with('component.subject')->orderBy('created_at', 'desc')->get();
        // Group per subject + compute weighted averages
        $bySubject = [];
        foreach ($grades as $g) {
            $sub = $g->component->subject->name;
            $bySubject[$sub] ??= ['scores' => [], 'weighted_total' => 0, 'weight_total' => 0];
            $bySubject[$sub]['scores'][] = [
                'component' => $g->component->name,
                'type' => $g->component->type,
                'score' => $g->score,
                'max_score' => $g->component->max_score,
                'weight' => $g->component->weight,
            ];
            $pct = $g->component->max_score > 0 ? ($g->score / $g->component->max_score) : 0;
            $bySubject[$sub]['weighted_total'] += $pct * $g->component->weight;
            $bySubject[$sub]['weight_total'] += $g->component->weight;
        }
        foreach ($bySubject as $sub => &$row) {
            $row['cumulative_pct'] = $row['weight_total'] > 0 ? round($row['weighted_total'] / $row['weight_total'] * 100, 2) : null;
        }
        unset($row);

        // Class rank: use a SINGLE aggregated query instead of O(n²) per-student loop
        $classRoomId = $request->user()->studentProfile?->class_room_id;
        if ($classRoomId) {
            $classmateIds = StudentProfile::where('class_room_id', $classRoomId)->pluck('user_id');
            $classSize = $classmateIds->count();

            // Aggregate all classmates' cumulative percentages per subject in one query
            $allRankings = Grade::whereIn('grades.student_user_id', $classmateIds)
                ->join('grade_components', 'grades.grade_component_id', '=', 'grade_components.id')
                ->join('subjects', 'grade_components.subject_id', '=', 'subjects.id')
                ->groupBy('grades.student_user_id', 'subjects.name')
                ->select([
                    'grades.student_user_id',
                    'subjects.name as subject_name',
                    DB::raw('CASE WHEN SUM(grade_components.weight) > 0 THEN SUM(grades.score / NULLIF(grade_components.max_score, 0) * grade_components.weight) / SUM(grade_components.weight) * 100 ELSE 0 END as cumulative_pct'),
                ])
                ->get()
                ->groupBy('subject_name');

            $myId = $request->user()->id;
            foreach ($bySubject as $sub => &$row) {
                $subjectRankings = $allRankings->get($sub, collect());
                $myPct = $row['cumulative_pct'] ?? 0;
                $rank = 1;
                foreach ($subjectRankings as $r) {
                    if ($r->student_user_id != $myId && (float) $r->cumulative_pct > $myPct) {
                        $rank++;
                    }
                }
                $row['class_rank'] = $rank;
                $row['class_size'] = $classSize;
            }
            unset($row);
        }

        return response()->json(['data' => $grades, 'by_subject' => $bySubject]);
    }

    public function attendance(Request $request)
    {
        $records = AttendanceRecord::where('student_user_id', $request->user()->id)
            ->with('subject:id,name')->orderBy('date', 'desc')->paginate(60);

        return response()->json($records);
    }

    public function reportCard(Request $request)
    {
        // Simple report card payload — PDF export is via /report-card.pdf
        $student = $request->user()->load('studentProfile.classRoom');
        $grades = $this->grades($request)->getData(true);

        return response()->json([
            'student' => $student,
            'grades' => $grades,
            'generated_at' => now()->toIso8601String(),
        ]);
    }

    public function reportCardPdf(Request $request)
    {
        $student = $request->user()->load('studentProfile.classRoom');
        $payload = $this->grades($request)->getData(true);
        $pdf = Pdf::loadView('pdf.report-card', [
            'student' => $student,
            'bySubject' => $payload['by_subject'] ?? [],
        ]);

        return $pdf->download("report-card-{$student->id}.pdf");
    }

    public function announcements(Request $request)
    {
        $classId = $request->user()->studentProfile?->class_room_id;
        $audiences = ['all', 'role:student'];
        if ($classId) {
            $audiences[] = "class:{$classId}";
        }
        $list = Announcement::whereIn('audience', $audiences)->latest()->paginate(20);

        return response()->json($list);
    }

    public function calendar()
    {
        return response()->json(CalendarEvent::orderBy('start_date')->paginate(100));
    }

    public function performanceChart(Request $request)
    {
        // Single, database-portable query (see PerformanceChartService).
        return response()->json(PerformanceChartService::build(
            $request->user()->id,
            $request->user()->studentProfile?->class_room_id,
        ));
    }
}
