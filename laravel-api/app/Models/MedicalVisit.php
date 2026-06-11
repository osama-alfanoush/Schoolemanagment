<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class MedicalVisit extends Model
{
    use HasFactory;

    protected $fillable = [
        'student_user_id', 'visit_date', 'symptoms', 'diagnosis',
        'treatment', 'medications_given', 'attended_by', 'notes',
        'parent_notified', 'notified_at',
    ];

    protected $casts = [
        'visit_date' => 'date',
        'parent_notified' => 'boolean',
        'notified_at' => 'datetime',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }

    public function attendant(): BelongsTo
    {
        return $this->belongsTo(User::class, 'attended_by');
    }
}
