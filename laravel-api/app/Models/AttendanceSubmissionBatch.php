<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AttendanceSubmissionBatch extends Model
{
    protected $fillable = [
        'idempotency_key', 'school_id', 'class_room_id', 'course_section_id', 'attendance_date',
        'submitted_by', 'payload_hash', 'record_count', 'committed_at',
    ];

    protected $casts = ['attendance_date' => 'date', 'committed_at' => 'datetime'];
}
