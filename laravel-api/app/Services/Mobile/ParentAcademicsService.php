<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\AttendanceExplanation;
use App\Models\ReportCardIssue;
use App\Services\AuditLogger;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

/**
 * A child's attendance, marks and report cards, as a guardian may see them.
 *
 * One rule decides most of this file: **an unpublished thing is not visible,
 * and not merely hidden.** A mark whose gradebook is not finalized and a report
 * card that was never issued are both absent from the payload entirely, so
 * there is nothing for a client bug — or a curious parent with a proxy — to
 * reveal.
 */
final class ParentAcademicsService
{
    /**
     * Attendance over a window, with the detail a parent actually asks about.
     *
     * @return array<string, mixed>
     */
    public function attendance(int $childId, int $schoolId, Carbon $from, Carbon $to): array
    {
        $rows = DB::table('attendance_records')
            ->leftJoin('subjects', 'subjects.id', '=', 'attendance_records.subject_id')
            ->leftJoin(
                'attendance_explanations',
                'attendance_explanations.attendance_record_id',
                '=',
                'attendance_records.id',
            )
            ->where('attendance_records.school_id', $schoolId)
            ->where('attendance_records.student_user_id', $childId)
            ->whereBetween('attendance_records.date', [
                $from->toDateString(),
                $to->toDateString(),
            ])
            ->orderByDesc('attendance_records.date')
            ->get([
                'attendance_records.id',
                'attendance_records.date',
                'attendance_records.status',
                'attendance_records.note',
                'subjects.name as subject_name',
                'attendance_explanations.reason as explanation',
                'attendance_explanations.created_at as explained_at',
            ]);

        $counts = [];
        $days = [];

        foreach ($rows as $row) {
            $status = (string) $row->status;
            $counts[$status] = ($counts[$status] ?? 0) + 1;

            $days[] = [
                'id' => (int) $row->id,
                'date' => Carbon::parse($row->date)->toDateString(),
                'status' => $status,
                'subject' => $row->subject_name,
                // The teacher's own note. A guardian's explanation is a
                // separate field, because they are different claims by
                // different people.
                'note' => $row->note,
                'explanation' => $row->explanation,
                'explained_at' => $row->explained_at === null
                    ? null
                    : Carbon::parse($row->explained_at)->toIso8601String(),
                'explainable' => in_array($status, ['absent', 'late'], true)
                    && $row->explanation === null,
            ];
        }

        $recorded = array_sum($counts);
        $present = ($counts['present'] ?? 0)
            + ($counts['late'] ?? 0)
            + ($counts['excused'] ?? 0);

        return [
            'student_user_id' => $childId,
            'from' => $from->toDateString(),
            'to' => $to->toDateString(),
            // Cast explicitly. Without it the spec generator reads
            // `$counts['x'] ?? 0` as a union of the array's value type and the
            // literal 0, and emits an anyOf the Dart generator cannot compile.
            'recorded_days' => (int) $recorded,
            'absent_days' => (int) ($counts['absent'] ?? 0),
            'late_days' => (int) ($counts['late'] ?? 0),
            // Null, not 100%: a window with no register taken is not a window
            // of perfect attendance.
            'present_percent' => $recorded === 0
                ? null
                : (int) round($present * 100 / $recorded),
            'days' => $days,
        ];
    }

    /**
     * Published marks, grouped by subject.
     *
     * Only marks whose gradebook is `finalized`. A component with no gradebook
     * counts as unpublished: a teacher's working draft shown to a parent is the
     * failure that cannot be undone, so the unknown case fails closed.
     *
     * @return array<string, mixed>
     */
    public function grades(int $childId, int $schoolId): array
    {
        $rows = DB::table('grades')
            ->join('grade_components', 'grade_components.id', '=', 'grades.grade_component_id')
            ->join('gradebooks', 'gradebooks.id', '=', 'grade_components.gradebook_id')
            ->leftJoin('subjects', 'subjects.id', '=', 'grade_components.subject_id')
            ->leftJoin('grading_periods', 'grading_periods.id', '=', 'gradebooks.grading_period_id')
            ->where('grades.school_id', $schoolId)
            ->where('grades.student_user_id', $childId)
            ->where('gradebooks.state', 'finalized')
            ->orderBy('subjects.name')
            ->orderByDesc('grades.updated_at')
            ->get([
                'grades.id',
                'grades.score',
                'grades.updated_at',
                'grade_components.name as component_name',
                'grade_components.type as component_type',
                'grade_components.max_score',
                'grade_components.weight',
                'subjects.id as subject_id',
                'subjects.name as subject_name',
                'grading_periods.name as period_name',
            ]);

        $bySubject = [];

        foreach ($rows as $row) {
            $key = $row->subject_id === null ? 0 : (int) $row->subject_id;
            $bySubject[$key] ??= [
                'subject_id' => $key === 0 ? null : $key,
                'subject' => $row->subject_name,
                'components' => [],
                'scored_minor' => 0,
                'possible_minor' => 0,
            ];

            $score = self::hundredths($row->score);
            $max = self::hundredths($row->max_score);

            $bySubject[$key]['components'][] = [
                'id' => (int) $row->id,
                'name' => $row->component_name,
                'type' => $row->component_type,
                'period' => $row->period_name,
                'score' => self::mark($row->score),
                'max_score' => self::mark($row->max_score),
                'recorded_at' => Carbon::parse($row->updated_at)->toIso8601String(),
            ];

            $bySubject[$key]['scored_minor'] += $score;
            $bySubject[$key]['possible_minor'] += $max;
        }

        return [
            'student_user_id' => $childId,
            'subjects' => array_values(array_map(
                static function (array $subject): array {
                    // Integer arithmetic on hundredths, then one division for
                    // display. A running float average drifts.
                    $subject['percent'] = $subject['possible_minor'] === 0
                        ? null
                        : (int) round(
                            $subject['scored_minor'] * 100 / $subject['possible_minor']
                        );
                    unset($subject['scored_minor'], $subject['possible_minor']);

                    return $subject;
                },
                $bySubject,
            )),
        ];
    }

