<?php

namespace Tests\Postgres;

use App\Models\User;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class ConcurrencyTest extends TestCase
{
    private int $studentId;

    private int $teacherId;

    private int $schoolId;

    private int $yearId;

    private int $classId;

    private int $subjectId;

    protected function setUp(): void
    {
        parent::setUp();
        foreach (['payroll_record_components', 'employee_advance_installments', 'payroll_records', 'payroll_runs', 'attendance_records', 'grade_change_history', 'grades', 'grade_components', 'student_enrollments'] as $table) {
            DB::table($table)->delete();
        }
        $this->studentId = User::factory()->student()->create()->id;
        $this->teacherId = User::factory()->teacher()->create()->id;
        $this->schoolId = (int) DB::table('schools')->value('id');
        $this->yearId = DB::table('academic_years')->insertGetId([
            'school_id' => $this->schoolId, 'name' => uniqid('year-'), 'start_date' => '2026-09-01',
            'end_date' => '2027-06-30', 'is_current' => false, 'created_at' => now(), 'updated_at' => now(),
        ]);
        $this->classId = DB::table('class_rooms')->insertGetId([
            'school_id' => $this->schoolId, 'academic_year_id' => $this->yearId, 'name' => uniqid('class-'),
            'grade' => '7', 'capacity' => 30, 'created_at' => now(), 'updated_at' => now(),
        ]);
        $this->subjectId = DB::table('subjects')->insertGetId([
            'school_id' => $this->schoolId, 'name' => uniqid('Math-'), 'code' => uniqid('M-'),
            'created_at' => now(), 'updated_at' => now(),
        ]);
    }

    public function test_only_one_concurrent_grade_compare_and_swap_wins(): void
    {
        $component = DB::table('grade_components')->insertGetId([
            'school_id' => $this->schoolId, 'class_room_id' => $this->classId, 'subject_id' => $this->subjectId, 'name' => 'Final',
            'type' => 'exam', 'weight' => 100, 'max_score' => 100, 'created_at' => now(), 'updated_at' => now(),
        ]);
        $grade = DB::table('grades')->insertGetId([
            'school_id' => $this->schoolId, 'student_user_id' => $this->studentId, 'grade_component_id' => $component, 'score' => 70,
            'entered_by' => $this->teacherId, 'version' => 1, 'created_at' => now(), 'updated_at' => now(),
        ]);
        $codes = $this->runWorkers([['grade', $grade, 80], ['grade', $grade, 90]]);
        sort($codes);
        $this->assertSame([0, 10], $codes);
        $this->assertSame(2, (int) DB::table('grades')->where('id', $grade)->value('version'));
    }

    public function test_concurrent_attendance_upserts_produce_one_row(): void
    {
        $args = ['attendance', $this->schoolId, $this->studentId, $this->classId, '2026-09-10'];
        $codes = $this->runWorkers([array_merge($args, ['present', $this->teacherId]), array_merge($args, ['absent', $this->teacherId])]);
        $this->assertSame([0, 0], $codes);
        $this->assertSame(1, DB::table('attendance_records')->where('student_user_id', $this->studentId)->where('date', '2026-09-10')->count());
        $this->assertSame(2, (int) DB::table('attendance_records')->where('student_user_id', $this->studentId)->value('version'));
    }

    public function test_concurrent_overlapping_enrollments_are_rejected_by_postgresql(): void
    {
        $base = ['enrollment', $this->studentId, $this->schoolId, $this->yearId, $this->classId];
        $codes = $this->runWorkers([
            array_merge($base, ['2026-09-01', '2027-01-31']),
            array_merge($base, ['2027-01-01', '2027-06-30']),
        ]);
        sort($codes);
        $this->assertSame([0, 10], $codes);
        $this->assertSame(1, DB::table('student_enrollments')->where('student_user_id', $this->studentId)->count());
    }

    public function test_concurrent_payroll_writers_produce_one_active_employee_record(): void
    {
        $staffId = User::factory()->teacher()->create()->id;
        $runId = DB::table('payroll_runs')->insertGetId([
            'run_no' => uniqid('RUN-PG-'), 'scope_key' => 'school:'.$this->schoolId,
            'school_id' => $this->schoolId, 'year' => 2026, 'month' => 8, 'status' => 'draft',
            'created_at' => now(), 'updated_at' => now(),
        ]);
        $args = ['payroll', $this->schoolId, $staffId, $runId, 2026, 8];
        $codes = $this->runWorkers([$args, $args]);
        sort($codes);

        $this->assertSame([0, 10], $codes);
        $this->assertSame(1, DB::table('payroll_records')->where('school_id', $this->schoolId)
            ->where('staff_user_id', $staffId)->where('year', 2026)->where('month', 8)->count());
    }

    private function runWorkers(array $workerArgs): array
    {
        $processes = [];
        foreach ($workerArgs as $args) {
            $pipes = [];
            $php = [PHP_BINARY];
            $windowsDriver = dirname(PHP_BINARY).'/ext/php_pdo_pgsql.dll';
            if (PHP_OS_FAMILY === 'Windows' && is_file($windowsDriver)) {
                array_push($php, '-d', 'extension_dir='.dirname($windowsDriver), '-d', 'extension=php_pdo_pgsql.dll');
            }
            $process = proc_open(array_merge($php, [__DIR__.'/concurrency_worker.php'], array_map('strval', $args)), [1 => ['pipe', 'w'], 2 => ['pipe', 'w']], $pipes);
            $this->assertIsResource($process);
            $processes[] = [$process, $pipes];
        }
        $codes = [];
        foreach ($processes as [$process, $pipes]) {
            $output = '';
            foreach ($pipes as $pipe) {
                $output .= stream_get_contents($pipe);
                fclose($pipe);
            }
            $code = proc_close($process);
            if ($code === 20) {
                $this->fail('Concurrency worker failed: '.trim($output));
            }
            $codes[] = $code;
        }

        return $codes;
    }
}
