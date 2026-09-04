<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * A guardian's intent to pay one installment, held in integer minor units.
 */
class MobilePaymentIntent extends Model
{
    protected $fillable = [
        'school_id', 'idempotency_key', 'request_hash', 'reference',
        'guardian_user_id', 'student_user_id', 'installment_id',
        'amount_minor', 'currency', 'decimals', 'status',
    ];

    protected $casts = [
        'amount_minor' => 'integer',
        'decimals' => 'integer',
    ];

    /** The key is a credential-shaped value; it never travels back out. */
    protected $hidden = ['idempotency_key', 'request_hash'];

    public function installment(): BelongsTo
    {
        return $this->belongsTo(Installment::class);
    }

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }
}
