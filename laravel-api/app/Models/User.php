<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    // 'finance' is the unified Finance & Accounting role (accounting was merged in).
    public const ROLES = ['student', 'parent', 'teacher', 'admin', 'finance', 'hr', 'warehouse'];

    protected $fillable = [
        'name', 'email', 'password', 'role', 'phone', 'photo_path', 'locale', 'is_active',
        'must_change_password', 'last_login_at', 'login_attempts', 'locked_until',
    ];

    protected $hidden = ['password', 'remember_token'];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'is_active' => 'boolean',
            'must_change_password' => 'boolean',
            'last_login_at' => 'datetime',
            'locked_until' => 'datetime',
        ];
    }

    public function studentProfile(): HasOne
    {
        return $this->hasOne(StudentProfile::class);
    }

    public function staffProfile(): HasOne
    {
        return $this->hasOne(StaffProfile::class);
    }

    public function children(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'parent_student', 'parent_user_id', 'student_user_id')
            ->withPivot('relation')
            ->withTimestamps();
    }

    public function parents(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'parent_student', 'student_user_id', 'parent_user_id')
            ->withPivot('relation')
            ->withTimestamps();
    }

    public function hasRole(string|array $roles): bool
    {
        return in_array($this->role, (array) $roles, true);
    }

    /** Submissions made by this user when they are a student. */
    public function submissions(): HasMany
    {
        return $this->hasMany(Submission::class, 'student_user_id');
    }

    /** Personal device push tokens. */
    public function pushTokens(): HasMany
    {
        return $this->hasMany(PushToken::class);
    }
}
