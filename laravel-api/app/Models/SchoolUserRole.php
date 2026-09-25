<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class SchoolUserRole extends Model
{
    protected $fillable = ['school_id', 'user_id', 'role', 'starts_on', 'ends_on'];

    protected $casts = ['starts_on' => 'date', 'ends_on' => 'date'];

    public function school(): BelongsTo
    {
        return $this->belongsTo(School::class);
    }
}
