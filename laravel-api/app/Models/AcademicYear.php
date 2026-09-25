<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class AcademicYear extends Model
{
    protected $fillable = ['name', 'start_date', 'end_date', 'is_current', 'school_id', 'archived_at', 'archived_by', 'archive_reason'];

    protected $casts = ['start_date' => 'date', 'end_date' => 'date', 'is_current' => 'boolean'];

    public function semesters(): HasMany
    {
        return $this->hasMany(Semester::class);
    }
}
