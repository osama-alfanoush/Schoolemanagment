<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/** A guardian's request that the office correct something on a child's record. */
class ProfileCorrectionRequest extends Model
{
    protected $fillable = [
        'school_id', 'student_user_id', 'requested_by',
        'field', 'detail', 'status', 'idempotency_key',
    ];

    protected $hidden = ['idempotency_key'];
}
