<?php

namespace App\Services;

use App\Models\Gradebook;
use App\Models\ReportCardIssue;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class GradebookWorkflowService
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function submit(int $id, int $actorId, int $version): Gradebook
    {
        return $this->transition($id, $version, ['draft', 'returned', 'reopened'], 'submitted', function (Gradebook $book) use ($actorId) {
            $weight = (float) DB::table('grade_components')->where('school_id', $this->currentSchool->id())
                ->where('gradebook_id', $book->id)->sum('weight');
            if (abs($weight - 100.0) > 0.0001) {
                throw ValidationException::withMessages([
                    'components' => ["Grade component weights must total exactly 100 before submission; current total is {$weight}."],
                ]);
            }
            $book->forceFill([
                'submitted_by' => $actorId, 'submitted_at' => now(),
                'approved_by' => null, 'approved_at' => null,
                'returned_by' => null, 'returned_at' => null, 'return_reason' => null,
            ]);
        });
    }

    public function approve(int $id, int $actorId, int $version): Gradebook
    {
        return $this->transition($id, $version, ['submitted'], 'approved', fn (Gradebook $book) => $book->forceFill([
            'approved_by' => $actorId, 'approved_at' => now(),
        ]));
    }

    public function returnForCorrection(int $id, int $actorId, int $version, string $reason): Gradebook
    {
        return $this->transition($id, $version, ['submitted'], 'returned', fn (Gradebook $book) => $book->forceFill([
            'returned_by' => $actorId, 'returned_at' => now(), 'return_reason' => $reason,
        ]));
    }

    public function finalize(int $id, int $actorId, int $version): Gradebook
    {
        return $this->transition($id, $version, ['approved'], 'finalized', fn (Gradebook $book) => $book->forceFill([
            'finalized_by' => $actorId, 'finalized_at' => now(),
        ]));
    }

    public function reopen(int $id, int $actorId, int $version, string $reason, string $until): Gradebook
    {
        if (now()->parse($until)->isPast()) {
            throw ValidationException::withMessages(['reopened_until' => ['The reopen expiry must be in the future.']]);
        }

        return $this->transition($id, $version, ['finalized'], 'reopened', fn (Gradebook $book) => $book->forceFill([
            'reopened_by' => $actorId, 'reopened_until' => $until, 'reopen_reason' => $reason,
        ]));
    }

    public function issueReportCard(int $enrollmentId, int $periodId, int $actorId, ?string $reason): ReportCardIssue
    {
        return DB::transaction(function () use ($enrollmentId, $periodId, $actorId, $reason) {
            $schoolId = $this->currentSchool->id();
            $enrollment = DB::table('student_enrollments')->where('school_id', $schoolId)->lockForUpdate()->find($enrollmentId);
            abort_unless($enrollment, 404, 'Enrollment not found.');

            $books = DB::table('gradebooks')
                ->where('school_id', $schoolId)
                ->where('grading_period_id', $periodId)
                ->where('state', 'finalized')
                ->where(function ($query) use ($enrollment, $schoolId) {
                    $query->where('class_room_id', $enrollment->class_room_id)
                        ->orWhereIn('course_section_id', DB::table('section_enrollments')
                            ->where('school_id', $schoolId)
                            ->where('student_enrollment_id', $enrollment->id)->select('course_section_id'));
                })->get();
            if ($books->isEmpty()) {
                throw ValidationException::withMessages(['grading_period_id' => ['No finalized gradebooks exist for this enrollment and period.']]);
            }

            $existingVersion = (int) ReportCardIssue::query()
                ->where('student_enrollment_id', $enrollmentId)
                ->where('grading_period_id', $periodId)
                ->max('issue_version');
            if ($existingVersion > 0 && blank($reason)) {
                throw ValidationException::withMessages(['correction_reason' => ['A correction reason is required when reissuing a report card.']]);
            }

            $componentIds = DB::table('grade_components')->where('school_id', $schoolId)->whereIn('gradebook_id', $books->pluck('id'))->pluck('id');
            $components = DB::table('grade_components')->where('school_id', $schoolId)->whereIn('id', $componentIds)->orderBy('id')->get();
            $grades = DB::table('grades')->where('school_id', $schoolId)->where('student_user_id', $enrollment->student_user_id)
                ->whereIn('grade_component_id', $componentIds)->get()->keyBy('grade_component_id');
            $snapshot = [
                'schema_version' => 1,
                'student_enrollment_id' => $enrollmentId,
                'student_user_id' => $enrollment->student_user_id,
                'school_id' => $enrollment->school_id,
                'academic_year_id' => $enrollment->academic_year_id,
                'grading_period_id' => $periodId,
                'gradebooks' => $books->map(fn ($book) => [
                    'id' => $book->id, 'course_section_id' => $book->course_section_id,
                    'class_room_id' => $book->class_room_id, 'subject_id' => $book->subject_id,
                    'finalized_at' => $book->finalized_at,
                    'components' => $components->where('gradebook_id', $book->id)->values()->map(fn ($component) => [
                        'id' => $component->id, 'name' => $component->name,
                        'weight' => $component->weight, 'max_score' => $component->max_score,
                        'score' => $grades->get($component->id)?->score,
                    ])->all(),
                ])->all(),
                'issued_at' => now()->toIso8601String(),
            ];
            $canonical = json_encode($snapshot, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_THROW_ON_ERROR);

            return ReportCardIssue::create([
                'student_enrollment_id' => $enrollmentId,
                'grading_period_id' => $periodId,
                'issue_version' => $existingVersion + 1,
                'snapshot' => $snapshot,
                'checksum' => hash('sha256', $canonical),
                'correction_reason' => $reason,
                'issued_by' => $actorId,
                'issued_at' => now(),
            ]);
        });
    }

    private function transition(int $id, int $version, array $from, string $to, callable $mutate): Gradebook
    {
        return DB::transaction(function () use ($id, $version, $from, $to, $mutate) {
            $book = Gradebook::query()->lockForUpdate()->findOrFail($id);
            if ($book->version !== $version) {
                abort(409, 'Gradebook was changed by another user.');
            }
            if (! in_array($book->state, $from, true)) {
                abort(409, "Gradebook cannot transition from {$book->state} to {$to}.");
            }
            $mutate($book);
            $book->state = $to;
            $book->version++;
            $book->save();

            return $book->fresh();
        });
    }
}
