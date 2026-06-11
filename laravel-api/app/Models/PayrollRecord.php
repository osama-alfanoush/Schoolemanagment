<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PayrollRecord extends Model
{
    protected $fillable = ['staff_user_id', 'year', 'month', 'base_salary', 'allowances', 'deductions', 'advance_deduction', 'net_pay', 'status', 'paid_at'];
    protected $casts = ['paid_at' => 'datetime'];

    public function staff(): BelongsTo { return $this->belongsTo(User::class, 'staff_user_id'); }
}
