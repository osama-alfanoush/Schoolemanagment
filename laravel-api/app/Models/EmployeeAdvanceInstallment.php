<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class EmployeeAdvanceInstallment extends Model
{
    protected $fillable = ['school_id', 'employee_advance_id', 'installment_no', 'due_date', 'amount', 'collected_amount', 'status', 'payroll_record_id', 'collected_at'];

    protected $casts = ['due_date' => 'date', 'amount' => 'decimal:2', 'collected_amount' => 'decimal:2', 'collected_at' => 'datetime'];

    public function advance(): BelongsTo
    {
        return $this->belongsTo(EmployeeAdvance::class, 'employee_advance_id');
    }

    public function payrollRecord(): BelongsTo
    {
        return $this->belongsTo(PayrollRecord::class);
    }
}
