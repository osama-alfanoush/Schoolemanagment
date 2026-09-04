<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\Installment;
use App\Models\Invoice;
use App\Models\Notification;
use App\Models\PaymentPlan;
use App\Models\TimetableEntry;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Query\Builder as QueryBuilder;

/**
 * The entity types the mobile delta feed serves, and the only place their
 * visibility rules are written down.
 *
 * Finance types are deliberately absent from the teacher and student sets: a
 * teacher has no business reading a family's invoice, and a student is reached
 * about fees through their guardian.
 */
final class DeltaEntityRegistry
{
    /** @var array<string, DeltaEntityDefinition>|null */
    private ?array $definitions = null;

    /** @return array<string, DeltaEntityDefinition> */
    public function all(): array
    {
        return $this->definitions ??= $this->build();
    }

    public function find(string $type): ?DeltaEntityDefinition
    {
        return $this->all()[$type] ?? null;
    }

    /** @return list<string> */
    public function typesFor(string $role): array
    {
        return array_values(array_keys(array_filter(
            $this->all(),
            fn (DeltaEntityDefinition $definition): bool => $definition->readableBy($role),
        )));
    }

    public function forModel(Model $model): ?DeltaEntityDefinition
    {
        foreach ($this->all() as $definition) {
            if ($model::class === $definition->modelClass) {
                return $definition;
            }
        }

        return null;
    }

    /** @return array<string, DeltaEntityDefinition> */
    private function build(): array
    {
        $definitions = [
            $this->attendanceRecord(),
            $this->grade(),
            $this->assignment(),
            $this->timetableEntry(),
            $this->invoice(),
            $this->installment(),
            $this->announcement(),
            $this->notification(),
        ];

        $keyed = [];
        foreach ($definitions as $definition) {
            $keyed[$definition->type] = $definition;
        }

        ksort($keyed);

        return $keyed;
    }

    /* ---------- entity types ---------- */

    private function attendanceRecord(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'attendance_record',
            modelClass: AttendanceRecord::class,
            roles: ['parent', 'student', 'teacher'],
            scope: function (Builder $query, DeltaAudience $audience): ?Builder {
                if ($audience->role === 'teacher') {
                    return self::restrictTo($query, 'attendance_records.class_room_id', $audience->classRoomIds);
                }

                return self::restrictTo($query, 'attendance_records.student_user_id', $audience->studentUserIds);
            },
            payload: fn (AttendanceRecord $record): array => [
                'id' => $record->id,
                'student_user_id' => (int) $record->student_user_id,
                'class_room_id' => (int) $record->class_room_id,
                'subject_id' => $record->subject_id === null ? null : (int) $record->subject_id,
                'date' => $record->date?->toDateString(),
                'status' => $record->status,
                'note' => $record->note,
                'updated_at' => $record->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => $audience->role === 'teacher'
                ? self::restrictTo($query, 'class_room_id', $audience->classRoomIds)
                : self::restrictTo($query, 'subject_user_id', $audience->studentUserIds),
            tombstoneKeys: fn (AttendanceRecord $record): array => [
                'subject_user_id' => (int) $record->student_user_id,
                'class_room_id' => (int) $record->class_room_id,
            ],
        );
    }

    private function grade(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'grade',
            modelClass: Grade::class,
            roles: ['parent', 'student', 'teacher'],
            scope: function (Builder $query, DeltaAudience $audience): ?Builder {
                if ($audience->role !== 'teacher') {
                    return self::restrictTo($query, 'grades.student_user_id', $audience->studentUserIds);
                }

                if ($audience->teachingAssignments === []) {
                    return null;
                }

                // One subquery, not one query per grade: a teacher sees a mark
                // only for the exact class+subject they are assigned to, which
                // is the same rule TeacherController enforces on write.
                return $query->whereIn('grades.grade_component_id', GradeComponent::query()
                    ->where('school_id', $audience->schoolId)
                    ->where(function (Builder $inner) use ($audience): void {
                        foreach ($audience->teachingAssignments as $assignment) {
                            $inner->orWhere(fn (Builder $pair) => $pair
                                ->where('class_room_id', $assignment['class_room_id'])
                                ->where('subject_id', $assignment['subject_id']));
                        }
                    })
                    ->select('id'));
            },
            payload: fn (Grade $grade): array => [
                'id' => $grade->id,
                'student_user_id' => (int) $grade->student_user_id,
                'grade_component_id' => (int) $grade->grade_component_id,
                'score' => (string) $grade->score,
                'updated_at' => $grade->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => $audience->role === 'teacher'
                ? self::restrictTo($query, 'class_room_id', $audience->classRoomIds)
                : self::restrictTo($query, 'subject_user_id', $audience->studentUserIds),
            tombstoneKeys: fn (Grade $grade): array => [
                'subject_user_id' => (int) $grade->student_user_id,
                'class_room_id' => self::nullableId(
                    GradeComponent::whereKey($grade->grade_component_id)->value('class_room_id')
                ),
            ],
        );
    }

