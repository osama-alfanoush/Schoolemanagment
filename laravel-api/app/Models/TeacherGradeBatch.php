<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * One grade submission from the teacher app, keyed by its idempotency key.
 *
 * @see \App\Services\Mobile\TeacherService::submitGrades()
 */
class TeacherGradeBatch extends Model
{
    protected $fillable = [
        'idempotency_key', 'school_id', 'gradebook_id', 'class_room_id', 'subject_id',
        'submitted_by', 'payload_hash', 'record_count', 'result', 'committed_at',
    ];

    protected $casts = [
        'result' => 'array',
        'record_count' => 'integer',
        'committed_at' => 'datetime',
    ];
}
