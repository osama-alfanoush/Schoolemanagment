<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HrPayrollSetting extends Model
{
    protected $fillable = ['scope_key', 'school_id', 'contract_alert_days', 'proration_policy', 'negative_net_policy', 'currency'];

    protected $casts = ['contract_alert_days' => 'array'];
}