    private function assignment(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'assignment',
            modelClass: Assignment::class,
            roles: ['parent', 'student', 'teacher'],
            scope: fn (Builder $query, DeltaAudience $audience): ?Builder => self::restrictTo(
                $query,
                'assignments.class_room_id',
                $audience->classRoomIds,
            ),
            payload: fn (Assignment $assignment): array => [
                'id' => $assignment->id,
                'class_room_id' => (int) $assignment->class_room_id,
                'subject_id' => (int) $assignment->subject_id,
                'teacher_user_id' => (int) $assignment->teacher_user_id,
                'title' => $assignment->title,
                'instructions' => $assignment->instructions,
                // The private-disk path never leaves the server; clients fetch
                // attachments through FileController, which re-authorises.
                'has_attachment' => $assignment->attachment_path !== null,
                'due_at' => $assignment->due_at?->toIso8601String(),
                'max_score' => (string) $assignment->max_score,
                'updated_at' => $assignment->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => self::restrictTo(
                $query,
                'class_room_id',
                $audience->classRoomIds,
            ),
            tombstoneKeys: fn (Assignment $assignment): array => [
                'subject_user_id' => null,
                'class_room_id' => (int) $assignment->class_room_id,
            ],
        );
    }

    private function timetableEntry(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'timetable_entry',
            modelClass: TimetableEntry::class,
            roles: ['parent', 'student', 'teacher'],
            scope: function (Builder $query, DeltaAudience $audience): ?Builder {
                if ($audience->role !== 'teacher') {
                    return self::restrictTo($query, 'timetable_entries.class_room_id', $audience->classRoomIds);
                }

                // A teacher covering a period in a class they are not otherwise
                // assigned to still needs that period on their own timetable.
                return $query->where(fn (Builder $inner) => $inner
                    ->where('timetable_entries.teacher_user_id', $audience->user->id)
                    ->orWhereIn('timetable_entries.class_room_id', $audience->classRoomIds));
            },
            payload: fn (TimetableEntry $entry): array => [
                'id' => $entry->id,
                'class_room_id' => (int) $entry->class_room_id,
                'subject_id' => (int) $entry->subject_id,
                'teacher_user_id' => (int) $entry->teacher_user_id,
                'day_of_week' => (int) $entry->day_of_week,
                'start_time' => (string) $entry->start_time,
                'end_time' => (string) $entry->end_time,
                'room' => $entry->room,
                'updated_at' => $entry->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => self::restrictTo(
                $query,
                'class_room_id',
                $audience->classRoomIds,
            ),
            tombstoneKeys: fn (TimetableEntry $entry): array => [
                'subject_user_id' => null,
                'class_room_id' => (int) $entry->class_room_id,
            ],
        );
    }

    private function invoice(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'invoice',
            modelClass: Invoice::class,
            roles: ['parent'],
            scope: fn (Builder $query, DeltaAudience $audience): ?Builder => self::restrictTo(
                $query,
                'invoices.student_user_id',
                $audience->studentUserIds,
            ),
            payload: fn (Invoice $invoice): array => [
                'id' => $invoice->id,
                'student_user_id' => (int) $invoice->student_user_id,
                'invoice_no' => $invoice->invoice_no,
                'description' => $invoice->description,
                'amount' => MobileMoney::payload($invoice->getRawOriginal('amount')),
                'paid_amount' => MobileMoney::payload($invoice->getRawOriginal('paid_amount')),
                'due_date' => $invoice->due_date?->toDateString(),
                'status' => $invoice->status,
                'updated_at' => $invoice->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => self::restrictTo(
                $query,
                'subject_user_id',
                $audience->studentUserIds,
            ),
            tombstoneKeys: fn (Invoice $invoice): array => [
                'subject_user_id' => (int) $invoice->student_user_id,
                'class_room_id' => null,
            ],
        );
    }

