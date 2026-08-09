<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StaffPayrollComponent extends Model
{
    protected $fillable = [
        'school_id', 'staff_profile_id', 'payroll_component_id', 'amount_override', 'rate_override', 'effective_from',
        'effective_to', 'one_time_period', 'reason', 'status', 'approved_by', 'approved_at',
    ];

    protected $casts = [
        'amount_override' => 'decimal:2', 'rate_override' => 'decimal:6', 'effective_from' => 'date',
        'effective_to' => 'date', 'one_time_period' => 'date', 'approved_at' => 'datetime',
    ];

    public function component(): BelongsTo
    {
        return $this->belongsTo(PayrollComponent::class, 'payroll_component_id');
    }

    public function staffProfile(): BelongsTo
    {
        return $this->belongsTo(StaffProfile::class);
    }
}
