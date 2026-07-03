<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\Submission;
use App\Models\User;
use Illuminate\Database\Eloquent\Collection;

class GradeService
{
    public function gradeComponents(int $classRoomId, int $subjectId): Collection
    {
        return GradeComponent::where([
            'class_room_id' => $classRoomId,
            'subject_id' => $subjectId,
        ])->get();
    }

    public function createComponent(array $data, int $classRoomId, int $subjectId): GradeComponent
    {
        return GradeComponent::create(array_merge($data, [
            'class_room_id' => $classRoomId,
            'subject_id' => $subjectId,
        ]));
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
        $component = GradeComponent::findOrFail($data['grade_component_id']);

        $g = Grade::updateOrCreate(
            ['student_user_id' => $data['student_user_id'], 'grade_component_id' => $data['grade_component_id']],
            ['score' => $data['score'], 'entered_by' => $teacherId]
        );

        Notifier::send($data['student_user_id'], 'grade_posted', 'Grade posted', "Score: {$data['score']}", ['grade_id' => $g->id]);

        return $g;
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
