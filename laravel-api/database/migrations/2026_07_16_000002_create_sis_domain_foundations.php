<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('organizations', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('code')->unique();
            $table->timestamps();
        });

        Schema::create('schools', function (Blueprint $table) {
            $table->id();
            $table->foreignId('organization_id')->constrained()->restrictOnDelete();
            $table->string('name');
            $table->string('code')->unique();
            $table->string('timezone')->default('UTC');
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });

        Schema::create('school_user_roles', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->foreignId('user_id')->constrained()->restrictOnDelete();
            $table->string('role');
            $table->date('starts_on')->nullable();
            $table->date('ends_on')->nullable();
            $table->timestamps();
            $table->unique(['school_id', 'user_id', 'role']);
            $table->index(['user_id', 'starts_on', 'ends_on']);
        });

        foreach (['academic_years', 'class_rooms', 'subjects', 'announcements', 'invoices', 'timetable_entries'] as $tableName) {
            Schema::table($tableName, function (Blueprint $table) {
                $table->foreignId('school_id')->nullable()->constrained()->restrictOnDelete();
            });
        }

        Schema::create('student_enrollments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('student_user_id')->constrained('users')->restrictOnDelete();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->foreignId('academic_year_id')->nullable()->constrained()->restrictOnDelete();
            $table->foreignId('class_room_id')->nullable()->constrained()->restrictOnDelete();
            $table->date('admission_date')->nullable();
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->string('status');
            $table->string('entry_type')->default('new');
            $table->string('exit_type')->nullable();
            $table->string('previous_school')->nullable();
            $table->string('next_school')->nullable();
            $table->text('withdrawal_reason')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('approved_by')->nullable()->constrained('users')->nullOnDelete();
            $table->unsignedInteger('version')->default(1);
            $table->timestamps();
            $table->index(['student_user_id', 'school_id', 'start_date', 'end_date'], 'enrollment_date_lookup');
            $table->unique(['student_user_id', 'school_id', 'start_date'], 'enrollment_start_unique');
        });

        DB::statement("CREATE UNIQUE INDEX enrollment_one_open_active ON student_enrollments (student_user_id, school_id) WHERE status = 'active' AND end_date IS NULL");

        Schema::create('terms', function (Blueprint $table) {
            $table->id();
            $table->foreignId('academic_year_id')->constrained()->restrictOnDelete();
            $table->string('name');
            $table->string('type');
            $table->date('start_date');
            $table->date('end_date');
            $table->unsignedSmallInteger('sequence');
            $table->timestamps();
            $table->unique(['academic_year_id', 'sequence']);
        });

        Schema::create('grading_periods', function (Blueprint $table) {
            $table->id();
            $table->foreignId('term_id')->constrained()->restrictOnDelete();
            $table->string('name');
            $table->date('start_date');
            $table->date('end_date');
            $table->unsignedSmallInteger('sequence');
            $table->boolean('is_final')->default(false);
            $table->timestamps();
            $table->unique(['term_id', 'sequence']);
        });

        Schema::create('courses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('school_id')->constrained()->restrictOnDelete();
            $table->foreignId('subject_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('code');
            $table->string('name');
            $table->decimal('credits', 6, 2)->nullable();
            $table->timestamp('archived_at')->nullable();
            $table->foreignId('archived_by')->nullable()->constrained('users')->nullOnDelete();
            $table->string('archive_reason', 500)->nullable();
            $table->timestamps();
            $table->unique(['school_id', 'code']);
        });

        Schema::create('course_sections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_id')->constrained()->restrictOnDelete();
            $table->foreignId('term_id')->constrained()->restrictOnDelete();
            $table->foreignId('class_room_id')->nullable()->constrained()->restrictOnDelete();
            $table->string('code');
            $table->date('start_date');
            $table->date('end_date');
            $table->unsignedInteger('capacity')->nullable();
            $table->timestamp('archived_at')->nullable();
            $table->timestamps();
            $table->unique(['course_id', 'term_id', 'code']);
        });

        Schema::create('section_teachers', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_section_id')->constrained()->restrictOnDelete();
            $table->foreignId('teacher_user_id')->constrained('users')->restrictOnDelete();
            $table->string('responsibility')->default('teacher');
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->timestamps();
            $table->unique(['course_section_id', 'teacher_user_id', 'start_date'], 'section_teacher_start_unique');
        });

        Schema::create('section_enrollments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('course_section_id')->constrained()->restrictOnDelete();
            $table->foreignId('student_enrollment_id')->constrained()->restrictOnDelete();
            $table->date('start_date');
            $table->date('end_date')->nullable();
            $table->string('status')->default('active');
            $table->timestamps();
            $table->unique(['course_section_id', 'student_enrollment_id', 'start_date'], 'section_enrollment_start_unique');
        });

        foreach (['academic_years', 'class_rooms', 'subjects', 'fee_structures'] as $tableName) {
            Schema::table($tableName, function (Blueprint $table) {
                $table->timestamp('archived_at')->nullable()->index();
                $table->foreignId('archived_by')->nullable()->constrained('users')->nullOnDelete();
                $table->string('archive_reason', 500)->nullable();
            });
        }

        $organizationId = DB::table('organizations')->insertGetId([
            'name' => 'Default Organization', 'code' => 'DEFAULT', 'created_at' => now(), 'updated_at' => now(),
        ]);
        $schoolId = DB::table('schools')->insertGetId([
            'organization_id' => $organizationId,
            'name' => 'Default School',
            'code' => 'DEFAULT',
            'timezone' => config('app.timezone', 'UTC'),
            'is_active' => true,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        foreach (['academic_years', 'class_rooms', 'subjects', 'announcements', 'invoices', 'timetable_entries'] as $tableName) {
            DB::table($tableName)->whereNull('school_id')->update(['school_id' => $schoolId]);
        }
        DB::table('users')->orderBy('id')->each(function ($user) use ($schoolId) {
            DB::table('school_user_roles')->insertOrIgnore([
                'school_id' => $schoolId,
                'user_id' => $user->id,
                'role' => $user->role,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        });
    }

    public function down(): void
    {
        foreach (['fee_structures', 'subjects', 'class_rooms', 'academic_years'] as $tableName) {
            Schema::table($tableName, function (Blueprint $table) {
                $table->dropConstrainedForeignId('archived_by');
                $table->dropIndex(['archived_at']);
                $table->dropColumn(['archived_at', 'archive_reason']);
            });
        }

        Schema::dropIfExists('section_enrollments');
        Schema::dropIfExists('section_teachers');
        Schema::dropIfExists('course_sections');
        Schema::dropIfExists('courses');
        Schema::dropIfExists('grading_periods');
        Schema::dropIfExists('terms');
        Schema::dropIfExists('student_enrollments');

        foreach (['timetable_entries', 'invoices', 'announcements', 'subjects', 'class_rooms', 'academic_years'] as $tableName) {
            Schema::table($tableName, fn (Blueprint $table) => $table->dropConstrainedForeignId('school_id'));
        }

        Schema::dropIfExists('school_user_roles');
        Schema::dropIfExists('schools');
        Schema::dropIfExists('organizations');
    }
};
