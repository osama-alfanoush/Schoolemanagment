<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TransportStop extends Model
{
    use HasFactory;

    protected $fillable = [
        'route_id', 'name', 'address', 'latitude', 'longitude',
        'pickup_time', 'dropoff_time', 'sequence_number',
    ];

    protected $casts = [
        'pickup_time' => 'datetime:H:i',
        'dropoff_time' => 'datetime:H:i',
        'latitude' => 'float',
        'longitude' => 'float',
        'sequence_number' => 'integer',
    ];

    public function route(): BelongsTo
    {
        return $this->belongsTo(TransportRoute::class, 'route_id');
    }
}
