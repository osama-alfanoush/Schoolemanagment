<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Message extends Model
{
    protected $fillable = ['sender_user_id', 'recipient_user_id', 'about_student_user_id', 'body', 'read_at'];
    protected $casts = ['read_at' => 'datetime'];

    public function sender(): BelongsTo { return $this->belongsTo(User::class, 'sender_user_id'); }
    public function recipient(): BelongsTo { return $this->belongsTo(User::class, 'recipient_user_id'); }
    public function aboutStudent(): BelongsTo { return $this->belongsTo(User::class, 'about_student_user_id'); }
}
