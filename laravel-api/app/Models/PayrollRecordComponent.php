<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PayrollRecordComponent extends Model
{
    protected $fillable = [
        'school_id', 'payroll_record_id', 'payroll_component_id', 'component_code', 'name_ar', 'name_en', 'category',
        'calculation_type', 'base_amount', 'rate', 'amount', 'rule_snapshot',
    ];

    protected $casts = ['base_amount' => 'decimal:2', 'rate' => 'decimal:6', 'amount' => 'decimal:2', 'rule_snapshot' => 'array'];

    public function payrollRecord(): BelongsTo
    {
        return $this->belongsTo(PayrollRecord::class);
    }
}
