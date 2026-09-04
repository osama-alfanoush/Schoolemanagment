<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/** A guardian's account of why a child was absent. */
class AttendanceExplanation extends Model
{
    protected $fillable = [
        'school_id', 'attendance_record_id', 'guardian_user_id',
        'reason', 'idempotency_key',
    ];

    /** The key is a credential-shaped value; it never travels back out. */
    protected $hidden = ['idempotency_key'];

    public function record(): BelongsTo
    {
        return $this->belongsTo(AttendanceRecord::class, 'attendance_record_id');
    }
}
