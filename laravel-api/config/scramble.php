<?php

use Dedoc\Scramble\Http\Middleware\RestrictedDocsAccess;
use Dedoc\Scramble\SecurityDocumentation\MiddlewareAuthSecurityStrategy;

return [
    'middleware' => ['web', RestrictedDocsAccess::class],

    'dev_tools' => [
        'enabled' => env('SCRAMBLE_DEV_TOOLS', false),
    ],

    'api_path' => 'api',

    'info' => [
        'version' => env('API_VERSION', '1.0.0'),
        'description' => 'Canonical contract for the School Management Suite web and mobile clients.',
    ],

    'security_strategy' => MiddlewareAuthSecurityStrategy::class,
];
