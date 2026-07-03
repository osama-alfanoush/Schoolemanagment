<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FeeStructure extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'grade', 'billing_cycle', 'amount', 'is_active'];

    protected $casts = ['amount' => 'decimal:2', 'is_active' => 'boolean'];
}
