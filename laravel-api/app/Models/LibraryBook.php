<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class LibraryBook extends Model
{
    use HasFactory;

    protected $fillable = [
        'isbn', 'title', 'author', 'publisher', 'publication_year',
        'category', 'description', 'cover_image', 'total_copies',
        'available_copies', 'location', 'is_active',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function borrowings(): HasMany
    {
        return $this->hasMany(LibraryBorrowing::class, 'book_id');
    }

    public function isAvailable(): bool
    {
        return $this->available_copies > 0 && $this->is_active;
    }

    public function scopeAvailable($query)
    {
        return $query->where('available_copies', '>', 0)->where('is_active', true);
    }

    public function scopeSearch($query, string $search)
    {
        return $query->where(function ($q) use ($search) {
            $q->where('title', 'ilike', "%{$search}%")
                ->orWhere('author', 'ilike', "%{$search}%")
                ->orWhere('isbn', 'ilike', "%{$search}%");
        });
    }
}
