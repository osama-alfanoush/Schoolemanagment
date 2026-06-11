<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Assignment extends Model
{
    protected $fillable = ['teacher_user_id', 'class_room_id', 'subject_id', 'title', 'instructions', 'attachment_path', 'due_at', 'max_score'];
    protected $casts = ['due_at' => 'datetime', 'max_score' => 'decimal:2'];

    public function teacher(): BelongsTo { return $this->belongsTo(User::class, 'teacher_user_id'); }
    public function classRoom(): BelongsTo { return $this->belongsTo(ClassRoom::class); }
    public function subject(): BelongsTo { return $this->belongsTo(Subject::class); }
    public function submissions(): HasMany { return $this->hasMany(Submission::class); }
}
