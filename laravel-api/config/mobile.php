<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Money
    |--------------------------------------------------------------------------
    |
    | Mobile payloads carry money as integer minor units, never as a decimal
    | string and never as a float. JOD has THREE decimals: 1 JOD = 1000 fils.
    | The relational columns are decimal(12,2), so the mobile layer widens the
    | scale on the way out; it never narrows it, because narrowing loses a fil.
    |
    */

    'currency' => env('MOBILE_CURRENCY', 'JOD'),

    'currency_decimals' => (int) env('MOBILE_CURRENCY_DECIMALS', 3),

    /*
    |--------------------------------------------------------------------------
    | Delta sync
    |--------------------------------------------------------------------------
    |
    | `page_size` is the default number of changes in one delta page and
    | `max_page_size` the ceiling a client may ask for. The ceiling is what
    | stops a client turning the feed into a full-table export in one request.
    |
    */

    'delta' => [
        'page_size' => (int) env('MOBILE_DELTA_PAGE_SIZE', 200),
        'max_page_size' => (int) env('MOBILE_DELTA_MAX_PAGE_SIZE', 500),
    ],

];
