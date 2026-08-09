<?php

return [
    // The browser never receives either Sanctum token in JavaScript. Native
    // clients continue to use the existing bearer-token response contract.
    'access_cookie' => env('WEB_AUTH_ACCESS_COOKIE', 'school_access'),
    'refresh_cookie' => env('WEB_AUTH_REFRESH_COOKIE', 'school_refresh'),
    'csrf_cookie' => env('WEB_AUTH_CSRF_COOKIE', 'XSRF-TOKEN'),
    'domain' => env('WEB_AUTH_COOKIE_DOMAIN'),
    'secure' => env('WEB_AUTH_COOKIE_SECURE', env('APP_ENV') === 'production'),
    'same_site' => env('WEB_AUTH_COOKIE_SAME_SITE', 'lax'),
    'access_minutes' => (int) env('WEB_AUTH_ACCESS_MINUTES', 120),
    'refresh_minutes' => (int) env('WEB_AUTH_REFRESH_MINUTES', 43200),
];
