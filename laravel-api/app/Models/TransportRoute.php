<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class TransportRoute extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'description', 'departure_time', 'return_time',
        'fee', 'capacity', 'is_active',
    ];

    protected $casts = [
        'departure_time' => 'datetime:H:i',
        'return_time' => 'datetime:H:i',
        'is_active' => 'boolean',
    ];

    public function vehicles(): HasMany
    {
        return $this->hasMany(TransportVehicle::class, 'route_id');
    }

    public function stops(): HasMany
    {
        return $this->hasMany(TransportStop::class, 'route_id')->orderBy('sequence_number');
    }

    public function assignments(): HasMany
    {
        return $this->hasMany(TransportAssignment::class, 'route_id');
    }

    public function availableSeats(): int
    {
        $assigned = $this->assignments()->where('is_active', true)->count();
        return $this->capacity - $assigned;
    }
}
