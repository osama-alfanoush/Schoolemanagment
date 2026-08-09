<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['GET', 'POST', 'PATCH', 'DELETE', 'OPTIONS'],

    'allowed_origins' => explode(',', env('CORS_ALLOWED_ORIGINS', 'http://localhost:5173')),

    // Local origins are accepted only outside production. Native clients send
    // no Origin header and do not need a CORS exception.
    'allowed_origins_patterns' => env('APP_ENV', 'production') === 'production' ? [] : [
        '#^https?://localhost(:\d+)?$#',
        '#^https?://127\.0\.0\.1(:\d+)?$#',
    ],

    'allowed_headers' => [
        'Content-Type',
        'Authorization',
        'Accept',
        'X-Requested-With',
        'X-Auth-Mode',
        'X-XSRF-TOKEN',
        'Idempotency-Key',
    ],

    'exposed_headers' => [],

    'max_age' => 86400,

    'supports_credentials' => true,

];
