<?php

declare(strict_types=1);

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * A deletion the mobile delta feed still has to report.
 *
 * @property int $id
 * @property int $school_id
 * @property string $entity_type
 * @property int $entity_id
 * @property int|null $subject_user_id
 * @property int|null $class_room_id
 */
class SyncTombstone extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'school_id', 'entity_type', 'entity_id',
        'subject_user_id', 'class_room_id', 'deleted_at',
    ];

    protected $casts = [
        'entity_id' => 'integer',
        'school_id' => 'integer',
        'subject_user_id' => 'integer',
        'class_room_id' => 'integer',
        'deleted_at' => 'datetime',
    ];
}
