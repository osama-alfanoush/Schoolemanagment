<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StudentEnrollment extends Model
{
    protected $fillable = [
        'student_user_id', 'school_id', 'academic_year_id', 'class_room_id', 'admission_date',
        'start_date', 'end_date', 'status', 'entry_type', 'exit_type', 'previous_school',
        'next_school', 'withdrawal_reason', 'created_by', 'approved_by', 'version',
    ];

    protected $casts = [
        'admission_date' => 'date', 'start_date' => 'date', 'end_date' => 'date', 'version' => 'integer',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }

    public function school(): BelongsTo
    {
        return $this->belongsTo(School::class);
    }

    public function classRoom(): BelongsTo
    {
        return $this->belongsTo(ClassRoom::class);
    }
}
