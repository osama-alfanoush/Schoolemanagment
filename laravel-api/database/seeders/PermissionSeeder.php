<?php

namespace Database\Seeders;

use App\Models\Permission;
use App\Models\RolePermission;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

/**
 * Seeds the granular permission catalogue and the default role grants.
 * Idempotent (updateOrCreate / firstOrCreate) — safe to re-run on deploy.
 *
 * Admin is NOT seeded: User::hasPermission() short-circuits for admin.
 */
class PermissionSeeder extends Seeder
{
    /** module => actions */
    private const MODULES = [
        'procurement' => ['view', 'create', 'edit', 'delete', 'approve', 'receive'],
        'finance.procurement' => ['view', 'create', 'edit', 'delete', 'approve'],
        'finance.installments' => ['view', 'create', 'edit', 'delete', 'approve'],
        'finance.payroll' => ['view', 'create', 'edit', 'delete', 'approve'],
        'finance.student' => ['view'],
        'finance.receipts' => ['view', 'create', 'approve', 'post', 'reverse'],
        'finance.adjustments' => ['view', 'create', 'approve', 'post', 'reverse'],
        'finance.journal' => ['view', 'create', 'approve', 'post', 'reverse'],
        'finance.reports' => ['view', 'export'],
        'hr.employees' => ['view', 'edit'],
        'hr.salary' => ['view', 'edit'],
        'hr.contracts' => ['view', 'manage', 'override'],
        'hr.warnings' => ['view', 'create', 'approve', 'cancel'],
        'hr.advances' => ['view', 'request', 'approve', 'disburse', 'settle'],
        'payroll.settings' => ['view', 'manage'],
        'payroll.runs' => ['view', 'create', 'process', 'approve', 'pay', 'reverse'],
        'payroll.payslips' => ['view', 'print'],
        'payroll.reports' => ['view', 'export'],
    ];

    /** role => permission keys ('module.*' expands to every action) */
    private const ROLE_GRANTS = [
        // Accountant: full finance, read-only procurement visibility.
        'finance' => [
            'finance.procurement.*', 'finance.installments.*', 'finance.payroll.*',
            'finance.student.*', 'finance.receipts.*', 'finance.adjustments.*',
            'finance.journal.*', 'finance.reports.*',
            'hr.advances.view', 'hr.advances.approve', 'hr.advances.disburse', 'hr.advances.settle',
            'payroll.settings.view', 'payroll.runs.view', 'payroll.runs.approve', 'payroll.runs.pay',
            'payroll.runs.reverse', 'payroll.payslips.*', 'payroll.reports.*',
            'procurement.view',
        ],
        // Procurement Officer: full procurement, can register supplier invoices.
        'procurement' => [
            'procurement.*',
            'finance.procurement.view', 'finance.procurement.create',
        ],
        // HR prepares payroll but cannot approve or delete runs.
        'hr' => [
            'finance.payroll.view', 'finance.payroll.create', 'finance.payroll.edit',
            'hr.employees.*', 'hr.salary.*', 'hr.contracts.*', 'hr.warnings.*',
            'hr.advances.view', 'hr.advances.request', 'payroll.settings.*',
            'payroll.runs.view', 'payroll.runs.create', 'payroll.runs.process',
            'payroll.payslips.*', 'payroll.reports.*',
        ],
        // Warehouse posts goods receipts (stock in) but cannot approve POs.
        'warehouse' => [
            'procurement.view', 'procurement.receive',
        ],
    ];

    public function run(): void
    {
        $byKey = [];
        foreach (self::MODULES as $module => $actions) {
            foreach ($actions as $action) {
                $key = "{$module}.{$action}";
                $byKey[$key] = Permission::updateOrCreate(
                    ['key' => $key],
                    ['module' => $module, 'action' => $action,
                        'description' => ucfirst($action)." access for {$module}"]
                );
            }
        }

        foreach (DB::table('schools')->pluck('id') as $schoolId) {
            foreach (self::ROLE_GRANTS as $role => $grants) {
                foreach ($grants as $grant) {
                    foreach ($this->expand($grant, $byKey) as $key) {
                        RolePermission::withoutGlobalScope('school')->firstOrCreate([
                            'school_id' => $schoolId,
                            'role' => $role,
                            'permission_id' => $byKey[$key]->id,
                        ]);
                    }
                }
                Permission::clearRoleCache($role);
            }
        }
    }

    /** @return string[] */
    private function expand(string $grant, array $byKey): array
    {
        if (! str_ends_with($grant, '.*')) {
            return [$grant];
        }
        $module = substr($grant, 0, -2);

        return array_map(
            fn ($action) => "{$module}.{$action}",
            self::MODULES[$module]
        );
    }
}
