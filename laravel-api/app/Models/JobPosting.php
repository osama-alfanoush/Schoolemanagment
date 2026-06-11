<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class JobPosting extends Model
{
    use HasFactory;

    protected $fillable = [
        'title', 'description', 'requirements', 'department',
        'position_type', 'posting_date', 'closing_date', 'status', 'posted_by'
    ];

    protected $casts = [
        'posting_date' => 'date',
        'closing_date' => 'date',
    ];

    public const STATUS_OPEN = 'open';
    public const STATUS_CLOSED = 'closed';
    public const STATUS_FILLED = 'filled';

    public function poster(): BelongsTo
    {
        return $this->belongsTo(User::class, 'posted_by');
    }

    public function applications(): HasMany
    {
        return $this->hasMany(JobApplication::class);
    }

    public function isOpen(): bool
    {
        return $this->status === self::STATUS_OPEN &&
            ($this->closing_date === null || $this->closing_date->isFuture());
    }
}
