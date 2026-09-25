<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class PayrollComponent extends Model
{
    protected $fillable = [
        'scope_key', 'school_id', 'code', 'name_ar', 'name_en', 'category', 'calculation_type',
        'percentage_base', 'amount', 'rate', 'minimum_amount', 'maximum_amount', 'rounding_mode',
        'is_recurring', 'effective_from', 'effective_to', 'is_social_insurance_base', 'is_taxable',
        'show_on_payslip', 'debit_account_code', 'credit_account_code', 'is_active', 'priority',
    ];

    protected $casts = [
        'amount' => 'decimal:2', 'rate' => 'decimal:6', 'minimum_amount' => 'decimal:2',
        'maximum_amount' => 'decimal:2', 'effective_from' => 'date', 'effective_to' => 'date',
        'is_recurring' => 'boolean', 'is_social_insurance_base' => 'boolean', 'is_taxable' => 'boolean',
        'show_on_payslip' => 'boolean', 'is_active' => 'boolean',
    ];

    public function assignments(): HasMany
    {
        return $this->hasMany(StaffPayrollComponent::class);
    }

    public function payrollRecordComponents(): HasMany
    {
        return $this->hasMany(PayrollRecordComponent::class);
    }
}
