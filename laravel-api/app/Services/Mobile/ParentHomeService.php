<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Notification;
use App\Models\User;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

/**
 * The parent home screen, assembled in a fixed number of queries.
 *
 * Every lookup here is batched across all of a guardian's children: a parent
 * with five children costs the same as a parent with one. That is not an
 * optimisation, it is the requirement — the per-child loop this replaces is
 * what turns a 200 ms home screen into a 2 s one for exactly the families who
 * use the app most.
 */
final class ParentHomeService
{
    /**
     * @param  list<int>  $childIds
     * @return array<string, mixed>
     */
    public function home(User $parent, array $childIds, int $schoolId): array
    {
        if ($childIds === []) {
            // A guardian whose children have not been linked yet. An empty
            // payload, not a 500 and not a half-rendered screen.
            return [
                'children' => [],
                'unread_count' => $this->unreadCount($parent),
                'generated_at' => now()->toIso8601String(),
            ];
        }

        $children = $this->children($childIds);
        $classRoomIds = array_values(array_filter(
            array_map(static fn (array $child): ?int => $child['class_room_id'], $children),
        ));

        $attendance = $this->attendanceThisWeek($childIds);
        $installments = $this->nextInstallments($childIds, $schoolId);
        $grades = $this->latestPublishedGrades($childIds);
        $timetable = $this->todaysTimetable($classRoomIds);

        return [
            'children' => array_map(
                fn (array $child): array => $child + [
                    'attendance' => $attendance[$child['id']] ?? self::emptyAttendance(),
                    'next_installment' => $installments[$child['id']] ?? null,
                    'latest_grade' => $grades[$child['id']] ?? null,
                    'today' => $timetable[$child['class_room_id']] ?? [],
                ],
                $children,
            ),
            // Account-wide. `notifications` has no child column, so a per-child
            // count would be invented rather than measured, and a fee badge
            // against the wrong child is worse than no badge.
            'unread_count' => $this->unreadCount($parent),
            'generated_at' => now()->toIso8601String(),
        ];
    }

    /* ---------- pieces ---------- */

    /** @param list<int> $childIds @return list<array<string, mixed>> */
    private function children(array $childIds): array
    {
        return User::query()
            ->whereIn('users.id', $childIds)
            ->leftJoin('student_profiles', 'student_profiles.user_id', '=', 'users.id')
            ->leftJoin('class_rooms', 'class_rooms.id', '=', 'student_profiles.class_room_id')
            ->orderBy('users.name')
            ->get([
                'users.id',
                'users.name',
                'student_profiles.class_room_id',
                'class_rooms.name as class_name',
                'class_rooms.grade as class_grade',
            ])
            ->map(static fn ($row): array => [
                'id' => (int) $row->id,
                'name' => $row->name,
                'class_room_id' => $row->class_room_id === null ? null : (int) $row->class_room_id,
                'class_name' => $row->class_name,
                'grade' => $row->class_grade,
            ])
            ->values()
            ->all();
    }

    /**
     * Attendance for the current school week, per child.
     *
     * The week runs Sunday to Thursday here, so it is taken from Sunday rather
     * than from Monday — a Monday-based week silently drops a school day.
     *
     * @param  list<int>  $childIds
     * @return array<int, array<string, mixed>>
     */
    private function attendanceThisWeek(array $childIds): array
    {
        [$from, $to] = self::schoolWeek();

        $rows = DB::table('attendance_records')
            ->whereIn('student_user_id', $childIds)
            ->whereBetween('date', [$from->toDateString(), $to->toDateString()])
            ->groupBy('student_user_id', 'status')
            ->get([
                'student_user_id',
                'status',
                DB::raw('COUNT(*) as total'),
            ]);

        $byChild = [];
        foreach ($rows as $row) {
            $childId = (int) $row->student_user_id;
            $byChild[$childId] ??= self::emptyAttendance();
            $byChild[$childId]['counts'][(string) $row->status] = (int) $row->total;
        }

        foreach ($byChild as $childId => $summary) {
            $counts = $summary['counts'];
            $recorded = array_sum($counts);
            $present = ($counts['present'] ?? 0) + ($counts['late'] ?? 0) + ($counts['excused'] ?? 0);

            $byChild[$childId]['recorded_days'] = $recorded;
            $byChild[$childId]['absent_days'] = $counts['absent'] ?? 0;
            $byChild[$childId]['late_days'] = $counts['late'] ?? 0;
            // Null, not 100%, when nothing has been marked: a week with no
            // register taken is not a week of perfect attendance.
            $byChild[$childId]['present_percent'] = $recorded === 0
                ? null
                : (int) round($present * 100 / $recorded);
        }

        return $byChild;
    }

