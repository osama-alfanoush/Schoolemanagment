<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Submission extends Model
{
    protected $fillable = ['assignment_id', 'student_user_id', 'content_text', 'file_path', 'submitted_at', 'status', 'score', 'feedback', 'graded_by'];

    protected $casts = ['submitted_at' => 'datetime', 'score' => 'decimal:2'];

    public function assignment(): BelongsTo
    {
        return $this->belongsTo(Assignment::class);
    }

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }
}
