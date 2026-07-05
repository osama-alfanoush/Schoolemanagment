<?php

namespace App\Providers;

use Illuminate\Support\Facades\URL;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
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
