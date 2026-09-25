<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class TimetableEntry extends Model
{
    protected $fillable = [
        'school_id', 'class_room_id', 'subject_id', 'teacher_user_id', 'term_id', 'course_section_id',
        'day_of_week', 'start_time', 'end_time', 'start_minute', 'end_minute', 'room',
        'effective_start', 'effective_end', 'week_pattern', 'rotation_week',
    ];

    protected $casts = ['effective_start' => 'date', 'effective_end' => 'date'];

    protected static function booted(): void
    {
        static::saving(function (TimetableEntry $entry): void {
            foreach (['start' => 'start_time', 'end' => 'end_time'] as $prefix => $attribute) {
                $parts = explode(':', (string) $entry->{$attribute});
                if (count($parts) < 2) {
                    continue;
                }

                $entry->{$prefix.'_minute'} = ((int) $parts[0] * 60) + (int) $parts[1];
            }
        });
    }

    public function classRoom(): BelongsTo
    {
        return $this->belongsTo(ClassRoom::class);
    }

    public function subject(): BelongsTo
    {
        return $this->belongsTo(Subject::class);
    }

    public function teacher(): BelongsTo
    {
        return $this->belongsTo(User::class, 'teacher_user_id');
    }
}
