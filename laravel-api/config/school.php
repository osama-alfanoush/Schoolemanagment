<?php

return [
    /*
     * How many hours after a session a teacher may still create or modify
     * attendance records for that date. Past this cutoff the endpoint returns
     * 422; an administrator may still mutate the row directly.
     */
    'attendance_edit_window_hours' => (int) env('ATTENDANCE_EDIT_WINDOW_HOURS', 48),
];
