<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Grade;
use App\Models\Gradebook;
use App\Models\GradeComponent;
use App\Models\Submission;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class GradeService
{
    public function __construct(private CurrentSchool $currentSchool) {}

    public function gradeComponents(int $classRoomId, int $subjectId): Collection
    {
        return GradeComponent::where([
            'class_room_id' => $classRoomId,
            'subject_id' => $subjectId,
        ])->get();
    }

    public function createComponent(array $data, int $classRoomId, int $subjectId): GradeComponent
    {
        return DB::transaction(function () use ($data, $classRoomId, $subjectId) {
            if (! empty($data['grading_period_id'])) {
                $schoolId = DB::table('class_rooms')->where('id', $classRoomId)
                    ->where('school_id', $this->currentSchool->id())->value('school_id');
                abort_unless($schoolId !== null, 422, 'The class belongs to another school.');
                $book = Gradebook::firstOrCreate([
                    'class_room_id' => $classRoomId,
                    'subject_id' => $subjectId,
                    'grading_period_id' => $data['grading_period_id'],
                ], ['school_id' => $schoolId, 'state' => 'draft', 'version' => 1]);
                $book = Gradebook::query()->lockForUpdate()->findOrFail($book->id);
                $data['gradebook_id'] = $book->id;
            } else {
                // Serialize legacy component creation on the class row.
                DB::table('class_rooms')->where('school_id', $this->currentSchool->id())
                    ->where('id', $classRoomId)->lockForUpdate()->firstOrFail();
            }

            $existingWeight = (float) GradeComponent::where('class_room_id', $classRoomId)
                ->where('subject_id', $subjectId)
                ->when($data['grading_period_id'] ?? null, fn ($query, $period) => $query->where('grading_period_id', $period))
                ->sum('weight');
            if ($existingWeight + (float) $data['weight'] > 100.0001) {
                throw ValidationException::withMessages([
                    'weight' => ['Component weights cannot exceed 100 for a grading period.'],
                ]);
            }

            return GradeComponent::create(array_merge($data, [
                'class_room_id' => $classRoomId,
                'subject_id' => $subjectId,
            ]));
        });
    }

    public function studentGradeReport(int $classRoomId, int $subjectId): array
    {
        $components = GradeComponent::where('class_room_id', $classRoomId)
            ->where('subject_id', $subjectId)->get();

        $students = User::where('role', 'student')
            ->whereHas('studentProfile', fn ($q) => $q->where('class_room_id', $classRoomId))
            ->with('studentProfile')->orderBy('name')->get();

        $rows = [];
        foreach ($students as $student) {
            $row = [
                'name' => $student->name,
                'admission_no' => $student->studentProfile?->admission_no ?? '-',
            ];
            $weightedTotal = 0;
            $weightTotal = 0;
            foreach ($components as $comp) {
                $grade = Grade::where('student_user_id', $student->id)
                    ->where('grade_component_id', $comp->id)->first();
                $row[$comp->name] = $grade ? (float) $grade->score : null;
                if ($grade && $comp->max_score > 0) {
                    $weightedTotal += ($grade->score / $comp->max_score) * $comp->weight;
                    $weightTotal += $comp->weight;
                }
            }
            $row['total_pct'] = $weightTotal > 0 ? round($weightedTotal / $weightTotal * 100, 2) : null;
            $rows[] = $row;
        }

        return $rows;
    }

    public function enter(array $data, int $teacherId): Grade
    {
        return DB::transaction(function () use ($data, $teacherId) {
            $component = GradeComponent::with('gradebook')->findOrFail($data['grade_component_id']);
            if ($component->gradebook && ! $component->gradebook->isEditable()) {
                throw ValidationException::withMessages([
                    'gradebook' => ['This gradebook is not open for editing.'],
                ]);
            }

            $grade = Grade::where('student_user_id', $data['student_user_id'])
                ->where('grade_component_id', $data['grade_component_id'])
                ->lockForUpdate()->first();
            $oldScore = $grade?->score;
            $oldVersion = $grade?->version ?? 0;
            if ($grade && isset($data['version']) && (int) $data['version'] !== $grade->version) {
                abort(409, 'Grade was changed by another user.');
            }

            if ($grade) {
                $grade->update([
                    'score' => $data['score'],
                    'entered_by' => $teacherId,
                    'version' => $grade->version + 1,
                ]);
            } else {
                $grade = Grade::create([
                    'student_user_id' => $data['student_user_id'],
                    'grade_component_id' => $data['grade_component_id'],
                    'score' => $data['score'],
                    'entered_by' => $teacherId,
                    'version' => 1,
                ]);
            }

            DB::table('grade_change_history')->insert([
                'school_id' => $this->currentSchool->id(),
                'grade_id' => $grade->id,
                'old_score' => $oldScore,
                'new_score' => $grade->score,
                'old_version' => $oldVersion,
                'new_version' => $grade->version,
                'actor_id' => $teacherId,
                'reason' => $data['reason'] ?? ($oldScore === null ? 'Initial entry' : 'Score correction'),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            DB::afterCommit(fn () => Notifier::send(
                $data['student_user_id'],
                'grade_posted',
                'Grade posted',
                "Score: {$data['score']}",
                ['grade_id' => $grade->id]
            ));

            return $grade->fresh();
        });
    }

    public function update(int $gradeId, array $data, int $teacherId): Grade
    {
        $grade = Grade::findOrFail($gradeId);
        $grade->update(array_merge($data, ['entered_by' => $teacherId]));

        return $grade->fresh();
    }

    public function exportGrades(int $classRoomId, int $subjectId): array
    {
        $components = GradeComponent::where('class_room_id', $classRoomId)
            ->where('subject_id', $subjectId)->get();
        $componentNames = $components->pluck('name')->toArray();

        $students = User::where('role', 'student')
            ->whereHas('studentProfile', fn ($q) => $q->where('class_room_id', $classRoomId))
            ->with('studentProfile')->orderBy('name')->get();

        $rows = [];
        foreach ($students as $student) {
            $row = [
                'name' => $student->name,
                'admission_no' => $student->studentProfile?->admission_no ?? '-',
            ];
            $weightedTotal = 0;
            $weightTotal = 0;
            foreach ($components as $comp) {
                $grade = Grade::where('student_user_id', $student->id)
                    ->where('grade_component_id', $comp->id)->first();
                $row[$comp->name] = $grade ? (float) $grade->score : null;
                if ($grade && $comp->max_score > 0) {
                    $weightedTotal += ($grade->score / $comp->max_score) * $comp->weight;
                    $weightTotal += $comp->weight;
                }
            }
            $row['total_pct'] = $weightTotal > 0 ? round($weightedTotal / $weightTotal * 100, 2) : null;
            $rows[] = $row;
        }

        return [
            'rows' => $rows,
            'componentNames' => $componentNames,
            'classRoomId' => $classRoomId,
            'subjectId' => $subjectId,
        ];
    }

    public function gradeSubmission(int $submissionId, array $data, int $teacherId): Submission
    {
        $sub = Submission::with('assignment')->findOrFail($submissionId);

        if ((float) $data['score'] > (float) $sub->assignment->max_score) {
            throw new \InvalidArgumentException('Score exceeds assignment max_score');
        }

        $sub->update([
            'score' => $data['score'],
            'feedback' => $data['feedback'] ?? null,
            'status' => 'graded',
            'graded_by' => $teacherId,
        ]);

        Notifier::send($sub->student_user_id, 'grade_posted', 'Grade posted', "You received {$data['score']}", ['submission_id' => $sub->id]);

        return $sub->fresh();
    }
}
