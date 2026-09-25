<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\SyncTombstone;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;
use Throwable;

/**
 * Turns a deletion into something the delta feed can still report.
 *
 * Hooked to the Eloquent `deleted` event rather than written into each
 * controller, so a deletion added later is covered without anyone remembering
 * to. Two limits are worth stating plainly rather than discovering later:
 *
 *  - A row removed by a database-level `ON DELETE CASCADE` fires no Eloquent
 *    event and leaves no tombstone. Cascades here follow the owning record
 *    (a class room, a student), whose own deletion is itself reported, so the
 *    client drops the subtree from that. A cascade with no reported parent
 *    would need a database trigger.
 *  - A raw `DB::table(...)->delete()` is likewise invisible.
 *
 * Recording is best-effort: failing to write a tombstone must never turn a
 * successful delete into a 500. It is logged instead, without the row's
 * contents.
 */
final class SyncTombstoneRecorder
{
    public function __construct(private readonly DeltaEntityRegistry $registry) {}

    public function record(Model $model): void
    {
        $definition = $this->registry->forModel($model);

        if ($definition === null) {
            return;
        }

        $schoolId = $model->getAttribute('school_id');

        if ($schoolId === null) {
            return;
        }

        try {
            $keys = $definition->keysFor($model);

            SyncTombstone::query()->create([
                'school_id' => (int) $schoolId,
                'entity_type' => $definition->type,
                'entity_id' => (int) $model->getKey(),
                'subject_user_id' => $keys['subject_user_id'],
                'class_room_id' => $keys['class_room_id'],
                'deleted_at' => now(),
            ]);
        } catch (Throwable $e) {
            // Identifiers only. The deleted row's contents never reach a log.
            Log::warning('Could not record a sync tombstone.', [
                'entity_type' => $definition->type,
                'entity_id' => $model->getKey(),
                'exception' => $e::class,
            ]);
        }
    }
}
