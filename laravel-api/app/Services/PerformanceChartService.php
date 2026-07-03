<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Grade;
use Illuminate\Support\Carbon;

/**
 * Builds the "last 6 months, per-subject average %" performance chart for a
 * single student. Shared by the student and parent portals.
 *
 * Implementation notes:
 *  - Uses a SINGLE query (no per-subject / per-month N+1 loop).
 *  - Buckets by month in PHP rather than with driver-specific SQL date
 *    functions, so it is portable across PostgreSQL (production), MySQL and
 *    SQLite (local/tests). The previous student-portal version used SQLite's
 *    strftime() which throws on PostgreSQL.
 */
class PerformanceChartService
{
    /**
     * @return array{labels: list<string>, datasets: list<array{subject: string, data: list<float|null>}>}
     */
    public static function build(int $studentId, ?int $classRoomId): array
    {
        $months = collect(range(5, 0))->map(fn ($i) => now()->subMonths($i))->values();
        $labels = $months->map(fn (Carbon $m) => $m->format('M'))->all();

        if (! $classRoomId) {
            return ['labels' => $labels, 'datasets' => []];
        }

        $sixMonthsAgo = now()->subMonths(6)->startOfMonth();

        $rows = Grade::query()
            ->where('grades.student_user_id', $studentId)
            ->join('grade_components', 'grades.grade_component_id', '=', 'grade_components.id')
            ->join('subjects', 'grade_components.subject_id', '=', 'subjects.id')
            ->where('grade_components.class_room_id', $classRoomId)
            ->where('grades.created_at', '>=', $sixMonthsAgo)
            ->get([
                'subjects.name as subject_name',
                'grades.score as score',
                'grade_components.max_score as max_score',
                'grades.created_at as created_at',
            ]);

        // subject_name => month_key (Y-m) => ['sum' => float, 'count' => int]
        $buckets = [];
        foreach ($rows as $row) {
            $maxScore = (float) $row->max_score;
            if ($maxScore <= 0) {
                continue; // mirrors NULLIF(max_score, 0) — excluded from the average
            }
            $monthKey = Carbon::parse($row->created_at)->format('Y-m');
            $pct = (float) $row->score * 100.0 / $maxScore;
            $buckets[$row->subject_name][$monthKey]['sum'] = ($buckets[$row->subject_name][$monthKey]['sum'] ?? 0.0) + $pct;
            $buckets[$row->subject_name][$monthKey]['count'] = ($buckets[$row->subject_name][$monthKey]['count'] ?? 0) + 1;
        }

        $monthKeys = $months->map(fn (Carbon $m) => $m->format('Y-m'))->all();

        $datasets = [];
        foreach ($buckets as $subjectName => $monthData) {
            $data = [];
            foreach ($monthKeys as $key) {
                $bucket = $monthData[$key] ?? null;
                $data[] = ($bucket && $bucket['count'] > 0)
                    ? round($bucket['sum'] / $bucket['count'], 1)
                    : null;
            }
            $datasets[] = ['subject' => $subjectName, 'data' => $data];
        }

        return ['labels' => $labels, 'datasets' => $datasets];
    }
}
