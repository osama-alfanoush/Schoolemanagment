<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TransportVehicle extends Model
{
    use HasFactory;

    protected $fillable = [
        'registration_number', 'model', 'type', 'capacity',
        'route_id', 'driver_id', 'gps_device_id', 'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function route(): BelongsTo
    {
        return $this->belongsTo(TransportRoute::class, 'route_id');
    }

    public function driver(): BelongsTo
    {
        return $this->belongsTo(User::class, 'driver_id');
    }
}
