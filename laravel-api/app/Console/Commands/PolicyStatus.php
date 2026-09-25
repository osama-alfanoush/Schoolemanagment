<?php

declare(strict_types=1);

namespace App\Console\Commands;

use Illuminate\Console\Command;

/**
 * Reports which school policies are still undecided.
 *
 * The point is that "we never decided" and "we decided to keep the default"
 * look identical in a config file six months later. This separates them: an
 * item is DECIDED only when someone has set it deliberately, and the ones that
 * would block a pilot or a general launch are named as such.
 *
 * Exit codes let this be used as a launch gate:
 *   0  nothing outstanding blocks the requested stage
 *   1  at least one blocking decision is outstanding
 */
class PolicyStatus extends Command
{
    protected $signature = 'policy:status
        {--stage=pilot : Which launch stage to judge against (pilot|production)}
        {--json : Emit machine-readable JSON}';

    protected $description = 'Report undecided school policy items and whether they block a launch stage';

    /**
     * @return array<int, array{key: string, decided: bool, value: string, blocks: string, owner: string}>
     */
    private function items(): array
    {
        $set = fn (string $env) => env($env) !== null;

        return [
            [
                'key' => 'retention.approved',
                'decided' => (bool) config('policy.retention.approved'),
                'value' => config('policy.retention.approved') ? 'approved by '.(config('policy.retention.approved_by') ?: 'unnamed') : 'not approved — nothing expires',
                'blocks' => 'production',
                'owner' => 'Privacy officer + legal reviewer',
            ],
            [
                'key' => 'retention.audit_log_days',
                'decided' => config('policy.retention.audit_log_days') !== null,
                'value' => config('policy.retention.audit_log_days') === null ? 'indefinite' : config('policy.retention.audit_log_days').' days',
                'blocks' => 'production',
                'owner' => 'Privacy officer',
            ],
            [
                'key' => 'retention.student_record_days',
                'decided' => config('policy.retention.student_record_days') !== null,
                'value' => config('policy.retention.student_record_days') === null ? 'indefinite' : config('policy.retention.student_record_days').' days',
                'blocks' => 'production',
                'owner' => 'Privacy officer + registrar',
            ],
            [
                'key' => 'retention.financial_record_days',
                'decided' => config('policy.retention.financial_record_days') !== null,
                'value' => config('policy.retention.financial_record_days') === null ? 'indefinite' : config('policy.retention.financial_record_days').' days',
                'blocks' => 'production',
                'owner' => 'Finance owner',
            ],
            [
                'key' => 'erasure.enabled',
                'decided' => (bool) config('policy.erasure.enabled'),
                'value' => config('policy.erasure.enabled') ? 'enabled' : 'not implemented — deactivation only',
                'blocks' => 'production',
                'owner' => 'Privacy officer + legal reviewer',
            ],
            [
                'key' => 'continuity.rpo_minutes',
                'decided' => $set('BACKUP_RPO_MINUTES'),
                'value' => config('policy.continuity.rpo_minutes').' minutes'.($set('BACKUP_RPO_MINUTES') ? '' : ' (engineering default)'),
                'blocks' => 'pilot',
                'owner' => 'Platform owner + school operations owner',
            ],
            [
                'key' => 'continuity.rto_minutes',
                'decided' => $set('RESTORE_RTO_MINUTES'),
                'value' => config('policy.continuity.rto_minutes').' minutes'.($set('RESTORE_RTO_MINUTES') ? '' : ' (engineering default)'),
                'blocks' => 'pilot',
                'owner' => 'Platform owner + school operations owner',
            ],
            [
                'key' => 'continuity.backups_encrypted_at_rest',
                'decided' => config('policy.continuity.backups_encrypted_at_rest') !== null,
                'value' => match (config('policy.continuity.backups_encrypted_at_rest')) {
                    true => 'yes',
                    false => 'NO — dumps are unencrypted at rest',
                    default => 'unknown',
                },
                'blocks' => 'pilot',
                'owner' => 'Platform owner',
            ],
            [
                'key' => 'continuity.offsite_location',
                'decided' => filled(config('policy.continuity.offsite_location')),
                'value' => config('policy.continuity.offsite_location') ?: 'none — backups exist only beside the database',
                'blocks' => 'pilot',
                'owner' => 'Platform owner',
            ],
            [
                'key' => 'payroll.creator_cannot_approve',
                'decided' => $set('PAYROLL_CREATOR_CANNOT_APPROVE'),
                'value' => config('policy.payroll.creator_cannot_approve') ? 'enforced' : 'NOT enforced',
                'blocks' => 'payroll-use',
                'owner' => 'Finance owner',
            ],
            [
                'key' => 'attendance.edit_window_hours',
                'decided' => $set('ATTENDANCE_EDIT_WINDOW_HOURS'),
                'value' => config('policy.attendance.edit_window_hours').'h'.($set('ATTENDANCE_EDIT_WINDOW_HOURS') ? '' : ' (engineering default)'),
                'blocks' => 'attendance-use',
                'owner' => 'Attendance officer',
            ],
            [
                'key' => 'grades.reopen_after_finalize',
                'decided' => $set('GRADES_REOPEN_AFTER_FINALIZE'),
                'value' => config('policy.grades.reopen_after_finalize') ? 'administrators may reopen' : 'finalized is immutable',
                'blocks' => 'grading-use',
                'owner' => 'Academic registrar',
            ],
            [
                'key' => 'tenancy.multi_school_users_allowed',
                'decided' => $set('MULTI_SCHOOL_USERS_ALLOWED'),
                'value' => config('policy.tenancy.multi_school_users_allowed') ? 'allowed' : 'denied (fail closed)',
                'blocks' => 'none',
                'owner' => 'Platform owner',
            ],
        ];
    }

    public function handle(): int
    {
        $stage = (string) $this->option('stage');
        $items = $this->items();

        $blocking = array_values(array_filter(
            $items,
            fn ($i) => ! $i['decided'] && ($i['blocks'] === $stage || ($stage === 'production' && $i['blocks'] === 'pilot'))
        ));

        if ($this->option('json')) {
            $this->line(json_encode([
                'stage' => $stage,
                'undecided' => count(array_filter($items, fn ($i) => ! $i['decided'])),
                'blocking' => count($blocking),
                'items' => $items,
            ], JSON_PRETTY_PRINT | JSON_THROW_ON_ERROR));

            return $blocking === [] ? self::SUCCESS : self::FAILURE;
        }

        $this->line(sprintf('%-42s %-9s %-14s %s', 'POLICY', 'STATE', 'BLOCKS', 'CURRENT'));
        foreach ($items as $i) {
            $line = sprintf('%-42s %-9s %-14s %s', $i['key'], $i['decided'] ? 'decided' : 'UNDECIDED', $i['blocks'], $i['value']);
            $i['decided'] ? $this->info($line) : $this->warn($line);
        }

        $this->newLine();
        if ($blocking === []) {
            $this->info("No undecided policy blocks the [{$stage}] stage.");

            return self::SUCCESS;
        }

        foreach ($blocking as $i) {
            $this->error("BLOCKS {$stage}: {$i['key']} — owner: {$i['owner']}");
        }

        return self::FAILURE;
    }
}
