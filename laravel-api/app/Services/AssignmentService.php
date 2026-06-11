<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Assignment;
use App\Models\Submission;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class AssignmentService
{
    public function create(array $data, int $createdBy, ?string $attachmentPath = null): array
    {
        $created = [];
        DB::transaction(function () use ($data, $createdBy, $attachmentPath, &$created) {
            foreach ($data['class_room_ids'] as $classId) {
                $a = Assignment::create([
                    'teacher_user_id' => $createdBy,
                    'class_room_id' => $classId,
                    'subject_id' => $data['subject_id'],
                    'title' => $data['title'],
                    'instructions' => $data['instructions'],
                    'due_at' => $data['due_at'],
                    'max_score' => $data['max_score'] ?? 100,
                    'attachment_path' => $attachmentPath,
                ]);
                $studentIds = User::where('role', 'student')
                    ->whereHas('studentProfile', fn($q) => $q->where('class_room_id', $classId))
                    ->pluck('id');
                foreach ($studentIds as $sid) {
                    Notifier::send($sid, 'new_assignment', 'New homework', $a->title, ['assignment_id' => $a->id]);
                }
                $created[] = $a;
            }
        });
        return $created;
    }

    public function update(int $assignmentId, array $data): Assignment
    {
        $assignment = Assignment::findOrFail($assignmentId);
        $assignment->update($data);
        return $assignment->fresh();
    }

    public function delete(int $assignmentId): void
    {
        $assignment = Assignment::findOrFail($assignmentId);
        $assignment->delete();
    }

    public function gradeSubmission(int $submissionId, array $data, int $gradedBy): Submission
    {
        $sub = Submission::with('assignment')->findOrFail($submissionId);

        if ((float) ($data['score'] ?? 0) > (float) $sub->assignment->max_score) {
            throw new \InvalidArgumentException('Score exceeds assignment max_score');
        }

        $sub->update([
            'score' => $data['score'] ?? 0,
            'feedback' => $data['feedback'] ?? null,
            'status' => 'graded',
            'graded_by' => $gradedBy,
        ]);

        Notifier::send($sub->student_user_id, 'grade_posted', 'Grade posted', "You received {$data['score']}", ['submission_id' => $sub->id]);

        return $sub->fresh();
    }
}