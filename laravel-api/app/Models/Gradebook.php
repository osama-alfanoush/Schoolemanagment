<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Gradebook extends Model
{
    public const EDITABLE_STATES = ['draft', 'returned', 'reopened'];

    protected $fillable = [
        'school_id', 'course_section_id', 'class_room_id', 'subject_id', 'grading_period_id',
        'state', 'version', 'submitted_by', 'submitted_at', 'approved_by', 'approved_at',
        'finalized_by', 'finalized_at', 'reopened_by', 'reopened_until', 'reopen_reason',
        'returned_by', 'returned_at', 'return_reason',
    ];

    protected $casts = [
        'version' => 'integer', 'submitted_at' => 'datetime', 'approved_at' => 'datetime',
        'finalized_at' => 'datetime', 'reopened_until' => 'datetime',
        'returned_at' => 'datetime',
    ];

    public function isEditable(): bool
    {
        return in_array($this->state, self::EDITABLE_STATES, true)
            && ($this->state !== 'reopened' || $this->reopened_until?->isFuture());
    }
}
