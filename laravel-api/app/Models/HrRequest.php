<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class HrRequest extends Model
{
    protected $fillable = ['teacher_user_id', 'type', 'start_date', 'end_date', 'amount', 'subject', 'reason', 'status', 'admin_response', 'reviewed_by', 'reviewed_at'];

    protected $casts = ['start_date' => 'date', 'end_date' => 'date', 'reviewed_at' => 'datetime'];

    public function teacher(): BelongsTo
    {
        return $this->belongsTo(User::class, 'teacher_user_id');
    }

    public function requester(): BelongsTo
    {
        return $this->belongsTo(User::class, 'teacher_user_id');
    }

    public function reviewer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'reviewed_by');
    }
}
