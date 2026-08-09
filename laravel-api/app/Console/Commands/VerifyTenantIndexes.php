<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

/**
 * Structural guard for the multi-tenant data model.
 *
 * Every school-owned model carries a global scope that appends
 * `where school_id = ?`, so a tenant table without an index leading on
 * school_id degrades to a full scan of all tenants' rows. This fails CI when a
 * new migration adds such a table, which is far cheaper than discovering it
 * from production latency after the second school onboards.
 */
class VerifyTenantIndexes extends Command
{
    protected $signature = 'tenancy:verify-indexes';

    protected $description = 'Fail when a table with school_id has no index leading on school_id';

    public function handle(): int
    {
        if (DB::connection()->getDriverName() !== 'pgsql') {
            $this->warn('tenancy:verify-indexes only runs against PostgreSQL; skipping.');

            return self::SUCCESS;
        }

        $tables = DB::table('information_schema.columns')
            ->where('table_schema', 'public')
            ->where('column_name', 'school_id')
            ->distinct()
            ->orderBy('table_name')
            ->pluck('table_name');

        $missing = [];
        foreach ($tables as $table) {
            $indexed = DB::selectOne(
                'select 1 as ok
                   from pg_index x
                   join pg_class ct on ct.oid = x.indrelid
                   join pg_attribute a on a.attrelid = ct.oid and a.attnum = x.indkey[0]
                  where ct.relname = ? and a.attname = ?
                  limit 1',
                [$table, 'school_id']
            );

            if (! $indexed) {
                $missing[] = $table;
            }
        }

        $this->info('Checked '.$tables->count().' tenant table(s).');

        if ($missing === []) {
            $this->info('✅ Every table with school_id has an index leading on school_id.');

            return self::SUCCESS;
        }

        foreach ($missing as $table) {
            $this->error('❌ '.$table.' has school_id but no index leading on it.');
        }
        $this->error('Add the index in a migration (see 2026_08_10_000001_add_missing_tenant_scoped_indexes).');

        return self::FAILURE;
    }
}
