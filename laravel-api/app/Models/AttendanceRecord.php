<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AttendanceRecord extends Model
{
    use HasFactory;
    protected $fillable = ['student_user_id', 'class_room_id', 'subject_id', 'date', 'status', 'marked_by', 'note'];
    protected $casts = ['date' => 'date'];

    public function student(): BelongsTo { return $this->belongsTo(User::class, 'student_user_id'); }
    public function classRoom(): BelongsTo { return $this->belongsTo(ClassRoom::class); }
    public function subject(): BelongsTo { return $this->belongsTo(Subject::class); }
}
