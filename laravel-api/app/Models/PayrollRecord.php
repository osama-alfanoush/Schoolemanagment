<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PayrollRecord extends Model
{
    protected $fillable = [
        'school_id', 'staff_user_id', 'year', 'month', 'base_salary', 'allowances', 'deductions', 'advance_deduction',
        'net_pay', 'status', 'paid_at', 'payroll_run_id', 'total_earnings', 'gross_salary',
        'insurable_wage', 'employee_social_insurance', 'employer_social_insurance', 'employer_contributions', 'other_deductions',
        'employer_cost', 'contract_snapshot', 'social_insurance_snapshot', 'calculation_snapshot',
    ];

    protected $casts = [
        'paid_at' => 'datetime', 'base_salary' => 'decimal:2', 'allowances' => 'decimal:2',
        'deductions' => 'decimal:2', 'advance_deduction' => 'decimal:2', 'net_pay' => 'decimal:2',
        'total_earnings' => 'decimal:2', 'gross_salary' => 'decimal:2', 'insurable_wage' => 'decimal:2',
        'employee_social_insurance' => 'decimal:2', 'employer_social_insurance' => 'decimal:2', 'employer_contributions' => 'decimal:2',
        'other_deductions' => 'decimal:2', 'employer_cost' => 'decimal:2',
        'contract_snapshot' => 'array', 'social_insurance_snapshot' => 'array', 'calculation_snapshot' => 'array',
    ];

    public function staff(): BelongsTo
    {
        return $this->belongsTo(User::class, 'staff_user_id');
    }

    public function run(): BelongsTo
    {
        return $this->belongsTo(PayrollRun::class, 'payroll_run_id');
    }

    public function components(): HasMany
    {
        return $this->hasMany(PayrollRecordComponent::class);
    }

    public function advanceInstallments(): HasMany
    {
        return $this->hasMany(EmployeeAdvanceInstallment::class);
    }
}
