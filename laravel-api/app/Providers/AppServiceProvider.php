<?php

namespace App\Providers;

use App\Models\PersonalAccessToken;
use App\Models\School;
use App\Models\User;
use App\Services\CurrentSchool;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;
use Laravel\Sanctum\Sanctum;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(CurrentSchool::class);

        // A production deploy must never render stack traces, SQL or env dumps
        // because someone left APP_DEBUG=true in the platform variables. The
        // value is forced off before the exception handler is resolved, so the
        // mistake degrades to "no debug output" instead of leaking internals.
        // ops:preflight-env surfaces the misconfiguration loudly at boot.
        if ($this->app->environment('production') && config('app.debug')) {
            config(['app.debug' => false, 'app.debug_forced_off' => true]);
            $this->app->make('log')->critical(
                'APP_DEBUG was enabled in production and has been forced off. Fix the environment variable.'
            );
        }
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Sanctum::usePersonalAccessTokenModel(PersonalAccessToken::class);

        $currentSchool = $this->app->make(CurrentSchool::class);
        foreach (config('tenancy.models', []) as $modelClass) {
            $modelClass::addGlobalScope('school', function (Builder $query) use ($currentSchool): void {
                if ($currentSchool->has()) {
                    $query->where($query->qualifyColumn('school_id'), $currentSchool->id());
                }
            });
            $modelClass::creating(function (Model $model) use ($currentSchool): void {
                $schoolId = $currentSchool->idOrNull();
                if ($schoolId === null) {
                    // CLI seeds and tests may run without HTTP middleware. A
                    // single school is unambiguous; multiple schools must set
                    // CurrentSchool explicitly and will fail closed otherwise.
                    $ids = School::query()->limit(2)->pluck('id');
                    $schoolId = $ids->count() === 1 ? (int) $ids->first() : null;
                }
                if ($schoolId !== null) {
                    // The resolved context is authoritative. Client input can
                    // never move a new row into another school.
                    $model->setAttribute('school_id', $schoolId);
                }
            });
            $modelClass::updating(function (Model $model) use ($currentSchool): void {
                if ($currentSchool->has()) {
                    // School ownership is immutable in request/worker tenant
                    // context, even if an internal caller uses forceFill().
                    $model->setAttribute('school_id', $currentSchool->id());
                }
            });
        }

        // Users are identities rather than school-owned rows, so they cannot
        // carry school_id. Once a tenant context exists, nevertheless, every
        // fresh User query must be constrained to an active membership in that
        // school. Authentication runs before tenant resolution and is therefore
        // unaffected; controllers, exports and workers fail closed afterwards.
        User::addGlobalScope('schoolMembership', function (Builder $query) use ($currentSchool): void {
            if (! $currentSchool->has()) {
                return;
            }

            $today = now()->toDateString();
            $query->whereExists(function ($membership) use ($currentSchool, $today): void {
                $membership->selectRaw('1')
                    ->from('school_user_roles')
                    ->whereColumn('school_user_roles.user_id', 'users.id')
                    ->where('school_user_roles.school_id', $currentSchool->id())
                    ->where(function ($dates) use ($today): void {
                        $dates->whereNull('school_user_roles.starts_on')
                            ->orWhere('school_user_roles.starts_on', '<=', $today);
                    })
                    ->where(function ($dates) use ($today): void {
                        $dates->whereNull('school_user_roles.ends_on')
                            ->orWhere('school_user_roles.ends_on', '>=', $today);
                    });
            });
        });

        RateLimiter::for('login', function (Request $request) {
            $email = mb_strtolower(trim((string) $request->input('email')));
            $ip = $request->ip();

            return [
                // A campus NAT may legitimately produce a large login burst.
                Limit::perMinute(500)->by('login-ip:'.$ip),
                // Credential stuffing is constrained per normalized identity.
                Limit::perMinute(8)->by('login-account:'.hash('sha256', $email)),
                Limit::perMinute(3000)->by('login-global'),
            ];
        });

        // Behind TLS-terminating proxies (Railway's edge, a CDN, etc.) the
        // container itself speaks plain HTTP, so route()/url()/Storage::url()
        // would otherwise emit http:// links and cause mixed-content errors on
        // the HTTPS frontend. Forcing the scheme keeps every generated URL
        // https:// in production regardless of what the proxy forwards.
        if ($this->app->environment('production')) {
            URL::forceScheme('https');
        }
    }
}
