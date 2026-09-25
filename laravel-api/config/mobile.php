<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Money
    |--------------------------------------------------------------------------
    |
    | Mobile payloads carry money as integer minor units, never as a decimal
    | string and never as a float.
    |
    | JOD is nominally a THREE-decimal currency: 1 JOD = 1000 fils. The
    | relational columns are decimal(x,2) and the server's whole internal
    | minor unit is the qirsh, so the third decimal does not exist anywhere on
    | this side. The wire therefore declares TWO, which is what the server can
    | actually store.
    |
    | The scale is deliberately not configurable. It lives on
    | `MobileMoney::decimals()`, pinned to the column scale by
    | `MoneyColumnScaleTest`, because an env var that disagreed with the
    | database would not add precision — it would only make every payload
    | claim precision the database cannot hold. See
    | docs/finance/money-precision-audit.md.
    |
    */

    'currency' => env('MOBILE_CURRENCY', 'JOD'),

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

    /*
    |--------------------------------------------------------------------------
    | Version policy
    |--------------------------------------------------------------------------
    |
    | Read by the app's upgrade gate on every bootstrap. `min_supported_version`
    | blocks anything older; `force_upgrade` is the kill switch for a build that
    | is new enough but known broken. A value the client cannot parse disables
    | the gate rather than closing it, so a typo here cannot brick every
    | installed copy at once.
    |
    */

    'min_supported_version' => env('MOBILE_MIN_SUPPORTED_VERSION', '0.1.0'),

    'recommended_version' => env('MOBILE_RECOMMENDED_VERSION'),

    'force_upgrade' => (bool) env('MOBILE_FORCE_UPGRADE', false),

    /*
    |--------------------------------------------------------------------------
    | Feature flags
    |--------------------------------------------------------------------------
    |
    | Sent to the app at bootstrap so a screen can be turned off without a
    | release. Anything not listed here is absent, not false: the client treats
    | an unknown flag as off.
    |
    */

    'features' => [
        'parent_payments' => (bool) env('MOBILE_FEATURE_PARENT_PAYMENTS', true),
        'parent_messages' => (bool) env('MOBILE_FEATURE_PARENT_MESSAGES', true),
        'teacher_attendance' => (bool) env('MOBILE_FEATURE_TEACHER_ATTENDANCE', true),
        'student_app' => (bool) env('MOBILE_FEATURE_STUDENT_APP', true),
    ],

    /*
    |--------------------------------------------------------------------------
    | Theme
    |--------------------------------------------------------------------------
    |
    | The web settings screen stores a border radius as a keyword. The app needs
    | a number, so the mapping lives here rather than being guessed twice.
    |
    */

    'border_radii' => [
        'sharp' => 0,
        'medium' => 12,
        'rounded' => 20,
    ],

    /*
    | The app ships one font, and it is the right one: the web's three choices
    | (Plus Jakarta Sans, Merriweather, Nunito) are Latin-first faces with no
    | Arabic coverage, and this is an Arabic-first app. The school's font_style
    | is still reported so a later order can bundle equivalents if it ever
    | matters.
    */

    'font_family' => env('MOBILE_FONT_FAMILY', 'Tajawal'),

    /*
    |--------------------------------------------------------------------------
    | Messaging
    |--------------------------------------------------------------------------
    |
    | Threads on the mobile surface are teacher- or school-initiated only. A
    | guardian may reply to a thread staff opened; they cannot start one.
    | Unconstrained parent-initiated chat is how teachers come to hate the
    | product, and staff resistance is what kills a pilot.
    |
    | Replies are also confined to working hours, so a message sent at 23:40 is
    | refused rather than landing on a teacher's lock screen. The plan calls for
    | this to be school-configurable; `school_settings` has no column for it, so
    | it is configuration for now and a per-school setting is the follow-up.
    |
    */

    'messaging' => [
        'reply_from' => env('MOBILE_MESSAGING_FROM', '07:00'),
        'reply_to' => env('MOBILE_MESSAGING_TO', '17:00'),
    ],

    /*
    |--------------------------------------------------------------------------
    | Notification categories
    |--------------------------------------------------------------------------
    |
    | The categories a user may mute, each independently: muting grades must
    | never mute fee reminders. `emergency` is deliberately absent — it is the
    | one category that always delivers, and offering a switch that does not
    | work is worse than offering none.
    |
    */

    'notification_categories' => ['fees', 'attendance', 'grades', 'messages', 'announcements'],

    'always_on_categories' => ['emergency'],

    /*
    |--------------------------------------------------------------------------
    | Teacher announcements
    |--------------------------------------------------------------------------
    |
    | A teacher can reach thirty families from a phone in one tap. Free text on
    | that surface is a moderation obligation nobody here is staffed to carry,
    | so the phone sends an approved template with a short detail filled in and
    | nothing else. Anything longer belongs on the web, where it is reviewed.
    |
    | The window is the same idea as the messaging one: a notification at 23:40
    | wakes a household, and doing that once costs the pilot more goodwill than
    | the notice was ever worth.
    |
    */

    'announcements' => [
        'from' => env('MOBILE_ANNOUNCE_FROM', '07:00'),
        'to' => env('MOBILE_ANNOUNCE_TO', '17:00'),

        // Keys are stable; the text is the school's, in its own language. The
        // client renders `title` and `body` as they arrive rather than keeping
        // its own copy, so a wording change does not need an app release.
        'templates' => [
            'homework_reminder' => [
                'title' => 'تذكير بالواجب',
                'body' => 'يرجى متابعة إنجاز الواجب المطلوب. :detail',
            ],
            'bring_materials' => [
                'title' => 'إحضار مستلزمات',
                'body' => 'يرجى إحضار المستلزمات التالية في الحصة القادمة: :detail',
            ],
            'positive_note' => [
                'title' => 'ملاحظة إيجابية',
                'body' => 'أداء مميز في الحصة. :detail',
            ],
            'absence_followup' => [
                'title' => 'متابعة غياب',
                'body' => 'نود متابعة سبب الغياب. :detail',
            ],
        ],

        // The detail is a sentence, not a letter. A cap here is also what keeps
        // a template from becoming free text by another name.
        'detail_max' => 200,
    ],

    'delta' => [
        'page_size' => (int) env('MOBILE_DELTA_PAGE_SIZE', 200),
        'max_page_size' => (int) env('MOBILE_DELTA_MAX_PAGE_SIZE', 500),
    ],

];
