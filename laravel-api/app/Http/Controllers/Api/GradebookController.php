<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Gradebook;
use App\Services\AuditLogger;
use App\Services\GradebookWorkflowService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GradebookController extends Controller
{
    public function __construct(private readonly GradebookWorkflowService $workflow) {}

    public function submit(Request $request, int $id)
    {
        $schoolId = (int) $request->attributes->get('school_id');
        $book = DB::table('gradebooks')->where('school_id', $schoolId)->find($id);
        abort_unless($book, 404);
        $assigned = $book->course_section_id
            ? DB::table('section_teachers')->where('school_id', $schoolId)
                ->where('course_section_id', $book->course_section_id)
                ->where('teacher_user_id', $request->user()->id)
                ->where('start_date', '<=', today())->where(fn ($q) => $q->whereNull('end_date')->orWhere('end_date', '>=', today()))->exists()
            : DB::table('class_subject_teacher')->where('class_room_id', $book->class_room_id)
                ->where('school_id', $schoolId)
                ->where('subject_id', $book->subject_id)->where('teacher_user_id', $request->user()->id)->exists();
        abort_unless($assigned, 403, 'You are not assigned to this gradebook.');

        return $this->act($request, 'gradebook_submitted', fn ($d) => $this->workflow->submit($id, $request->user()->id, $d['version']));
    }

    public function show(Request $request, int $id)
    {
        $book = Gradebook::findOrFail($id);
        if ($request->user()->role === 'teacher') {
            $assigned = $book->course_section_id
                ? DB::table('section_teachers')->where('school_id', $book->school_id)
                    ->where('course_section_id', $book->course_section_id)->where('teacher_user_id', $request->user()->id)->exists()
                : DB::table('class_subject_teacher')->where('school_id', $book->school_id)->where('class_room_id', $book->class_room_id)->where('subject_id', $book->subject_id)->where('teacher_user_id', $request->user()->id)->exists();
            abort_unless($assigned, 403, 'You are not assigned to this gradebook.');
        }

        return response()->json(['data' => $book]);
    }

    public function approve(Request $request, int $id)
    {
        return $this->act($request, 'gradebook_approved', fn ($d) => $this->workflow->approve($id, $request->user()->id, $d['version']));
    }

    public function returnForCorrection(Request $request, int $id)
    {
        return $this->act($request, 'gradebook_returned', fn ($d) => $this->workflow->returnForCorrection($id, $request->user()->id, $d['version'], $d['reason']), true);
    }

    public function finalize(Request $request, int $id)
    {
        return $this->act($request, 'gradebook_finalized', fn ($d) => $this->workflow->finalize($id, $request->user()->id, $d['version']));
    }

    public function reopen(Request $request, int $id)
    {
        $data = $request->validate(['version' => 'required|integer|min:1', 'reason' => 'required|string|max:2000', 'reopened_until' => 'required|date']);
        $book = $this->workflow->reopen($id, $request->user()->id, $data['version'], $data['reason'], $data['reopened_until']);
        AuditLogger::log($request, 'gradebook_reopened', 'gradebook', $id, $data);

        return response()->json(['data' => $book]);
    }

    public function issue(Request $request)
    {
        $data = $request->validate([
            'student_enrollment_id' => 'required|integer|exists:student_enrollments,id',
            'grading_period_id' => 'required|integer|exists:grading_periods,id',
            'correction_reason' => 'nullable|string|max:2000',
        ]);
        $issue = $this->workflow->issueReportCard($data['student_enrollment_id'], $data['grading_period_id'], $request->user()->id, $data['correction_reason'] ?? null);
        AuditLogger::log($request, $issue->issue_version > 1 ? 'report_card_reissued' : 'report_card_issued', 'report_card_issue', $issue->id, ['issue_version' => $issue->issue_version]);

        return response()->json(['data' => $issue], 201);
    }

    private function act(Request $request, string $event, callable $callback, bool $reason = false)
    {
        $rules = ['version' => 'required|integer|min:1'];
        if ($reason) {
            $rules['reason'] = 'required|string|max:2000';
        }
        $data = $request->validate($rules);
        $book = $callback($data);
        AuditLogger::log($request, $event, 'gradebook', $book->id, $data);

        return response()->json(['data' => $book]);
    }
}
