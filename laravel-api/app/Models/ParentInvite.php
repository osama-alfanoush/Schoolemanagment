<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * A school-issued activation code for one guardian.
 *
 * The plaintext code exists exactly once, in the response that issued it. Only
 * a keyed hash is stored, so the code cannot be recovered from the database.
 */
class ParentInvite extends Model
{
    protected $fillable = [
        'school_id', 'guardian_user_id', 'code_hash',
        'expires_at', 'redeemed_at', 'redeemed_device_id', 'attempts', 'issued_by',
    ];

    protected $casts = [
        'expires_at' => 'datetime',
        'redeemed_at' => 'datetime',
        'attempts' => 'integer',
    ];

    protected $hidden = ['code_hash'];

    public function guardian(): BelongsTo
    {
        return $this->belongsTo(User::class, 'guardian_user_id');
    }

    public function isRedeemed(): bool
    {
        return $this->redeemed_at !== null;
    }

    public function isExpired(): bool
    {
        return $this->expires_at->isPast();
    }

    public function isUsable(): bool
    {
        return ! $this->isRedeemed() && ! $this->isExpired();
    }
}
