<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ContractAlertDelivery extends Model
{
    protected $fillable = ['employee_contract_id', 'threshold_days', 'sent_at'];

    protected $casts = ['sent_at' => 'datetime'];
}
