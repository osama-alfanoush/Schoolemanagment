<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class StaffProfile extends Model
{
    protected static function booted(): void
    {
        static::creating(function (self $profile) {
            if ($profile->school_id !== null) {
                return;
            }

            $schoolIds = SchoolUserRole::query()
                ->where('user_id', $profile->user_id)
                ->where(fn ($q) => $q->whereNull('starts_on')->orWhereDate('starts_on', '<=', now()))
                ->where(fn ($q) => $q->whereNull('ends_on')->orWhereDate('ends_on', '>=', now()))
                ->distinct()->pluck('school_id');
            if ($schoolIds->count() !== 1) {
                throw new \DomainException('A staff profile requires exactly one authorised school assignment.');
            }
            $profile->school_id = $schoolIds->first();
        });
    }

    protected $fillable = [
        'user_id', 'department', 'position', 'hire_date', 'contract_type', 'contract_end',
        'base_salary', 'qualifications', 'annual_leave_balance', 'sick_leave_balance',
        'school_id', 'employee_no', 'supervisor_user_id', 'employment_type', 'employment_status',
        'termination_date', 'contract_start', 'probation_days', 'probation_end', 'payment_method',
        'bank_name', 'bank_account', 'social_insurance_registered', 'social_insurance_number',
        'social_insurance_start', 'social_insurance_end', 'social_insurance_scheme_code', 'documents',
    ];

    protected $casts = [
        'hire_date' => 'date',
        'contract_end' => 'date',
        'contract_start' => 'date',
        'termination_date' => 'date',
        'probation_end' => 'date',
        'social_insurance_start' => 'date',
        'social_insurance_end' => 'date',
        'qualifications' => 'array',
        'documents' => 'array',
        'base_salary' => 'decimal:2',
        'social_insurance_registered' => 'boolean',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function supervisor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'supervisor_user_id');
    }

    public function contracts(): HasMany
    {
        return $this->hasMany(EmployeeContract::class)->orderByDesc('start_date');
    }

    public function currentContract(): HasOne
    {
        return $this->hasOne(EmployeeContract::class)->where('is_current', true)->latestOfMany('start_date');
    }

    public function payrollComponents(): HasMany
    {
        return $this->hasMany(StaffPayrollComponent::class);
    }

    public function advances(): HasMany
    {
        return $this->hasMany(EmployeeAdvance::class);
    }

    public function warnings(): HasMany
    {
        return $this->hasMany(DisciplinaryWarning::class);
    }
}