    /**
     * The next unpaid installment for each child.
     *
     * @param  list<int>  $childIds
     * @return array<int, array<string, mixed>>
     */
    private function nextInstallments(array $childIds, int $schoolId): array
    {
        $rows = DB::table('installments')
            ->join('payment_plans', 'payment_plans.id', '=', 'installments.payment_plan_id')
            ->where('payment_plans.school_id', $schoolId)
            ->whereNull('payment_plans.deleted_at')
            ->whereIn('payment_plans.student_user_id', $childIds)
            ->whereIn('installments.status', ['pending', 'partial', 'overdue'])
            ->orderBy('installments.due_date')
            ->orderBy('installments.id')
            ->get([
                'installments.id',
                'installments.due_date',
                'installments.amount',
                'installments.paid_amount',
                'installments.status',
                'payment_plans.student_user_id',
            ]);

        $today = Carbon::today();
        $next = [];

        foreach ($rows as $row) {
            $childId = (int) $row->student_user_id;
            // Ordered by due date, so the first row seen for a child is the
            // one they owe next.
            if (isset($next[$childId])) {
                continue;
            }

            $due = Carbon::parse($row->due_date)->startOfDay();
            $outstanding = MobileMoney::toMinor(
                self::subtract($row->amount, $row->paid_amount),
                (int) config('mobile.currency_decimals', 3),
            );

            $next[$childId] = [
                'id' => (int) $row->id,
                'due_date' => $due->toDateString(),
                'amount' => MobileMoney::payload($row->amount),
                'outstanding' => [
                    'minor' => $outstanding,
                    'currency' => strtoupper((string) config('mobile.currency', 'JOD')),
                    'decimals' => (int) config('mobile.currency_decimals', 3),
                ],
                // Negative once the date has passed, which is what lets the
                // client say "3 days late" rather than "-3 days remaining".
                'days_remaining' => (int) $today->diffInDays($due, false),
                'overdue' => $due->lt($today),
                'status' => (string) $row->status,
            ];
        }

        return $next;
    }

    /**
     * The most recent grade a parent is allowed to see, per child.
     *
     * Only marks whose gradebook has been **finalized** count. A component with
     * no gradebook at all is treated as unpublished: showing a teacher's
     * working draft to a parent is the failure that cannot be undone, so the
     * unknown case fails closed.
     *
     * @param  list<int>  $childIds
     * @return array<int, array<string, mixed>>
     */
    private function latestPublishedGrades(array $childIds): array
    {
        $rows = DB::table('grades')
            ->join('grade_components', 'grade_components.id', '=', 'grades.grade_component_id')
            ->join('gradebooks', 'gradebooks.id', '=', 'grade_components.gradebook_id')
            ->leftJoin('subjects', 'subjects.id', '=', 'grade_components.subject_id')
            ->whereIn('grades.student_user_id', $childIds)
            ->where('gradebooks.state', 'finalized')
            ->orderByDesc('grades.updated_at')
            ->orderByDesc('grades.id')
            ->get([
                'grades.id',
                'grades.student_user_id',
                'grades.score',
                'grades.updated_at',
                'grade_components.name as component_name',
                'grade_components.max_score',
                'subjects.name as subject_name',
            ]);

        $latest = [];
        foreach ($rows as $row) {
            $childId = (int) $row->student_user_id;
            if (isset($latest[$childId])) {
                continue;
            }

            $latest[$childId] = [
                'id' => (int) $row->id,
                'subject' => $row->subject_name,
                'component' => $row->component_name,
                'score' => self::mark($row->score),
                'max_score' => self::mark($row->max_score),
                'recorded_at' => Carbon::parse($row->updated_at)->toIso8601String(),
            ];
        }

        return $latest;
    }

