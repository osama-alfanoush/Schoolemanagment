<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('timetable_entries', function (Blueprint $table) {
            $table->foreignId('term_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('course_section_id')->nullable()->constrained()->restrictOnDelete();
            $table->date('effective_start')->nullable();
            $table->date('effective_end')->nullable();
            $table->string('week_pattern', 30)->default('weekly');
            $table->unsignedSmallInteger('rotation_week')->default(1);
            $table->unsignedSmallInteger('start_minute')->nullable();
            $table->unsignedSmallInteger('end_minute')->nullable();
        });

        DB::table('timetable_entries')->orderBy('id')->each(function ($entry) {
            [$startHour, $startMinute] = array_map('intval', explode(':', $entry->start_time));
            [$endHour, $endMinute] = array_map('intval', explode(':', $entry->end_time));
            DB::table('timetable_entries')->where('id', $entry->id)->update([
                'start_minute' => $startHour * 60 + $startMinute,
                'end_minute' => $endHour * 60 + $endMinute,
            ]);
        });

        if (DB::getDriverName() === 'pgsql') {
            DB::statement('CREATE EXTENSION IF NOT EXISTS btree_gist');
            $dateRange = "daterange(COALESCE(effective_start, DATE '1900-01-01'), COALESCE(effective_end, DATE '9999-12-31'), '[]')";
            $timeRange = "int4range(start_minute::integer, end_minute::integer, '[)')";
            DB::statement("ALTER TABLE timetable_entries ADD CONSTRAINT timetable_teacher_no_overlap EXCLUDE USING gist (school_id WITH =, teacher_user_id WITH =, day_of_week WITH =, week_pattern WITH =, rotation_week WITH =, {$dateRange} WITH &&, {$timeRange} WITH &&)");
            DB::statement("ALTER TABLE timetable_entries ADD CONSTRAINT timetable_class_no_overlap EXCLUDE USING gist (school_id WITH =, class_room_id WITH =, day_of_week WITH =, week_pattern WITH =, rotation_week WITH =, {$dateRange} WITH &&, {$timeRange} WITH &&)");
            DB::statement("ALTER TABLE timetable_entries ADD CONSTRAINT timetable_room_no_overlap EXCLUDE USING gist (school_id WITH =, room WITH =, day_of_week WITH =, week_pattern WITH =, rotation_week WITH =, {$dateRange} WITH &&, {$timeRange} WITH &&) WHERE (room IS NOT NULL)");
        }
    }

    public function down(): void
    {
        if (DB::getDriverName() === 'pgsql') {
            foreach (['timetable_teacher_no_overlap', 'timetable_class_no_overlap', 'timetable_room_no_overlap'] as $constraint) {
                DB::statement("ALTER TABLE timetable_entries DROP CONSTRAINT IF EXISTS {$constraint}");
            }
        }
        Schema::table('timetable_entries', function (Blueprint $table) {
            $table->dropConstrainedForeignId('course_section_id');
            $table->dropConstrainedForeignId('term_id');
            $table->dropColumn(['effective_start', 'effective_end', 'week_pattern', 'rotation_week', 'start_minute', 'end_minute']);
        });
    }
};
