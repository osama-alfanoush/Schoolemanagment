<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Grade extends Model
{
    use HasFactory;
    protected $fillable = ['student_user_id', 'grade_component_id', 'score', 'entered_by'];
    protected $casts = ['score' => 'decimal:2'];

    public function student(): BelongsTo { return $this->belongsTo(User::class, 'student_user_id'); }
    public function component(): BelongsTo { return $this->belongsTo(GradeComponent::class, 'grade_component_id'); }
}
