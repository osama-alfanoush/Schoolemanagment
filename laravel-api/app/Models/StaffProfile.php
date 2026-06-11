<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StaffProfile extends Model
{
    protected $fillable = [
        'user_id', 'department', 'position', 'hire_date', 'contract_type', 'contract_end',
        'base_salary', 'qualifications', 'annual_leave_balance', 'sick_leave_balance',
    ];

    protected $casts = [
        'hire_date' => 'date',
        'contract_end' => 'date',
        'qualifications' => 'array',
        'base_salary' => 'decimal:2',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
