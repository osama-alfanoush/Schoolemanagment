<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LibraryBorrowing extends Model
{
    use HasFactory;

    protected $fillable = [
        'book_id', 'student_user_id', 'borrowed_date', 'due_date',
        'returned_date', 'fine_amount', 'is_returned',
        'issued_by', 'returned_to', 'notes',
    ];

    protected $casts = [
        'borrowed_date' => 'date',
        'due_date' => 'date',
        'returned_date' => 'date',
        'fine_amount' => 'decimal:2',
        'is_returned' => 'boolean',
    ];

    public function book(): BelongsTo
    {
        return $this->belongsTo(LibraryBook::class, 'book_id');
    }

    public function student(): BelongsTo
    {
        return $this->belongsTo(User::class, 'student_user_id');
    }

    public function issuer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'issued_by');
    }

    public function isOverdue(): bool
    {
        return ! $this->is_returned && now()->gt($this->due_date);
    }

    public function daysOverdue(): int
    {
        if (! $this->isOverdue()) {
            return 0;
        }

        return now()->diffInDays($this->due_date);
    }

    public function calculateFine(float $ratePerDay = 1.0): float
    {
        if (! $this->isOverdue()) {
            return 0;
        }

        return min($this->daysOverdue() * $ratePerDay, $this->book->price ?? 50);
    }

    public function scopeOverdue($query)
    {
        return $query->where('is_returned', false)->where('due_date', '<', now());
    }

    public function scopeActive($query)
    {
        return $query->where('is_returned', false);
    }
}
