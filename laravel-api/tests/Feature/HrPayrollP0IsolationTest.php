<?php

namespace Tests\Feature;

use App\Models\FinancialClosing;
use App\Models\HrPayrollSetting;
use App\Models\JournalBatch;
use App\Models\PayrollRecord;
use App\Models\PayrollRun;
use App\Models\School;
use App\Models\StaffProfile;
use App\Models\User;
use Database\Seeders\PermissionSeeder;
use Illuminate\Database\QueryException;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class HrPayrollP0IsolationTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        $this->seed(PermissionSeeder::class);
    }

    private function actor(string $role, int $schoolId): User
    {
        $user = User::factory()->create(['role' => $role]);
        $user->schoolRoles()->delete();
        $user->schoolRoles()->create(['school_id' => $schoolId, 'role' => $role]);

        return $user;
    }

    private function employee(int $schoolId, float $salary = 1000): StaffProfile
    {
        $user = $this->actor('teacher', $schoolId);

        return StaffProfile::create([
            'user_id' => $user->id, 'school_id' => $schoolId, 'employee_no' => 'EMP-'.$user->id,
            'employment_status' => 'active', 'hire_date' => '2025-01-01', 'base_salary' => $salary,
        ]);
    }

    private function secondSchool(): School
    {
        $default = School::firstOrFail();
        $school = School::create([
            'organization_id' => $default->organization_id, 'name' => 'Second School',
            'code' => 'SECOND', 'timezone' => 'UTC', 'is_active' => true,
        ]);
        $this->seed(PermissionSeeder::class);
        foreach (['hr_payroll_settings', 'payroll_account_settings'] as $table) {
            $source = (array) DB::table($table)->first();
            unset($source['id']);
            $source['school_id'] = $school->id;
            $source['scope_key'] = 'school:'.$school->id;
            DB::table($table)->insert($source);
        }

        return $school;
    }

    private function createRun(User $actor, int $year = 2026, int $month = 8): int
    {
        return $this->actingAs($actor)->postJson('/api/finance/payroll/runs', compact('year', 'month'))
            ->assertCreated()->json('id');
    }

    public function test_run_contains_only_staff_from_actor_school(): void
    {
        $a = School::firstOrFail();
        $b = $this->secondSchool();
        $this->employee($a->id);
        $this->employee($b->id);
        $hr = $this->actor('hr', $a->id);
        $run = $this->createRun($hr);

        $this->assertSame(1, PayrollRecord::where('payroll_run_id', $run)->count());
        $this->assertTrue(PayrollRecord::where('payroll_run_id', $run)->where('school_id', $a->id)->exists());
    }

    public function test_client_supplied_school_id_is_ignored(): void
    {
        $a = School::firstOrFail();
        $b = $this->secondSchool();
        $this->employee($a->id);
        $hr = $this->actor('hr', $a->id);
        $id = $this->actingAs($hr)->postJson('/api/finance/payroll/runs', ['year' => 2026, 'month' => 8, 'school_id' => $b->id])
            ->assertCreated()->json('id');

        $this->assertDatabaseHas('payroll_runs', ['id' => $id, 'school_id' => $a->id]);
    }

    public function test_cross_school_run_read_and_transition_are_denied(): void
    {
        $a = School::firstOrFail();
        $b = $this->secondSchool();
        $this->employee($b->id);
        $run = $this->createRun($this->actor('hr', $b->id));
        $foreign = $this->actor('hr', $a->id);

        $this->actingAs($foreign)->getJson("/api/finance/payroll/runs/{$run}")->assertNotFound();
        $this->actingAs($foreign)->postJson("/api/finance/payroll/runs/{$run}/process")->assertNotFound();
    }

    public function test_database_rejects_a_second_active_employee_record_for_period(): void
    {
        $school = School::firstOrFail();
        $profile = $this->employee($school->id);
        $run = $this->createRun($this->actor('hr', $school->id));
        $existing = PayrollRecord::where('payroll_run_id', $run)->firstOrFail();

        $this->expectException(QueryException::class);
        PayrollRecord::create($existing->only(['school_id', 'staff_user_id', 'year', 'month', 'base_salary', 'net_pay', 'status']));
    }

    public function test_reversed_record_allows_exactly_one_replacement_run(): void
    {
        $school = School::firstOrFail();
        $this->employee($school->id);
        $hr = $this->actor('hr', $school->id);
        $first = $this->createRun($hr);
        PayrollRecord::where('payroll_run_id', $first)->update(['status' => 'reversed']);
        PayrollRun::whereKey($first)->update(['status' => 'reversed']);
        $this->assertSame('reversed', PayrollRecord::where('payroll_run_id', $first)->value('status'));
        $this->assertSame('reversed', PayrollRun::whereKey($first)->value('status'));

        $second = $this->createRun($hr);
        $this->assertNotSame($first, $second);
        $this->actingAs($hr)->postJson('/api/finance/payroll/runs', ['year' => 2026, 'month' => 8])->assertStatus(422);
    }

    public function test_processing_retry_does_not_repeat_effects(): void
    {
        $school = School::firstOrFail();
        $this->employee($school->id);
        $hr = $this->actor('hr', $school->id);
        $run = $this->createRun($hr);

        $this->actingAs($hr)->postJson("/api/finance/payroll/runs/{$run}/process")->assertOk();
        $this->actingAs($hr)->postJson("/api/finance/payroll/runs/{$run}/process")->assertStatus(422);
        $this->assertSame(1, PayrollRecord::where('payroll_run_id', $run)->count());
    }

    public function test_pay_before_approval_is_rejected(): void
    {
        $school = School::firstOrFail();
        $this->employee($school->id);
        $run = $this->createRun($this->actor('hr', $school->id));
        $this->actingAs($this->actor('finance', $school->id))->postJson("/api/finance/payroll/runs/{$run}/pay")->assertStatus(422);
        $this->assertNull(PayrollRun::findOrFail($run)->payment_journal_batch_id);
    }

    public function test_closed_school_period_blocks_transition(): void
    {
        $school = School::firstOrFail();
        $this->employee($school->id);
        $hr = $this->actor('hr', $school->id);
        $run = $this->createRun($hr);
        FinancialClosing::create(['school_id' => $school->id, 'year' => 2026, 'month' => 8, 'status' => 'closed']);

        $this->actingAs($hr)->postJson("/api/finance/payroll/runs/{$run}/process")->assertStatus(422);
    }

    public function test_legacy_payroll_writers_return_clear_unsupported_error(): void
    {
        $finance = $this->actor('finance', School::firstOrFail()->id);
        $this->actingAs($finance)->postJson('/api/finance/payroll/process', ['year' => 2026, 'month' => 8])
            ->assertStatus(410)->assertJsonPath('code', 'LEGACY_PAYROLL_WRITE_DISABLED');
        $this->actingAs($finance)->patchJson('/api/finance/payroll/999/pay')
            ->assertStatus(410)->assertJsonPath('code', 'LEGACY_PAYROLL_WRITE_DISABLED');
    }

    public function test_payroll_reports_are_filtered_by_actor_school(): void
    {
        $a = School::firstOrFail();
        $b = $this->secondSchool();
        $this->employee($a->id);
        $this->employee($b->id);
        $runA = $this->createRun($this->actor('hr', $a->id));
        $this->createRun($this->actor('hr', $b->id));

        $response = $this->actingAs($this->actor('hr', $a->id))->getJson('/api/hr/payroll-reports/payroll')->assertOk();
        $this->assertSame([$runA], collect($response->json('data'))->pluck('id')->all());
    }

    public function test_approval_posts_one_balanced_same_school_journal(): void
    {
        $school = School::firstOrFail();
        $this->employee($school->id);
        $hr = $this->actor('hr', $school->id);
        $finance = $this->actor('finance', $school->id);
        $run = $this->createRun($hr);
        $this->actingAs($hr)->postJson("/api/finance/payroll/runs/{$run}/process")->assertOk();
        $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$run}/approve")->assertOk();
        $this->actingAs($finance)->postJson("/api/finance/payroll/runs/{$run}/approve")->assertStatus(422);

        $batch = JournalBatch::with('lines')->where('source', 'payroll_accrual')->where('source_id', $run)->sole();
        $this->assertSame($school->id, $batch->school_id);
        $this->assertSame($batch->lines->where('type', 'debit')->sum('amount'), $batch->lines->where('type', 'credit')->sum('amount'));
        $this->assertTrue($batch->lines->every(fn ($line) => $line->school_id === $school->id));
    }

    public function test_settings_endpoint_cannot_read_another_school_configuration(): void
    {
        $a = School::firstOrFail();
        $b = $this->secondSchool();
        HrPayrollSetting::where('school_id', $a->id)->update(['currency' => 'AAA']);
        HrPayrollSetting::where('school_id', $b->id)->update(['currency' => 'BBB']);

        $this->actingAs($this->actor('hr', $a->id))->getJson('/api/finance/payroll/settings')
            ->assertOk()->assertJsonPath('general.currency', 'AAA');
    }
}
