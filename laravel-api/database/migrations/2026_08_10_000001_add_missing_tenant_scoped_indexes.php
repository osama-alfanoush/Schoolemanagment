<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

/**
 * Every school-owned model carries a global scope that appends
 * `where school_id = ?` to each query, so school_id is the leading predicate on
 * effectively all tenant traffic. 16 tables had no index leading with it, which
 * degrades to a sequential scan on the whole tenant table as soon as a second
 * school exists.
 *
 * Composite pairs are chosen from the filters the modules actually apply next
 * (list-by-class, list-by-employee, list-by-date, active-record lookups) so one
 * index serves both the tenant filter and the common secondary predicate.
 *
 * Runs outside a transaction on PostgreSQL so CREATE INDEX CONCURRENTLY can be
 * used: on a populated production table a plain CREATE INDEX takes an ACCESS
 * EXCLUSIVE lock and blocks writes for the duration of the build.
 */
return new class extends Migration
{
    public $withinTransaction = false;

    /** @var array<string, list<string>> */
    private array $indexes = [
        'academic_years' => ['school_id', 'is_active'],
        'announcements' => ['school_id', 'created_at'],
        'attendance_submission_batches' => ['school_id', 'class_room_id'],
        'class_rooms' => ['school_id', 'academic_year_id'],
        'employee_advance_installments' => ['school_id', 'employee_advance_id'],
        'gradebooks' => ['school_id', 'state'],
        'hr_payroll_settings' => ['school_id'],
        'hr_requests' => ['school_id', 'status'],
        'invoice_generation_batches' => ['school_id', 'billing_period_id'],
        'payroll_account_settings' => ['school_id'],
        'payroll_components' => ['school_id', 'code'],
        'payroll_record_components' => ['school_id', 'payroll_record_id'],
        'social_insurance_schemes' => ['school_id', 'scheme_code'],
        'staff_attendance' => ['school_id', 'date'],
        'staff_payroll_components' => ['school_id', 'staff_user_id'],
        'student_enrollments' => ['school_id', 'class_room_id'],
    ];

    public function up(): void
    {
        foreach ($this->indexes as $table => $columns) {
            if (! Schema::hasTable($table)) {
                continue;
            }
            $columns = array_values(array_filter(
                $columns,
                fn (string $column) => Schema::hasColumn($table, $column)
            ));
            if ($columns === []) {
                continue;
            }

            $this->createIndex($table, $columns);
        }
    }

    public function down(): void
    {
        foreach ($this->indexes as $table => $columns) {
            $name = $this->indexName($table, $columns);
            if (! Schema::hasTable($table)) {
                continue;
            }

            if (DB::connection()->getDriverName() === 'pgsql') {
                DB::statement('DROP INDEX CONCURRENTLY IF EXISTS '.$name);

                continue;
            }

            try {
                Schema::table($table, fn (Blueprint $t) => $t->dropIndex($name));
            } catch (Throwable) {
                // Index absent (partial rollback or older schema) — nothing to undo.
            }
        }
    }

    /**
     * @param  list<string>  $columns
     */
    private function createIndex(string $table, array $columns): void
    {
        $name = $this->indexName($table, $columns);

        if (DB::connection()->getDriverName() === 'pgsql') {
            DB::statement(sprintf(
                'CREATE INDEX CONCURRENTLY IF NOT EXISTS %s ON %s (%s)',
                $name,
                $table,
                implode(', ', $columns)
            ));

            return;
        }

        try {
            Schema::table($table, fn (Blueprint $t) => $t->index($columns, $name));
        } catch (Throwable) {
            // SQLite/MySQL: an equivalent index already exists.
        }
    }

    /**
     * @param  list<string>  $columns
     */
    private function indexName(string $table, array $columns): string
    {
        // Postgres truncates identifiers at 63 bytes; hash long names instead of
        // letting two tables collide on a silently truncated identifier.
        $name = $table.'_'.implode('_', $columns).'_idx';

        return strlen($name) <= 63 ? $name : substr($table, 0, 40).'_'.substr(md5($name), 0, 16).'_idx';
    }
};
