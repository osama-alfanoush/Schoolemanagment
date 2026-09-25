<?php

namespace App\Models;

use App\Services\CurrentSchool;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;

class Permission extends Model
{
    protected $fillable = ['key', 'module', 'action', 'description'];

    /**
     * All permission keys granted to a role, cached briefly since role grants
     * change rarely. Cache is busted by clearRoleCache() on any grant write.
     */
    public static function keysForRole(string $role): array
    {
        $schoolId = app(CurrentSchool::class)->idOrNull();
        if ($schoolId === null) {
            return [];
        }

        return Cache::remember("perms.school.{$schoolId}.role.{$role}", 300, function () use ($role, $schoolId) {
            return static::query()
                ->join('role_permissions', 'role_permissions.permission_id', '=', 'permissions.id')
                ->where('role_permissions.school_id', $schoolId)
                ->where('role_permissions.role', $role)
                ->pluck('permissions.key')
                ->all();
        });
    }

    public static function clearRoleCache(string $role): void
    {
        $schoolId = app(CurrentSchool::class)->idOrNull();
        if ($schoolId !== null) {
            Cache::forget("perms.school.{$schoolId}.role.{$role}");
        }
    }
}
