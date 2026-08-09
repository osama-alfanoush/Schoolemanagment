<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        if (DB::getDriverName() !== 'pgsql') {
            return;
        }
        DB::statement('CREATE EXTENSION IF NOT EXISTS btree_gist');
        DB::statement("ALTER TABLE student_enrollments ADD CONSTRAINT enrollment_dates_no_overlap EXCLUDE USING gist (student_user_id WITH =, school_id WITH =, daterange(start_date, COALESCE(end_date, DATE '9999-12-31'), '[]') WITH &&) WHERE (status IN ('accepted','active','transferred','withdrawn','graduated'))");
    }

    public function down(): void
    {
        if (DB::getDriverName() === 'pgsql') {
            DB::statement('ALTER TABLE student_enrollments DROP CONSTRAINT IF EXISTS enrollment_dates_no_overlap');
        }
    }
};
