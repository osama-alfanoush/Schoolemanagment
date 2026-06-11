<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Exam extends Model
{
    protected $fillable = ['class_room_id', 'subject_id', 'semester_id', 'title', 'exam_date', 'start_time', 'end_time', 'room'];
    protected $casts = ['exam_date' => 'date'];

    public function classRoom(): BelongsTo { return $this->belongsTo(ClassRoom::class); }
    public function subject(): BelongsTo { return $this->belongsTo(Subject::class); }
}
