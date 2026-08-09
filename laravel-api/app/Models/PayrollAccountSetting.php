<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PayrollAccountSetting extends Model
{
    protected $fillable = [
        'scope_key', 'school_id', 'salary_expense_code', 'salary_expense_name',
        'employer_insurance_expense_code', 'employer_insurance_expense_name', 'payroll_payable_code',
        'payroll_payable_name', 'social_insurance_payable_code', 'social_insurance_payable_name',
        'deductions_payable_code', 'deductions_payable_name', 'employee_advances_receivable_code',
        'employee_advances_receivable_name', 'cash_bank_code', 'cash_bank_name',
    ];
}
