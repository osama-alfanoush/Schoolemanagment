<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class StudentProfile extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id', 'class_room_id', 'admission_no', 'date_of_birth', 'gender', 'address',
        'medical_notes', 'emergency_contact_name', 'emergency_contact_phone',
    ];

    protected $casts = ['date_of_birth' => 'date'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function classRoom(): BelongsTo
    {
        return $this->belongsTo(ClassRoom::class);
    }
}
