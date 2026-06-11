<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PerformanceEvaluation extends Model
{
    use HasFactory;

    protected $fillable = [
        'staff_user_id', 'evaluator_id', 'evaluation_date', 'period',
        'criteria_scores', 'overall_score', 'strengths',
        'areas_for_improvement', 'goals', 'evaluator_comments',
        'reviewed_by', 'reviewed_at',
    ];

    protected $casts = [
        'criteria_scores' => 'array',
        'evaluation_date' => 'date',
        'overall_score' => 'decimal:2',
        'reviewed_at' => 'datetime',
    ];

    public function staff(): BelongsTo
    {
        return $this->belongsTo(User::class, 'staff_user_id');
    }

    public function evaluator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'evaluator_id');
    }

    public function reviewer(): ?BelongsTo
    {
        return $this->belongsTo(User::class, 'reviewed_by');
    }

    public function isReviewed(): bool
    {
        return $this->reviewed_at !== null;
    }

    public function getRating(): string
    {
        return match (true) {
            $this->overall_score >= 4.5 => 'Outstanding',
            $this->overall_score >= 3.5 => 'Good',
            $this->overall_score >= 2.5 => 'Satisfactory',
            $this->overall_score >= 1.5 => 'Needs Improvement',
            default => 'Unsatisfactory',
        };
    }
}