    private function installment(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'installment',
            modelClass: Installment::class,
            roles: ['parent'],
            scope: function (Builder $query, DeltaAudience $audience): ?Builder {
                if ($audience->studentUserIds === []) {
                    return null;
                }

                // The owning student lives on the plan. Selected as a subquery
                // so the payload never has to touch the relation per row.
                return $query
                    ->addSelect('installments.*')
                    ->addSelect(['plan_student_user_id' => PaymentPlan::query()
                        ->whereColumn('payment_plans.id', 'installments.payment_plan_id')
                        ->select('student_user_id')
                        ->limit(1)])
                    ->whereIn('installments.payment_plan_id', PaymentPlan::query()
                        ->where('school_id', $audience->schoolId)
                        ->whereIn('student_user_id', $audience->studentUserIds)
                        ->select('id'));
            },
            payload: fn (Installment $installment): array => [
                'id' => $installment->id,
                'payment_plan_id' => (int) $installment->payment_plan_id,
                'student_user_id' => (int) $installment->getAttribute('plan_student_user_id'),
                'sequence_no' => (int) $installment->sequence_no,
                'due_date' => $installment->due_date?->toDateString(),
                'amount' => MobileMoney::payload($installment->getRawOriginal('amount')),
                'paid_amount' => MobileMoney::payload($installment->getRawOriginal('paid_amount')),
                'status' => $installment->status,
                'updated_at' => $installment->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => self::restrictTo(
                $query,
                'subject_user_id',
                $audience->studentUserIds,
            ),
            tombstoneKeys: fn (Installment $installment): array => [
                'subject_user_id' => self::nullableId(
                    PaymentPlan::withTrashed()->whereKey($installment->payment_plan_id)->value('student_user_id')
                ),
                'class_room_id' => null,
            ],
        );
    }

    private function announcement(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'announcement',
            modelClass: Announcement::class,
            roles: ['parent', 'student', 'teacher'],
            scope: fn (Builder $query, DeltaAudience $audience): ?Builder => $query
                ->whereIn('announcements.audience', self::announcementAudiences($audience)),
            payload: fn (Announcement $announcement): array => [
                'id' => $announcement->id,
                'audience' => $announcement->audience,
                'title' => $announcement->title,
                'body' => $announcement->body,
                'updated_at' => $announcement->updated_at?->toIso8601String(),
            ],
            // An announcement carries no per-child key, so its tombstone is
            // visible to anyone in the school who could have been shown it.
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => $query,
            tombstoneKeys: fn (Announcement $announcement): array => [
                'subject_user_id' => null,
                'class_room_id' => null,
            ],
        );
    }

    private function notification(): DeltaEntityDefinition
    {
        return new DeltaEntityDefinition(
            type: 'notification',
            modelClass: Notification::class,
            roles: ['parent', 'student', 'teacher'],
            scope: fn (Builder $query, DeltaAudience $audience): ?Builder => $query
                ->where('notifications.user_id', $audience->user->id),
            payload: fn (Notification $notification): array => [
                'id' => $notification->id,
                'type' => $notification->type,
                'category' => $notification->category,
                'priority' => $notification->priority,
                'title' => $notification->title,
                'body' => $notification->body,
                'action_url' => $notification->action_url,
                'read_at' => $notification->read_at?->toIso8601String(),
                'created_at' => $notification->created_at?->toIso8601String(),
                'updated_at' => $notification->updated_at?->toIso8601String(),
            ],
            tombstoneScope: fn (QueryBuilder $query, DeltaAudience $audience): ?QueryBuilder => $query
                ->where('subject_user_id', $audience->user->id),
            tombstoneKeys: fn (Notification $notification): array => [
                'subject_user_id' => (int) $notification->user_id,
                'class_room_id' => null,
            ],
        );
    }

    /* ---------- helpers ---------- */

    /**
     * Narrow to an id list, or report that the audience sees nothing.
     *
     * Returning null rather than `whereIn(column, [])` is deliberate: an empty
     * IN list is a query the caller can skip entirely, and skipping it keeps
     * the query-count ceiling honest for a parent with no children.
     *
     * @param  list<int>  $ids
     */
    private static function restrictTo(Builder|QueryBuilder $query, string $column, array $ids): Builder|QueryBuilder|null
    {
        if ($ids === []) {
            return null;
        }

        return $query->whereIn($column, $ids);
    }

    private static function nullableId(mixed $value): ?int
    {
        return $value === null ? null : (int) $value;
    }

    /** @return list<string> */
    private static function announcementAudiences(DeltaAudience $audience): array
    {
        $audiences = ['all', 'role:'.$audience->role];

        if ($audience->role === 'parent') {
            $audiences[] = 'parents';
        }

        foreach ($audience->classRoomIds as $classRoomId) {
            $audiences[] = 'class:'.$classRoomId;
        }

        return $audiences;
    }
}
