<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SchoolSetting extends Model
{
    protected $fillable = [
        'school_name', 'school_motto', 'academic_year',
        'address', 'primary_color', 'accent_color',
        'sidebar_style', 'border_radius', 'font_style',
        'school_logo',
    ];
}
