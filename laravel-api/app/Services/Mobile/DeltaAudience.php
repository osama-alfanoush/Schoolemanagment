<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\ClassRoom;
use App\Models\StudentProfile;
use App\Models\User;
use Illuminate\Support\Facades\DB;

/**
 * Everything the delta feed is allowed to show one authenticated user,
 * resolved once per request from the token — never from the request.
 *
 * Resolving it up front is also what keeps the feed off an N+1: each scope key
 * set costs one query here, and the per-entity queries then filter on plain id
 * lists instead of re-deriving the relationship per row.
 */
final class DeltaAudience
{
    /**
     * @param  list<int>  $studentUserIds  Students whose own records this user may read.
     * @param  list<int>  $classRoomIds  Classes this user may read class-wide records for.
     * @param  list<array{class_room_id: int, subject_id: int}>  $teachingAssignments
     */
    private function __construct(
        public readonly User $user,
        public readonly string $role,
        public readonly int $schoolId,
        public readonly array $studentUserIds,
        public readonly array $classRoomIds,
        public readonly array $teachingAssignments,
    ) {}

    public static function resolve(User $user, int $schoolId): self
    {
        return match ($user->role) {
            'parent' => self::forParent($user, $schoolId),
            'student' => self::forStudent($user, $schoolId),
            'teacher' => self::forTeacher($user, $schoolId),
            default => new self($user, $user->role, $schoolId, [], [], []),
        };
    }

    private static function forParent(User $user, int $schoolId): self
    {
        // The pivot is school-scoped, so a guardian linked in another school
        // cannot pull that school's child into this feed.
        $childIds = DB::table('parent_student')
            ->where('school_id', $schoolId)
            ->where('parent_user_id', $user->id)
            ->pluck('student_user_id')
            ->map(fn ($id): int => (int) $id)
            ->all();

        return new self(
            $user,
            'parent',
            $schoolId,
            $childIds,
            self::classRoomsOfStudents($childIds, $schoolId),
            [],
        );
    }

    private static function forStudent(User $user, int $schoolId): self
    {
        return new self(
            $user,
            'student',
            $schoolId,
            [$user->id],
            self::classRoomsOfStudents([$user->id], $schoolId),
            [],
        );
    }

    private static function forTeacher(User $user, int $schoolId): self
    {
        $assignments = DB::table('class_subject_teacher')
            ->where('school_id', $schoolId)
            ->where('teacher_user_id', $user->id)
            ->get(['class_room_id', 'subject_id'])
            ->map(fn ($row): array => [
                'class_room_id' => (int) $row->class_room_id,
                'subject_id' => (int) $row->subject_id,
            ])
            ->all();

        $homeroomIds = ClassRoom::query()
            ->where('school_id', $schoolId)
            ->where('homeroom_teacher_id', $user->id)
            ->pluck('id')
            ->map(fn ($id): int => (int) $id)
            ->all();

        $classRoomIds = array_values(array_unique(array_merge(
            $homeroomIds,
            array_column($assignments, 'class_room_id'),
        )));

        // A teacher reads records through the class, not through the child, so
        // the student list stays empty: nothing here grants a teacher a
        // student-owned record (an invoice, say) that is not class work.
        return new self($user, 'teacher', $schoolId, [], $classRoomIds, $assignments);
    }

    /** @param list<int> $studentUserIds @return list<int> */
    private static function classRoomsOfStudents(array $studentUserIds, int $schoolId): array
    {
        if ($studentUserIds === []) {
            return [];
        }

        return StudentProfile::query()
            ->where('school_id', $schoolId)
            ->whereIn('user_id', $studentUserIds)
            ->whereNotNull('class_room_id')
            ->pluck('class_room_id')
            ->map(fn ($id): int => (int) $id)
            ->unique()
            ->values()
            ->all();
    }

    /** True when this audience can see nothing at all — an empty feed, not an error. */
    public function isEmpty(): bool
    {
        return $this->studentUserIds === [] && $this->classRoomIds === [];
    }
}
