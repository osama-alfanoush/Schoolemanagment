<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ReportCardIssue extends Model
{
    protected $fillable = [
        'student_enrollment_id', 'grading_period_id', 'issue_version', 'snapshot',
        'document_path', 'checksum', 'correction_reason', 'issued_by', 'issued_at',
    ];

    protected $casts = ['snapshot' => 'array', 'issue_version' => 'integer', 'issued_at' => 'datetime'];
}