    /**
     * Report cards that have actually been issued for this child.
     *
     * Reads `report_card_issues`, not live marks. The existing web endpoint
     * renders the current grades on demand, which means it can show a report
     * card nobody ever issued; this one can only show what a member of staff
     * signed off, at the version they signed off.
     *
     * @return list<array<string, mixed>>
     */
    public function reportCards(int $childId, int $schoolId): array
    {
        $rows = DB::table('report_card_issues')
            ->join(
                'student_enrollments',
                'student_enrollments.id',
                '=',
                'report_card_issues.student_enrollment_id',
            )
            ->leftJoin(
                'grading_periods',
                'grading_periods.id',
                '=',
                'report_card_issues.grading_period_id',
            )
            ->where('report_card_issues.school_id', $schoolId)
            ->where('student_enrollments.student_user_id', $childId)
            ->orderByDesc('report_card_issues.issued_at')
            ->get([
                'report_card_issues.id',
                'report_card_issues.grading_period_id',
                'report_card_issues.issue_version',
                'report_card_issues.issued_at',
                'grading_periods.name as period_name',
            ]);

        $latest = [];

        foreach ($rows as $row) {
            $periodId = (int) $row->grading_period_id;
            // Ordered newest first, so the first row for a period is the
            // version in force. Older versions are corrections that have been
            // superseded and are not offered.
            if (isset($latest[$periodId])) {
                continue;
            }

            $latest[$periodId] = [
                'id' => (int) $row->id,
                'grading_period_id' => $periodId,
                'period' => $row->period_name,
                'version' => (int) $row->issue_version,
                'issued_at' => Carbon::parse($row->issued_at)->toIso8601String(),
            ];
        }

        return array_values($latest);
    }

    /**
     * One issued report card, if it belongs to one of [$childIds].
     *
     * @param  list<int>  $childIds
     */
    public function reportCard(int $issueId, array $childIds, int $schoolId): ?ReportCardIssue
    {
        if ($childIds === []) {
            return null;
        }

        return ReportCardIssue::query()
            ->whereKey($issueId)
            ->where('school_id', $schoolId)
            ->whereIn(
                'student_enrollment_id',
                DB::table('student_enrollments')
                    ->where('school_id', $schoolId)
                    ->whereIn('student_user_id', $childIds)
                    ->select('id'),
            )
            ->first();
    }

    /**
     * Files a guardian's explanation for one absence.
     *
     * Idempotent on the key, and it never touches the attendance status: only
     * the school decides whether an absence becomes excused.
     *
     * @return array{explanation: AttendanceExplanation, created: bool}
     */
    public function explainAbsence(
        Request $request,
        int $recordId,
        int $guardianId,
        int $schoolId,
        string $reason,
        string $idempotencyKey,
    ): array {
        $existing = AttendanceExplanation::query()
            ->where('idempotency_key', $idempotencyKey)
            ->first();

        if ($existing !== null) {
            return ['explanation' => $existing, 'created' => false];
        }

        try {
            $explanation = AttendanceExplanation::query()->create([
                'school_id' => $schoolId,
                'attendance_record_id' => $recordId,
                'guardian_user_id' => $guardianId,
                'reason' => $reason,
                'idempotency_key' => $idempotencyKey,
            ]);
        } catch (QueryException $e) {
            // Lost the race for the unique index; the winner is the answer.
            $winner = AttendanceExplanation::query()
                ->where('idempotency_key', $idempotencyKey)
                ->first();

            if ($winner === null) {
                throw $e;
            }

            return ['explanation' => $winner, 'created' => false];
        }

        // Identifiers only — the explanation's text is the family's business
        // and does not belong in an audit row.
        AuditLogger::log($request, 'attendance_explained', 'attendance_record', $recordId, [
            'explanation_id' => $explanation->id,
        ], $guardianId);

        return ['explanation' => $explanation, 'created' => true];
    }

    /** A `decimal(6,2)` as an integer number of hundredths. */
    private static function hundredths(int|float|string|null $value): int
    {
        return MobileMoney::toMinor(
            is_float($value) ? sprintf('%.2F', $value) : (string) ($value ?? '0'),
            2,
        );
    }

    /**
     * A mark as a stable two-decimal string.
     *
     * `decimal(6,2)` comes back as `88` on SQLite and `88.00` on PostgreSQL,
     * and a score that changes shape between environments is a score the client
     * renders differently in test and in production.
     */
    private static function mark(int|float|string|null $value): string
    {
        return sprintf('%.2F', (float) ($value ?? 0));
    }
}
