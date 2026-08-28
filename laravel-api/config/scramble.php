<?php

use Dedoc\Scramble\SecurityDocumentation\MiddlewareAuthSecurityStrategy;

return [
    'api_path' => 'api',

    'info' => [
        'version' => env('API_VERSION', '1.0.0'),
        'description' => 'Canonical contract for the School Management Suite web and mobile clients.',
    ],

    'security_strategy' => MiddlewareAuthSecurityStrategy::class,
];
