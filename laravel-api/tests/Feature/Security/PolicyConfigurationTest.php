<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\AuditLog;
use App\Services\CurrentSchool;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

/**
 * School policy is configuration, and the defaults have to be the safe ones.
 *
 * The case that motivates this file: audit:clean was scheduled daily and hard
 * deleted anything older than 90 days, on a framework default nobody had
 * approved, while the project's own retention inventory classified audit logs
 * as never-delete. These tests make the safe default a property of the system
 * rather than something that survives only until the next refactor.
 */
class PolicyConfigurationTest extends TestCase
{
    use RefreshDatabase;

    private function seedOldAuditLog(): AuditLog
    {
        return app(CurrentSchool::class)->run(1, function () {
            $log = AuditLog::query()->create([
                'user_id' => null,
                'action' => 'ancient_event',
                'entity_type' => 'user',
                'entity_id' => 1,
                'changes' => [],
                'ip' => '127.0.0.1',
                'user_agent' => 'test',
            ]);
            // Older than any plausible retention period.
            $log->forceFill(['created_at' => now()->subYears(3)])->saveQuietly();

            return $log;
        });
    }

    // ------------------------------------------------- retention is opt-in

    public function test_retention_is_not_approved_by_default(): void
    {
        $this->assertFalse(config('policy.retention.approved'));
        $this->assertNull(config('policy.retention.audit_log_days'));
        $this->assertNull(config('policy.retention.student_record_days'));
        $this->assertNull(config('policy.retention.financial_record_days'));
    }

    /**
     * The decisive one: the scheduled job must not destroy compliance evidence
     * because nobody changed a default.
     */
    public function test_audit_clean_deletes_nothing_without_an_approved_policy(): void
    {
        $log = $this->seedOldAuditLog();

        $this->artisan('audit:clean')
            ->expectsOutputToContain('no approved retention policy')
            ->assertExitCode(0);

        $this->assertDatabaseHas('audit_logs', ['id' => $log->id]);
    }

    public function test_audit_clean_keeps_everything_when_approved_but_no_period_is_set(): void
    {
        config(['policy.retention.approved' => true, 'policy.retention.audit_log_days' => null]);
        $log = $this->seedOldAuditLog();

        $this->artisan('audit:clean')->assertExitCode(0);

        $this->assertDatabaseHas('audit_logs', ['id' => $log->id]);
    }

    public function test_audit_clean_expires_only_once_a_period_is_approved(): void
    {
        config([
            'policy.retention.approved' => true,
            'policy.retention.audit_log_days' => 30,
            'policy.retention.approved_by' => 'Privacy officer 2026-08-15',
        ]);
        $log = $this->seedOldAuditLog();

        $this->artisan('audit:clean')->assertExitCode(0);

        $this->assertDatabaseMissing('audit_logs', ['id' => $log->id]);
    }

    /**
     * A manual run is a person acting deliberately, which is different from a
     * cron job acting on a default — but it still has to be explicit.
     */
    public function test_a_manual_expiry_run_requires_an_explicit_force(): void
    {
        $log = $this->seedOldAuditLog();

        $this->artisan('audit:clean --days=30')
            ->expectsOutputToContain('pass --force')
            ->assertExitCode(1);

        $this->assertDatabaseHas('audit_logs', ['id' => $log->id]);

        $this->artisan('audit:clean --days=30 --force')->assertExitCode(0);
        $this->assertDatabaseMissing('audit_logs', ['id' => $log->id]);
    }

    public function test_a_zero_or_negative_retention_period_is_refused(): void
    {
        $log = $this->seedOldAuditLog();

        $this->artisan('audit:clean --days=0 --force')->assertExitCode(1);

        $this->assertDatabaseHas('audit_logs', ['id' => $log->id]);
    }

    // ------------------------------------------------------- safe defaults

    public function test_erasure_is_not_implemented_and_legal_hold_would_veto_it(): void
    {
        $this->assertFalse(config('policy.erasure.enabled'));
        $this->assertTrue(config('policy.erasure.legal_hold_blocks_erasure'));
    }

    public function test_payroll_segregation_of_duty_defaults_to_enforced(): void
    {
        $this->assertTrue(config('policy.payroll.creator_cannot_approve'));
    }

    public function test_payroll_cancellation_is_not_claimed_to_exist(): void
    {
        // Only reversal is implemented. Advertising a cancellation the state
        // machine cannot perform would be worse than admitting the gap.
        $this->assertFalse(config('policy.payroll.cancellation_supported'));
    }

    public function test_multi_school_users_fail_closed_by_default(): void
    {
        $this->assertFalse(config('policy.tenancy.multi_school_users_allowed'));
    }

    public function test_attendance_corrections_require_a_reason_by_default(): void
    {
        $this->assertTrue(config('policy.attendance.admin_correction_requires_reason'));
        $this->assertGreaterThan(0, config('policy.attendance.edit_window_hours'));
    }

    // --------------------------------------------------------- policy:status

    public function test_policy_status_reports_undecided_items_and_blocks_the_pilot(): void
    {
        // Nothing is decided out of the box, and the continuity items are the
        // ones that must be settled before real data exists.
        $this->artisan('policy:status --stage=pilot')->assertExitCode(1);
    }

    public function test_policy_status_passes_once_the_blocking_items_are_decided(): void
    {
        putenv('BACKUP_RPO_MINUTES=1440');
        putenv('RESTORE_RTO_MINUTES=240');
        putenv('BACKUPS_ENCRYPTED_AT_REST=true');
        putenv('BACKUP_OFFSITE_LOCATION=s3://school-backups-offsite');
        config(['policy.continuity.backups_encrypted_at_rest' => true,
            'policy.continuity.offsite_location' => 's3://school-backups-offsite']);

        try {
            $this->artisan('policy:status --stage=pilot')->assertExitCode(0);
        } finally {
            foreach (['BACKUP_RPO_MINUTES', 'RESTORE_RTO_MINUTES', 'BACKUPS_ENCRYPTED_AT_REST', 'BACKUP_OFFSITE_LOCATION'] as $key) {
                putenv($key);
            }
        }
    }

    public function test_production_stage_also_requires_the_retention_decisions(): void
    {
        $this->artisan('policy:status --stage=production')->assertExitCode(1);
    }
}
