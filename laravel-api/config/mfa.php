<?php

return [
    'enabled' => (bool) env('MFA_ENABLED', true),
    'required_roles' => array_values(array_filter(array_map(
        'trim',
        explode(',', env('MFA_REQUIRED_ROLES', 'admin,finance,hr,warehouse,procurement'))
    ))),
    'challenge_minutes' => (int) env('MFA_CHALLENGE_MINUTES', 5),
    'enrollment_minutes' => (int) env('MFA_ENROLLMENT_MINUTES', 10),
    'recovery_code_count' => (int) env('MFA_RECOVERY_CODE_COUNT', 10),
];
