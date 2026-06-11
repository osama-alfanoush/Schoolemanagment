<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class MedicalRecord extends Model
{
    use HasFactory;

    protected $fillable = [
        'student_user_id', 'allergies', 'chronic_conditions', 'medications',
        'blood_type', 'primary_doctor_name', 'primary_doctor_phone',
        'insurance_provider', 'insurance_policy_number', 'emergency_instructions',
    ];

    protected $casts = [
        'allergies' => 'array',
        'chronic_conditions' => 'array',
        'medications' => 'array',
    ];

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }

    public function visits(): HasMany
    {
        return $this->hasMany(MedicalVisit::class, 'student_user_id', 'student_user_id');
    }

    public function hasAllergies(): bool
    {
        return !empty($this->allergies);
    }

    public function hasChronicConditions(): bool
    {
        return !empty($this->chronic_conditions);
    }
}
