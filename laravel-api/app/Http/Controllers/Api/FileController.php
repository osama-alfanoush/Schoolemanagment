<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Assignment;
use App\Models\Submission;
use App\Models\User;
use App\Services\CurrentSchool;
use App\Services\PrivateFileVault;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Symfony\Component\HttpFoundation\StreamedResponse;

/**
 * The only route through which a private file leaves the system.
 *
 * Every action answers three questions before a byte is streamed:
 *
 *   1. Is the record in the caller's school?  The tenant global scope answers
 *      this for models; the vault re-checks the storage key independently, so a
 *      row whose key was written before the scope existed still cannot be read
 *      across a tenant boundary.
 *   2. Does the caller have a relationship to the record?  A parent may read
 *      only a linked child, a student only their own work, a teacher only the
 *      classes they are assigned to.
 *   3. Does the caller's role permit this category at all?
 *
 * Nothing is inferred from the URL beyond a record id. The storage key is read
 * from the database, never accepted from the client, so there is no key to
 * tamper with.
 */
class FileController extends Controller
{
    public function __construct(
        private readonly PrivateFileVault $vault,
        private readonly CurrentSchool $currentSchool,
    ) {}

    /**
     * A profile photo is personal data. Readable by the owner, by an
     * administrator or HR member of the same school, by a teacher who teaches
     * the person, and by a parent of that person.
     */
    public function profilePhoto(Request $request, int $userId): StreamedResponse
    {
        $viewer = $request->user();

        // The User global scope already restricts this to members of the
        // caller's school, so a cross-school id is a 404 rather than a signal.
        $target = User::query()->findOrFail($userId);

        abort_unless($this->canSeeProfilePhotoOf($viewer, $target), 403, 'Not authorised to view this photo.');
        abort_unless((bool) $target->photo_path, 404);

        return $this->vault->stream($target->photo_path, 'profile-photo.jpg');
    }

    /**
     * A teacher's attachment for an assignment: readable by students in the
     * class, their parents, the assigning teacher and school administrators.
     */
    public function assignmentAttachment(Request $request, int $assignmentId): StreamedResponse
    {
        $viewer = $request->user();
        $assignment = Assignment::query()->findOrFail($assignmentId);

        abort_unless((bool) $assignment->attachment_path, 404);
        abort_unless($this->canSeeAssignment($viewer, $assignment), 403, 'Not authorised to view this attachment.');

        return $this->vault->stream($assignment->attachment_path, 'assignment-'.$assignment->id.'.bin');
    }

    /**
     * A student's submitted work: readable by the student who submitted it,
     * that student's parents, the teacher who set the assignment, and school
     * administrators. Explicitly NOT readable by classmates.
     */
    public function submission(Request $request, int $submissionId): StreamedResponse
    {
        $viewer = $request->user();
        $submission = Submission::query()->with('assignment')->findOrFail($submissionId);

        abort_unless((bool) $submission->file_path, 404);
        abort_unless($this->canSeeSubmission($viewer, $submission), 403, 'Not authorised to view this submission.');

        return $this->vault->stream($submission->file_path, 'submission-'.$submission->id.'.bin');
    }

    private function canSeeProfilePhotoOf(User $viewer, User $target): bool
    {
        if ($viewer->id === $target->id) {
            return true;
        }

        if (in_array($viewer->role, ['admin', 'hr'], true)) {
            return true;
        }

        if ($viewer->role === 'parent') {
            return $this->isLinkedChild($viewer->id, $target->id);
        }

        if ($viewer->role === 'teacher') {
            // Only pupils the teacher actually teaches, and only staff-facing
            // colleagues are excluded: a teacher has no need for another
            // teacher's photo through this route.
            return $target->role === 'student' && $this->teachesStudent($viewer->id, $target->id);
        }

        return false;
    }

    private function canSeeAssignment(User $viewer, Assignment $assignment): bool
    {
        if ($viewer->role === 'admin') {
            return true;
        }

        if ($viewer->role === 'teacher') {
            return $assignment->teacher_user_id === $viewer->id
                || $this->teachesClass($viewer->id, (int) $assignment->class_room_id);
        }

        if ($viewer->role === 'student') {
            return $viewer->studentProfile?->class_room_id === $assignment->class_room_id;
        }

        if ($viewer->role === 'parent') {
            return DB::table('parent_student')
                ->join('student_profiles', 'student_profiles.user_id', '=', 'parent_student.student_user_id')
                ->where('parent_student.school_id', $this->currentSchool->id())
                ->where('parent_student.parent_user_id', $viewer->id)
                ->where('student_profiles.class_room_id', $assignment->class_room_id)
                ->exists();
        }

        return false;
    }

    private function canSeeSubmission(User $viewer, Submission $submission): bool
    {
        if ($viewer->role === 'admin') {
            return true;
        }

        if ($viewer->role === 'student') {
            return $submission->student_user_id === $viewer->id;
        }

        if ($viewer->role === 'parent') {
            return $this->isLinkedChild($viewer->id, (int) $submission->student_user_id);
        }

        if ($viewer->role === 'teacher') {
            $assignment = $submission->assignment;

            return $assignment !== null
                && ($assignment->teacher_user_id === $viewer->id
                    || $this->teachesClass($viewer->id, (int) $assignment->class_room_id));
        }

        return false;
    }

    private function isLinkedChild(int $parentId, int $studentId): bool
    {
        return DB::table('parent_student')
            ->where('school_id', $this->currentSchool->id())
            ->where('parent_user_id', $parentId)
            ->where('student_user_id', $studentId)
            ->exists();
    }

    private function teachesClass(int $teacherId, int $classRoomId): bool
    {
        return DB::table('class_subject_teacher')
            ->where('school_id', $this->currentSchool->id())
            ->where('teacher_user_id', $teacherId)
            ->where('class_room_id', $classRoomId)
            ->exists();
    }

    private function teachesStudent(int $teacherId, int $studentId): bool
    {
        return DB::table('student_profiles')
            ->join('class_subject_teacher', 'class_subject_teacher.class_room_id', '=', 'student_profiles.class_room_id')
            ->where('class_subject_teacher.school_id', $this->currentSchool->id())
            ->where('class_subject_teacher.teacher_user_id', $teacherId)
            ->where('student_profiles.user_id', $studentId)
            ->exists();
    }
}
