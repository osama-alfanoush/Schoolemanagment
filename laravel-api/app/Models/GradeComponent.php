<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class GradeComponent extends Model
{
    use HasFactory;
    protected $fillable = ['class_room_id', 'subject_id', 'semester_id', 'name', 'type', 'weight', 'max_score'];
    protected $casts = ['weight' => 'decimal:2', 'max_score' => 'decimal:2'];

    public function classRoom(): BelongsTo { return $this->belongsTo(ClassRoom::class); }
    public function subject(): BelongsTo { return $this->belongsTo(Subject::class); }
    public function grades(): HasMany { return $this->hasMany(Grade::class); }
}
