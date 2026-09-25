<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OutboxEvent extends Model
{
    protected $fillable = [
        'event_id', 'type', 'aggregate_type', 'aggregate_id', 'payload', 'deduplication_key',
        'attempts', 'max_attempts', 'available_at', 'processed_at', 'last_error',
        'status', 'locked_by', 'locked_at', 'dead_lettered_at',
    ];

    protected $casts = [
        'payload' => 'array', 'available_at' => 'datetime', 'processed_at' => 'datetime',
        'locked_at' => 'datetime', 'dead_lettered_at' => 'datetime',
    ];
}
