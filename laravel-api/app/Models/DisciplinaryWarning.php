<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class DisciplinaryWarning extends Model
{
    protected $fillable = [
        'school_id', 'warning_no', 'staff_profile_id', 'warning_type', 'offence', 'incident_description',
        'incident_date', 'issued_date', 'level', 'issued_by', 'status', 'received_at',
        'employee_comments', 'attachments', 'effect_expires_at', 'previous_warning_id',
        'cancellation_reason', 'approved_by', 'approved_at',
    ];

    protected $casts = [
        'incident_date' => 'date', 'issued_date' => 'date', 'received_at' => 'datetime',
        'effect_expires_at' => 'date', 'approved_at' => 'datetime', 'attachments' => 'array',
    ];

    public function staffProfile(): BelongsTo
    {
        return $this->belongsTo(StaffProfile::class);
    }

    public function issuer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'issued_by');
    }

    public function approver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'approved_by');
    }
}
