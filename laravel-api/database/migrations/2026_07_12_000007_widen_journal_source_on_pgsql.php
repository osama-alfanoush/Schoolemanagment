<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * The base accounting migration now declares journal_entries.source as a
 * string, so fresh databases (tests/CI on SQLite, new environments) need
 * nothing. This migration upgrades the already-deployed PostgreSQL database
 * in place: Laravel enum() on pgsql is varchar + a CHECK constraint, so we
 * only need to drop the constraint to allow the new source values
 * (purchase, supplier_payment, installment). All existing rows are preserved.
 */
return new class extends Migration
{
    public function up(): void
    {
        if (DB::getDriverName() === 'pgsql') {
            DB::statement('ALTER TABLE journal_entries DROP CONSTRAINT IF EXISTS journal_entries_source_check');
        }
    }

    public function down(): void
    {
        // Intentionally no-op: restoring the CHECK constraint would fail if
        // rows with new source values exist. Harmless to leave source as a
        // plain varchar.
    }
};
