<?php

namespace App\Models;

use App\Services\CurrentSchool;
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
    public const ROLES = ['student', 'parent', 'teacher', 'admin', 'finance', 'hr', 'warehouse', 'procurement'];

    // Employee roles: get staff profiles, appear in HR, can be payrolled.
    public const STAFF_ROLES = ['teacher', 'admin', 'finance', 'hr', 'warehouse', 'procurement'];

    protected $fillable = [
        'name', 'email', 'password', 'role', 'phone', 'photo_path', 'locale', 'is_active',
        'must_change_password', 'last_login_at', 'login_attempts', 'locked_until',
        'deactivated_at', 'deactivated_by', 'deactivation_reason',
        'mfa_secret', 'mfa_recovery_codes', 'mfa_confirmed_at',
        'mfa_last_used_timestep', 'mfa_recovery_used_at',
    ];

    protected $hidden = ['password', 'remember_token', 'mfa_secret', 'mfa_recovery_codes'];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'is_active' => 'boolean',
            'must_change_password' => 'boolean',
            'last_login_at' => 'datetime',
            'locked_until' => 'datetime',
            'deactivated_at' => 'datetime',
            'mfa_secret' => 'encrypted',
            'mfa_recovery_codes' => 'array',
            'mfa_confirmed_at' => 'datetime',
            'mfa_last_used_timestep' => 'integer',
            'mfa_recovery_used_at' => 'datetime',
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
        $relation = $this->belongsToMany(User::class, 'parent_student', 'parent_user_id', 'student_user_id')
            ->withPivot('school_id', 'relation')->withTimestamps();
        $schoolId = $this->relationshipSchoolId();

        return $schoolId
            ? $relation->withPivotValue('school_id', (int) $schoolId)
            : $relation;
    }

    public function enrollments(): HasMany
    {
        return $this->hasMany(StudentEnrollment::class, 'student_user_id');
    }

    public function schoolRoles(): HasMany
    {
        return $this->hasMany(SchoolUserRole::class);
    }

    public function parents(): BelongsToMany
    {
        $relation = $this->belongsToMany(User::class, 'parent_student', 'student_user_id', 'parent_user_id')
            ->withPivot('school_id', 'relation')->withTimestamps();
        $schoolId = $this->relationshipSchoolId();

        return $schoolId
            ? $relation->withPivotValue('school_id', (int) $schoolId)
            : $relation;
    }

    public function hasRole(string|array $roles): bool
    {
        return in_array($this->role, (array) $roles, true);
    }

    public function requiresMfa(): bool
    {
        return (bool) config('mfa.enabled')
            && in_array($this->role, config('mfa.required_roles', []), true);
    }

    /** Per-user permission overrides (grant or deny on top of the role's set). */
    public function permissionOverrides(): HasMany
    {
        return $this->hasMany(UserPermission::class);
    }

    public function hasPermission(string $key): bool
    {
        if ($this->role === 'admin') {
            return true;
        }

        $override = $this->permissionOverrides()
            ->whereRelation('permission', 'key', $key)
            ->first();
        if ($override) {
            return $override->granted;
        }

        return in_array($key, Permission::keysForRole($this->role), true);
    }

    /** Effective permission keys: role grants plus user grants, minus user denies. */
    public function allPermissionKeys(): array
    {
        if ($this->role === 'admin') {
            return ['*'];
        }

        $keys = Permission::keysForRole($this->role);
        foreach ($this->permissionOverrides()->with('permission:id,key')->get() as $override) {
            if ($override->granted) {
                $keys[] = $override->permission->key;
            } else {
                $keys = array_filter($keys, fn ($k) => $k !== $override->permission->key);
            }
        }

        return array_values(array_unique($keys));
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

    private function relationshipSchoolId(): ?int
    {
        $currentSchoolId = app(CurrentSchool::class)->idOrNull();
        if ($currentSchoolId !== null) {
            return $currentSchoolId;
        }

        $schoolIds = $this->schoolRoles()->distinct()->limit(2)->pluck('school_id');

        return $schoolIds->count() === 1 ? (int) $schoolIds->first() : null;
    }
}
