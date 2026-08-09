<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SocialInsuranceScheme extends Model
{
    protected $fillable = [
        'scope_key', 'school_id', 'scheme_code', 'name_ar', 'name_en', 'employee_rate', 'employer_rate',
        'calculation_base', 'minimum_wage', 'maximum_wage', 'included_component_codes',
        'excluded_component_codes', 'effective_from', 'effective_to', 'employee_payable_account_code',
        'employer_expense_account_code', 'employer_payable_account_code', 'rounding_mode', 'is_active',
    ];

    protected $casts = [
        'employee_rate' => 'decimal:6', 'employer_rate' => 'decimal:6', 'minimum_wage' => 'decimal:2',
        'maximum_wage' => 'decimal:2', 'included_component_codes' => 'array', 'excluded_component_codes' => 'array',
        'effective_from' => 'date', 'effective_to' => 'date', 'is_active' => 'boolean',
    ];
}
