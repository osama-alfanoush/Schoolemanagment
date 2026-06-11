<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StaffAttendance extends Model
{
    protected $table = 'staff_attendance';
    protected $fillable = ['staff_user_id', 'date', 'status', 'check_in', 'check_out'];
    protected $casts = ['date' => 'date'];

    public function staff(): BelongsTo { return $this->belongsTo(User::class, 'staff_user_id'); }
}