    /**
     * Today's periods, keyed by class room.
     *
     * @param  list<int>  $classRoomIds
     * @return array<int, list<array<string, mixed>>>
     */
    private function todaysTimetable(array $classRoomIds): array
    {
        if ($classRoomIds === []) {
            return [];
        }

        $rows = DB::table('timetable_entries')
            ->leftJoin('subjects', 'subjects.id', '=', 'timetable_entries.subject_id')
            ->leftJoin('users', 'users.id', '=', 'timetable_entries.teacher_user_id')
            ->whereIn('timetable_entries.class_room_id', $classRoomIds)
            ->where('timetable_entries.day_of_week', Carbon::today()->dayOfWeekIso)
            ->orderBy('timetable_entries.start_time')
            ->get([
                'timetable_entries.id',
                'timetable_entries.class_room_id',
                'timetable_entries.start_time',
                'timetable_entries.end_time',
                'timetable_entries.room',
                'subjects.name as subject_name',
                'users.name as teacher_name',
            ]);

        $byClass = [];
        foreach ($rows as $row) {
            $byClass[(int) $row->class_room_id][] = [
                'id' => (int) $row->id,
                'subject' => $row->subject_name,
                'teacher' => $row->teacher_name,
                'start_time' => (string) $row->start_time,
                'end_time' => (string) $row->end_time,
                'room' => $row->room,
            ];
        }

        return $byClass;
    }

    private function unreadCount(User $parent): int
    {
        return Notification::query()
            ->where('user_id', $parent->id)
            ->whereNull('read_at')
            ->count();
    }

    /* ---------- helpers ---------- */

    /** @return array{0: Carbon, 1: Carbon} Sunday to Thursday of the current week. */
    public static function schoolWeek(): array
    {
        $today = Carbon::today();
        // dayOfWeek is 0 for Sunday, which is the first working day here.
        $sunday = $today->copy()->subDays($today->dayOfWeek);

        return [$sunday, $sunday->copy()->addDays(4)];
    }

    /**
     * Difference of two decimal columns as a decimal string.
     *
     * Done as strings because the driver hands these back as floats on SQLite,
     * and `0.1 + 0.2` is how a fil goes missing.
     */
    private static function subtract(int|float|string|null $amount, int|float|string|null $paid): string
    {
        $decimals = 2;
        $left = MobileMoney::toMinor(self::asDecimal($amount), $decimals);
        $right = MobileMoney::toMinor(self::asDecimal($paid), $decimals);
        $difference = max(0, $left - $right);

        // Rebuilt from the integer directly. Dividing by 100 to format it would
        // put the value back through a float, which is the one thing this whole
        // path exists to avoid.
        $scale = 10 ** $decimals;

        return intdiv($difference, $scale)
            .'.'
            .str_pad((string) ($difference % $scale), $decimals, '0', STR_PAD_LEFT);
    }

    /**
     * A mark as a stable two-decimal string.
     *
     * `decimal(6,2)` comes back as `88` on SQLite and `88.00` on PostgreSQL,
     * and a score that changes shape between environments is a score the
     * client renders differently in test and in production. Unlike money this
     * is a display format, not an exactness guarantee — a mark is not counted
     * in fils.
     */
    private static function mark(int|float|string|null $value): string
    {
        return sprintf('%.2F', (float) ($value ?? 0));
    }

    private static function asDecimal(int|float|string|null $value): string
    {
        if ($value === null) {
            return '0';
        }

        return is_float($value) ? sprintf('%.2F', $value) : (string) $value;
    }

    /** @return array<string, mixed> */
    private static function emptyAttendance(): array
    {
        return [
            'counts' => [],
            'recorded_days' => 0,
            'absent_days' => 0,
            'late_days' => 0,
            'present_percent' => null,
        ];
    }
}
