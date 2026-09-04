<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Notification;
use App\Models\SchoolSetting;
use App\Models\User;
use Illuminate\Support\Facades\DB;

/**
 * Everything the app needs before it can draw its first screen.
 *
 * One call, because the alternative is five on a cold start over 3G and a home
 * screen that assembles itself in stages while the parent watches.
 */
final class MobileBootstrapService
{
    /** Roles that have a mobile experience. Anything else is not reported. */
    private const MOBILE_ROLES = ['parent', 'teacher', 'student'];

    /** @return array<string, mixed> */
    public function forUser(User $user, int $schoolId): array
    {
        $roles = $this->rolesFor($user, $schoolId);

        return [
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'locale' => $user->locale ?? 'ar',
                'must_change_password' => (bool) $user->must_change_password,
            ],
            'roles' => $roles,
            'children' => in_array('parent', $roles, true)
                ? $this->childrenOf($user, $schoolId)
                : [],
            'theme' => $this->theme(),
            'features' => $this->features(),
            'unread_count' => $this->unreadCount($user),
            'min_supported_version' => config('mobile.min_supported_version'),
            'recommended_version' => config('mobile.recommended_version'),
            'force_upgrade' => (bool) config('mobile.force_upgrade'),
        ];
    }

    /**
     * Every mobile role this user holds in this school.
     *
     * `users.role` is one value, but `school_user_roles` is keyed on
     * `(school_id, user_id, role)` and can hold several — a teacher whose own
     * child attends the school is ordinary. Reporting only `users.role` is what
     * makes such a user unable to see their child's fees, so both are read and
     * merged.
     *
     * @return list<string>
     */
    private function rolesFor(User $user, int $schoolId): array
    {
        $today = now()->toDateString();

        $assigned = DB::table('school_user_roles')
            ->where('school_id', $schoolId)
            ->where('user_id', $user->id)
            ->where(fn ($q) => $q->whereNull('starts_on')->orWhereDate('starts_on', '<=', $today))
            ->where(fn ($q) => $q->whereNull('ends_on')->orWhereDate('ends_on', '>=', $today))
            ->pluck('role')
            ->all();

        $held = array_unique([...$assigned, (string) $user->role]);

        // Declaration order, not database order, so the app's role switcher
        // cannot reorder itself because a row was inserted differently.
        return array_values(array_filter(
            self::MOBILE_ROLES,
            static fn (string $role): bool => in_array($role, $held, true),
        ));
    }

    /**
     * The children this guardian is linked to, with the class they sit in.
     *
     * One query for the pivot join, eager-loaded profile and class room — a
     * parent with five children costs the same as a parent with one.
     *
     * @return list<array<string, mixed>>
     */
    private function childrenOf(User $user, int $schoolId): array
    {
        return $user->children()
            ->with(['studentProfile:id,user_id,class_room_id,admission_no',
                'studentProfile.classRoom:id,name,grade,section'])
            ->orderBy('users.name')
            ->get(['users.id', 'users.name'])
            ->map(fn (User $child): array => [
                'id' => $child->id,
                'name' => $child->name,
                'admission_no' => $child->studentProfile?->admission_no,
                'class_room_id' => $child->studentProfile?->class_room_id,
                'class_name' => $child->studentProfile?->classRoom?->name,
                'grade' => $child->studentProfile?->classRoom?->grade,
            ])
            ->values()
            ->all();
    }

    /**
     * The school's branding, translated into what the app can actually apply.
     *
     * The web stores a border radius as a keyword and a font as one of three
     * Latin-first faces. The app needs a number, and it needs an Arabic face —
     * so the radius is mapped and the font is the one the app ships. The
     * school's own `font_style` is reported alongside rather than dropped, so
     * nothing is lost if a later order bundles those faces.
     *
     * @return array<string, mixed>
     */
    private function theme(): array
    {
        // A school that has never opened the settings screen has no row at
        // all. Every read here is null-safe so that school gets the defaults
        // rather than a 500 on its first launch.
        $settings = SchoolSetting::query()->first();
        $radii = (array) config('mobile.border_radii', []);
        $radiusKeyword = $settings?->border_radius ?? 'rounded';

        return [
            'primaryColor' => $settings?->primary_color ?? '#6C63FF',
            'accentColor' => $settings?->accent_color ?? '#FF6584',
            'fontFamily' => (string) config('mobile.font_family', 'Tajawal'),
            'fontStyle' => $settings?->font_style ?? 'modern',
            'borderRadius' => (int) ($radii[$radiusKeyword] ?? 12),
            'schoolName' => $settings?->school_name ?? null,
        ];
    }

    /** @return array<string, bool> */
    private function features(): array
    {
        return array_map(
            static fn ($enabled): bool => (bool) $enabled,
            (array) config('mobile.features', []),
        );
    }

    /**
     * Unread notifications for this account.
     *
     * Account-wide, not per child. `notifications` has no child column and its
     * `data` payload is not guaranteed to carry one, so a per-child count would
     * be invented rather than measured — and a fee badge against the wrong
     * child is worse than no badge.
     */
    private function unreadCount(User $user): int
    {
        return Notification::query()
            ->where('user_id', $user->id)
            ->whereNull('read_at')
            ->count();
    }
}
