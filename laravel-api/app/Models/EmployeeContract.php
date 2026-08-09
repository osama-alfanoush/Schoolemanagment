<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class EmployeeContract extends Model
{
    protected $fillable = [
        'staff_profile_id', 'school_id', 'contract_no', 'contract_type', 'start_date', 'end_date',
        'probation_days', 'probation_end', 'base_salary', 'payment_method', 'bank_name', 'bank_account',
        'status', 'is_current', 'renewed_from_id', 'attachments', 'notes', 'created_by',
    ];

    protected $appends = ['days_remaining', 'duration_days', 'display_status'];

    protected $casts = [
        'start_date' => 'date', 'end_date' => 'date', 'probation_end' => 'date',
        'base_salary' => 'decimal:2', 'is_current' => 'boolean', 'attachments' => 'array',
    ];

    public function staffProfile(): BelongsTo
    {
        return $this->belongsTo(StaffProfile::class);
    }

    public function renewedFrom(): BelongsTo
    {
        return $this->belongsTo(self::class, 'renewed_from_id');
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    protected function daysRemaining(): Attribute
    {
        return Attribute::get(fn () => $this->end_date ? now()->startOfDay()->diffInDays($this->end_date, false) : null);
    }

    protected function durationDays(): Attribute
    {
        return Attribute::get(fn () => $this->end_date ? $this->start_date->diffInDays($this->end_date) + 1 : null);
    }

    protected function displayStatus(): Attribute
    {
        return Attribute::get(function () {
            if (! $this->end_date || $this->contract_type === 'indefinite') {
                return 'indefinite';
            }
            $days = $this->days_remaining;
            if ($days < 0) {
                return 'expired';
            }
            if ($days <= 30) {
                return 'expiring_soon';
            }

            return 'active';
        });
    }
}
