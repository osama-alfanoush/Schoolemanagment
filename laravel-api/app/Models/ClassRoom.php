<?php

namespace App\Models;

use App\Services\CurrentSchool;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class ClassRoom extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'grade', 'section', 'capacity', 'academic_year_id', 'homeroom_teacher_id', 'school_id', 'archived_at', 'archived_by', 'archive_reason'];

    public function students(): HasMany
    {
        return $this->hasMany(StudentProfile::class);
    }

    public function subjects(): BelongsToMany
    {
        $relation = $this->belongsToMany(Subject::class, 'class_subject_teacher')
            ->withPivot('school_id', 'teacher_user_id')->withTimestamps();
        $currentSchool = app(CurrentSchool::class);

        $schoolId = $currentSchool->idOrNull() ?? $this->school_id;

        return $schoolId
            ? $relation->withPivotValue('school_id', (int) $schoolId)
            : $relation;
    }

    public function timetableEntries(): HasMany
    {
        return $this->hasMany(TimetableEntry::class);
    }

    public function homeroomTeacher(): BelongsTo
    {
        return $this->belongsTo(User::class, 'homeroom_teacher_id');
    }

    public function academicYear(): BelongsTo
    {
        return $this->belongsTo(AcademicYear::class);
    }
}
