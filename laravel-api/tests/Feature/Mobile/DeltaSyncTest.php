<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\Announcement;
use App\Models\Assignment;
use App\Models\AttendanceRecord;
use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\Invoice;
use App\Models\Notification;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\SyncTombstone;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class DeltaSyncTest extends TestCase
{
    use RefreshDatabase;

    private const ENDPOINT = '/api/mobile/v1/sync/delta';

    /* ---------- fixtures ---------- */

    /** @return array{parent: User, child: User, class: ClassRoom} */
    private function family(): array
    {
        $parent = User::factory()->parentRole()->create();
        $child = User::factory()->student()->create();
        $child->parents()->attach($parent);

        $class = ClassRoom::factory()->create();
        StudentProfile::factory()->create(['user_id' => $child->id, 'class_room_id' => $class->id]);

        return ['parent' => $parent, 'child' => $child, 'class' => $class];
    }

    private function attendanceFor(User $student, ClassRoom $class, string $date, string $status = 'present'): AttendanceRecord
    {
        return AttendanceRecord::create([
            'student_user_id' => $student->id,
            'class_room_id' => $class->id,
            'date' => $date,
            'status' => $status,
            'marked_by' => $student->id,
        ]);
    }

    /** @return list<array<string, mixed>> */
    private function changes(array $json): array
    {
        return $json['data']['changes'];
    }

    /** @return list<string> */
    private function idsOfType(array $json, string $type): array
    {
        return array_values(array_map(
            fn (array $change): string => $change['id'],
            array_filter($this->changes($json), fn (array $c): bool => $c['type'] === $type),
        ));
    }

    /* ---------- authorization ---------- */

    public function test_the_feed_requires_authentication(): void
    {
        $this->getJson(self::ENDPOINT)->assertStatus(401);
    }

    public function test_roles_without_a_mobile_app_cannot_reach_the_feed(): void
    {
        foreach (['admin', 'finance', 'hr'] as $role) {
            $this->actingAs(User::factory()->create(['role' => $role]))
                ->getJson(self::ENDPOINT)
                ->assertStatus(403);
        }
    }

    public function test_a_parents_delta_never_contains_another_familys_entity(): void
    {
        ['parent' => $parentA, 'child' => $childA, 'class' => $classA] = $this->family();
        ['child' => $childB, 'class' => $classB] = $this->family();

        $mine = $this->attendanceFor($childA, $classA, '2026-09-01');
        $theirs = $this->attendanceFor($childB, $classB, '2026-09-01');

        $response = $this->actingAs($parentA)
            ->getJson(self::ENDPOINT.'?types=attendance_record')
            ->assertOk();

        $ids = $this->idsOfType($response->json(), 'attendance_record');

        $this->assertSame([(string) $mine->id], $ids);
        $this->assertNotContains((string) $theirs->id, $ids);
    }

    public function test_a_parents_delta_never_contains_another_familys_invoice(): void
    {
        ['parent' => $parentA, 'child' => $childA] = $this->family();
        ['child' => $childB] = $this->family();

        $mine = Invoice::factory()->create(['student_user_id' => $childA->id]);
        $theirs = Invoice::factory()->create(['student_user_id' => $childB->id]);

        $ids = $this->idsOfType(
            $this->actingAs($parentA)->getJson(self::ENDPOINT.'?types=invoice')->assertOk()->json(),
            'invoice',
        );

        $this->assertSame([(string) $mine->id], $ids);
        $this->assertNotContains((string) $theirs->id, $ids);
    }

    public function test_a_teacher_reads_only_assigned_classes(): void
    {
        $teacher = User::factory()->teacher()->create();
        $subject = Subject::factory()->create();
        $assigned = ClassRoom::factory()->create();
        $other = ClassRoom::factory()->create();

        DB::table('class_subject_teacher')->insert([
            'school_id' => $assigned->school_id,
            'class_room_id' => $assigned->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $teacher->id,
        ]);

        $studentHere = User::factory()->student()->create();
        $studentElsewhere = User::factory()->student()->create();

        $visible = $this->attendanceFor($studentHere, $assigned, '2026-09-01');
        $hidden = $this->attendanceFor($studentElsewhere, $other, '2026-09-01');

        $ids = $this->idsOfType(
            $this->actingAs($teacher)->getJson(self::ENDPOINT.'?types=attendance_record')->assertOk()->json(),
            'attendance_record',
        );

        $this->assertSame([(string) $visible->id], $ids);
        $this->assertNotContains((string) $hidden->id, $ids);
    }

    public function test_a_teacher_reads_marks_only_for_the_class_and_subject_they_teach(): void
    {
        $teacher = User::factory()->teacher()->create();
        $mine = Subject::factory()->create();
        $notMine = Subject::factory()->create();
        $class = ClassRoom::factory()->create();

        DB::table('class_subject_teacher')->insert([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => $mine->id,
            'teacher_user_id' => $teacher->id,
        ]);

        $student = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $student->id, 'class_room_id' => $class->id]);

        $visible = Grade::create([
            'student_user_id' => $student->id,
            'grade_component_id' => GradeComponent::factory()->create([
                'class_room_id' => $class->id, 'subject_id' => $mine->id,
            ])->id,
            'score' => 80,
            'entered_by' => $teacher->id,
        ]);

        // Same class, a colleague's subject. Not this teacher's to read.
        $hidden = Grade::create([
            'student_user_id' => $student->id,
            'grade_component_id' => GradeComponent::factory()->create([
                'class_room_id' => $class->id, 'subject_id' => $notMine->id,
            ])->id,
            'score' => 41,
            'entered_by' => $teacher->id,
        ]);

        $ids = $this->idsOfType(
            $this->actingAs($teacher)->getJson(self::ENDPOINT.'?types=grade')->assertOk()->json(),
            'grade',
        );

        $this->assertSame([(string) $visible->id], $ids);
        $this->assertNotContains((string) $hidden->id, $ids);
    }

    public function test_a_student_reads_only_their_own_records(): void
    {
        $class = ClassRoom::factory()->create();
        $me = User::factory()->student()->create();
        $classmate = User::factory()->student()->create();
        StudentProfile::factory()->create(['user_id' => $me->id, 'class_room_id' => $class->id]);
        StudentProfile::factory()->create(['user_id' => $classmate->id, 'class_room_id' => $class->id]);

        $mine = $this->attendanceFor($me, $class, '2026-09-01');
        $theirs = $this->attendanceFor($classmate, $class, '2026-09-01');

        $ids = $this->idsOfType(
            $this->actingAs($me)->getJson(self::ENDPOINT.'?types=attendance_record')->assertOk()->json(),
            'attendance_record',
        );

        $this->assertSame([(string) $mine->id], $ids);
        $this->assertNotContains((string) $theirs->id, $ids);
    }

    public function test_finance_types_are_unavailable_to_students_and_teachers(): void
    {
        foreach (['student', 'teacher'] as $role) {
            $user = User::factory()->create(['role' => $role]);

            $this->actingAs($user)
                ->getJson(self::ENDPOINT.'?types=invoice')
                ->assertStatus(422)
                ->assertJsonPath('errors.types.0', 'Unknown or unavailable entity type for this role.');
        }

        // And they are absent from the default set, not merely un-requestable.
        $teacher = User::factory()->teacher()->create();
        $types = $this->actingAs($teacher)->getJson(self::ENDPOINT)->assertOk()->json('data.types');

        $this->assertStringNotContainsString('invoice', $types);
        $this->assertStringNotContainsString('installment', $types);
        $this->assertStringContainsString('attendance_record', $types);
    }

    public function test_an_unknown_type_is_rejected_rather_than_silently_ignored(): void
    {
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?types=payroll_records')
            ->assertStatus(422);
    }

    public function test_a_parent_with_no_children_gets_an_empty_page_not_an_error(): void
    {
        $parent = User::factory()->parentRole()->create();

        $response = $this->actingAs($parent)->getJson(self::ENDPOINT)->assertOk();

        $this->assertSame([], $this->changes($response->json()));
        $this->assertFalse($response->json('data.has_more'));
        $this->assertNotEmpty($response->json('data.next_cursor'));
    }

    /* ---------- tombstones ---------- */

    public function test_a_deletion_is_reported_as_a_tombstone(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $record = $this->attendanceFor($child, $class, '2026-09-01');
        $deletedId = (string) $record->id;

        $first = $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?types=attendance_record')
            ->assertOk()
            ->json();

        $this->assertSame([$deletedId], $this->idsOfType($first, 'attendance_record'));

        $record->delete();

        $second = $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?types=attendance_record&since='.urlencode($first['data']['next_cursor']))
            ->assertOk()
            ->json();

        $tombstones = array_values(array_filter(
            $this->changes($second),
            fn (array $change): bool => $change['deleted'] === true,
        ));

        $this->assertCount(1, $tombstones);
        $this->assertSame('attendance_record', $tombstones[0]['type']);
        $this->assertSame($deletedId, $tombstones[0]['id']);
        // A tombstone carries no body and no digest — `deleted` is the signal.
        $this->assertSame([], $tombstones[0]['payload']);
        $this->assertNull($tombstones[0]['etag']);
    }

    public function test_a_tombstone_is_not_shown_to_another_family(): void
    {
        ['parent' => $parentA] = $this->family();
        ['child' => $childB, 'class' => $classB] = $this->family();

        $theirs = $this->attendanceFor($childB, $classB, '2026-09-01');
        $theirs->delete();

        $this->assertDatabaseCount('sync_tombstones', 1);

        $response = $this->actingAs($parentA)
            ->getJson(self::ENDPOINT.'?types=attendance_record')
            ->assertOk()
            ->json();

        $this->assertSame([], $this->changes($response));
    }

    public function test_a_tombstone_records_no_row_contents(): void
    {
        ['child' => $child, 'class' => $class] = $this->family();
        $record = $this->attendanceFor($child, $class, '2026-09-01', 'absent');
        $record->update(['note' => 'Fever, seen by the school nurse']);
        $record->delete();

        $tombstone = SyncTombstone::query()->firstOrFail();
        $stored = (string) json_encode($tombstone->getAttributes());

        $this->assertStringNotContainsString('Fever', $stored);
        $this->assertStringNotContainsString('nurse', $stored);
        $this->assertStringNotContainsString('absent', $stored);
    }

    /* ---------- cursor ---------- */

    public function test_the_cursor_is_stable_across_identical_calls(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->attendanceFor($child, $class, '2026-09-01');
        $this->attendanceFor($child, $class, '2026-09-02');

        $first = $this->actingAs($parent)->getJson(self::ENDPOINT)->assertOk()->json();
        $second = $this->actingAs($parent)->getJson(self::ENDPOINT)->assertOk()->json();

        $this->assertSame($first['data']['next_cursor'], $second['data']['next_cursor']);
        $this->assertSame($first['data']['changes'], $second['data']['changes']);

        // And replaying the same cursor twice is likewise stable.
        $url = self::ENDPOINT.'?since='.urlencode($first['data']['next_cursor']);
        $this->assertSame(
            $this->actingAs($parent)->getJson($url)->assertOk()->json('data.next_cursor'),
            $this->actingAs($parent)->getJson($url)->assertOk()->json('data.next_cursor'),
        );
    }

    public function test_a_cursor_does_not_replay_rows_it_has_already_covered(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $first = $this->attendanceFor($child, $class, '2026-09-01');

        $page1 = $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?types=attendance_record')
            ->assertOk()->json();

        $this->assertSame([(string) $first->id], $this->idsOfType($page1, 'attendance_record'));

        $second = $this->attendanceFor($child, $class, '2026-09-02');

        $page2 = $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?types=attendance_record&since='.urlencode($page1['data']['next_cursor']))
            ->assertOk()->json();

        $this->assertSame([(string) $second->id], $this->idsOfType($page2, 'attendance_record'));
    }

    public function test_paging_respects_the_limit_and_reports_more_to_come(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        for ($day = 1; $day <= 5; $day++) {
            $this->attendanceFor($child, $class, sprintf('2026-09-%02d', $day));
        }

        $seen = [];
        $cursor = null;
        $pages = 0;

        do {
            $url = self::ENDPOINT.'?types=attendance_record&limit=2'
                .($cursor === null ? '' : '&since='.urlencode($cursor));
            $page = $this->actingAs($parent)->getJson($url)->assertOk()->json();

            $this->assertLessThanOrEqual(2, count($this->changes($page)));
            $seen = [...$seen, ...$this->idsOfType($page, 'attendance_record')];
            $cursor = $page['data']['next_cursor'];
            $pages++;
        } while ($page['data']['has_more'] && $pages < 10);

        $this->assertCount(5, $seen);
        $this->assertSame($seen, array_values(array_unique($seen)));
    }

    public function test_a_limit_above_the_ceiling_is_rejected(): void
    {
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?limit=100000')
            ->assertStatus(422);
    }

    public function test_a_cursor_issued_to_another_session_is_refused(): void
    {
        ['parent' => $parentA] = $this->family();
        ['parent' => $parentB] = $this->family();

        $cursor = $this->actingAs($parentA)->getJson(self::ENDPOINT)->assertOk()->json('data.next_cursor');

        $this->actingAs($parentB)
            ->getJson(self::ENDPOINT.'?since='.urlencode($cursor))
            ->assertStatus(422);
    }

    public function test_a_forged_cursor_is_refused(): void
    {
        ['parent' => $parent] = $this->family();

        $cursor = $this->actingAs($parent)->getJson(self::ENDPOINT)->assertOk()->json('data.next_cursor');
        [$body] = explode('.', $cursor, 2);

        $this->actingAs($parent)
            ->getJson(self::ENDPOINT.'?since='.urlencode($body.'.notasignature'))
            ->assertStatus(422);
    }

    /* ---------- payload ---------- */

    public function test_money_is_integer_minor_units_at_the_stored_scale(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        Invoice::factory()->create(['student_user_id' => $child->id, 'amount' => 150.00, 'paid_amount' => 25.50]);

        $change = $this->changes(
            $this->actingAs($parent)->getJson(self::ENDPOINT.'?types=invoice')->assertOk()->json()
        )[0];

        // Qirsh, not fils. The columns are decimal(x,2) and the server's
        // internal minor unit is the qirsh, so the payload declares 2 and the
        // client renders exactly what is stored. Declaring 3 would render a
        // digit the database never held.
        $this->assertSame(
            ['minor' => 15000, 'currency' => 'JOD', 'decimals' => 2],
            $change['payload']['amount'],
        );
        $this->assertSame(2550, $change['payload']['paid_amount']['minor']);
        $this->assertIsInt($change['payload']['amount']['minor']);
    }

    public function test_an_assignment_payload_never_carries_the_private_file_path(): void
    {
        ['parent' => $parent, 'class' => $class] = $this->family();

        Assignment::create([
            'teacher_user_id' => User::factory()->teacher()->create()->id,
            'class_room_id' => $class->id,
            'subject_id' => Subject::factory()->create()->id,
            'title' => 'Chapter 4',
            'instructions' => 'Solve 1-10.',
            'attachment_path' => 'private/assignments/secret-location.pdf',
            'due_at' => now()->addWeek(),
            'max_score' => 100,
        ]);

        $change = $this->changes(
            $this->actingAs($parent)->getJson(self::ENDPOINT.'?types=assignment')->assertOk()->json()
        )[0];

        $this->assertTrue($change['payload']['has_attachment']);
        $this->assertArrayNotHasKey('attachment_path', $change['payload']);
        $this->assertStringNotContainsString(
            'secret-location',
            (string) json_encode($change),
        );
    }

    public function test_a_notification_belongs_only_to_its_own_user(): void
    {
        ['parent' => $parentA] = $this->family();
        ['parent' => $parentB] = $this->family();

        $mine = Notification::factory()->create(['user_id' => $parentA->id]);
        $theirs = Notification::factory()->create(['user_id' => $parentB->id]);

        $ids = $this->idsOfType(
            $this->actingAs($parentA)->getJson(self::ENDPOINT.'?types=notification')->assertOk()->json(),
            'notification',
        );

        $this->assertSame([(string) $mine->id], $ids);
        $this->assertNotContains((string) $theirs->id, $ids);
    }

    public function test_an_announcement_addressed_to_another_class_is_not_delivered(): void
    {
        ['parent' => $parent, 'class' => $class] = $this->family();
        $otherClass = ClassRoom::factory()->create();
        $sender = User::factory()->admin()->create();

        $mine = Announcement::create([
            'sender_user_id' => $sender->id,
            'audience' => 'class:'.$class->id,
            'title' => 'Trip',
            'body' => 'Bring a hat.',
        ]);
        $theirs = Announcement::create([
            'sender_user_id' => $sender->id,
            'audience' => 'class:'.$otherClass->id,
            'title' => 'Other trip',
            'body' => 'Not yours.',
        ]);

        $ids = $this->idsOfType(
            $this->actingAs($parent)->getJson(self::ENDPOINT.'?types=announcement')->assertOk()->json(),
            'announcement',
        );

        $this->assertContains((string) $mine->id, $ids);
        $this->assertNotContains((string) $theirs->id, $ids);
    }

    /* ---------- cost ---------- */

    public function test_the_feed_does_not_issue_a_query_per_row(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();

        // A second child, so the family fan-out is exercised too.
        $sibling = User::factory()->student()->create();
        $sibling->parents()->attach($parent);
        StudentProfile::factory()->create(['user_id' => $sibling->id, 'class_room_id' => $class->id]);

        foreach ([$child, $sibling] as $student) {
            for ($day = 1; $day <= 10; $day++) {
                $this->attendanceFor($student, $class, sprintf('2026-09-%02d', $day));
            }
        }

        $this->actingAs($parent);

        DB::flushQueryLog();
        DB::enableQueryLog();
        $response = $this->getJson(self::ENDPOINT.'?types=attendance_record&limit=100')->assertOk();
        $queries = count(DB::getQueryLog());
        DB::disableQueryLog();

        $this->assertCount(20, $this->changes($response->json()));

        // Authentication, tenant resolution, the two audience lookups, then one
        // query for the rows and one for the tombstones. A per-row query would
        // put this past 20 immediately.
        $this->assertLessThanOrEqual(
            12,
            $queries,
            "The delta feed issued {$queries} queries for 20 rows; it must not scale with row count.",
        );
    }

    public function test_the_query_count_does_not_grow_with_the_number_of_rows(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->attendanceFor($child, $class, '2026-09-01');

        $this->actingAs($parent);

        $count = function () use (&$response): int {
            DB::flushQueryLog();
            DB::enableQueryLog();
            $this->getJson(self::ENDPOINT.'?types=attendance_record&limit=100')->assertOk();
            $queries = count(DB::getQueryLog());
            DB::disableQueryLog();

            return $queries;
        };

        $withOne = $count();

        for ($day = 2; $day <= 15; $day++) {
            $this->attendanceFor($child, $class, sprintf('2026-09-%02d', $day));
        }

        $this->assertSame($withOne, $count(), 'Query count moved when only the row count changed.');
    }
}
