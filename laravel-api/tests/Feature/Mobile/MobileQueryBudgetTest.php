<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\Assignment;
use App\Models\ClassRoom;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

/**
 * Query budgets for the mobile screens.
 *
 * The performance target in the plan is a wall-clock one on a real handset
 * over throttled 3G, and that has to be measured on the handset. What *can* be
 * held here is the thing that most often ruins it: a payload whose query count
 * grows with the size of the class or the family.
 *
 * The budgets are deliberately loose. They are not a benchmark — they are a
 * tripwire for the shape of the query plan, and the number that matters is
 * whether it changes when the fixture doubles.
 */
class MobileQueryBudgetTest extends TestCase
{
    use RefreshDatabase;

    /** Runs [$call] and returns how many queries it issued. */
    private function countQueries(callable $call): int
    {
        $count = 0;
        DB::listen(function () use (&$count): void {
            $count++;
        });

        $call();

        // Laravel keeps the listener for the rest of the test; the count is
        // read once and the listener is harmless afterwards.
        return $count;
    }

    /** @return array{teacher: User, class: ClassRoom, subject: Subject} */
    private function classOf(int $students): array
    {
        $teacher = User::factory()->teacher()->create();
        $class = ClassRoom::factory()->create(['homeroom_teacher_id' => $teacher->id]);
        $subject = Subject::factory()->create();

        DB::table('class_subject_teacher')->insert([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $teacher->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        for ($i = 0; $i < $students; $i++) {
            $student = User::factory()->student()->create();
            StudentProfile::factory()->create([
                'user_id' => $student->id,
                'class_room_id' => $class->id,
            ]);
            $guardian = User::factory()->parentRole()->create();
            $student->parents()->attach($guardian);
        }

        return ['teacher' => $teacher, 'class' => $class, 'subject' => $subject];
    }

    public function test_a_roster_of_thirty_stays_within_a_handful_of_queries(): void
    {
        // The one that matters most: the roster is opened before every lesson,
        // and a per-student query here is thirty round trips on a school
        // connection. A real class is about thirty.
        $fixture = $this->classOf(30);

        $cost = $this->countQueries(function () use ($fixture): void {
            $this->actingAs($fixture['teacher'])
                ->getJson('/api/mobile/v1/teacher/roster/'.$fixture['class']->id)
                ->assertOk();
        });

        // The roll, the day's marks, the guardians, and the request's own
        // authentication and tenant resolution. Nothing per student.
        $this->assertLessThan(
            15,
            $cost,
            "a roster of thirty cost $cost queries, which looks like an N+1",
        );
    }

    public function test_the_teacher_day_does_not_query_per_period(): void
    {
        $fixture = $this->classOf(3);

        foreach ([1, 2, 3, 4, 5] as $day) {
            DB::table('timetable_entries')->insert([
                'school_id' => $fixture['class']->school_id,
                'class_room_id' => $fixture['class']->id,
                'subject_id' => $fixture['subject']->id,
                'teacher_user_id' => $fixture['teacher']->id,
                'day_of_week' => now()->dayOfWeekIso,
                'start_time' => sprintf('%02d:00:00', 7 + $day),
                'end_time' => sprintf('%02d:45:00', 7 + $day),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        $cost = $this->countQueries(function () use ($fixture): void {
            $this->actingAs($fixture['teacher'])
                ->getJson('/api/mobile/v1/teacher/today')
                ->assertOk();
        });

        // Five periods, and the whole screen still fits in a handful of
        // queries: the timetable, the committed batches, the class list and
        // its student counts.
        $this->assertLessThan(15, $cost, "the day cost $cost queries");
    }

    public function test_a_parent_with_five_children_does_not_cost_five_screens(): void
    {
        $parent = User::factory()->parentRole()->create();
        $class = ClassRoom::factory()->create();

        for ($i = 0; $i < 5; $i++) {
            $child = User::factory()->student()->create();
            StudentProfile::factory()->create([
                'user_id' => $child->id,
                'class_room_id' => $class->id,
            ]);
            $child->parents()->attach($parent);
        }

        $cost = $this->countQueries(function () use ($parent): void {
            $this->actingAs($parent)
                ->getJson('/api/mobile/v1/parent/home')
                ->assertOk();
        });

        // The home screen batches per-child work rather than looping. Five
        // children on a bad connection is the case this exists for.
        $this->assertLessThan(30, $cost, "the parent home cost $cost queries");
    }

    public function test_a_students_assignments_do_not_query_per_assignment(): void
    {
        $fixture = $this->classOf(1);
        $student = User::query()
            ->where('role', 'student')
            ->orderByDesc('id')
            ->firstOrFail();

        for ($i = 0; $i < 8; $i++) {
            Assignment::query()->create([
                'teacher_user_id' => $fixture['teacher']->id,
                'class_room_id' => $fixture['class']->id,
                'subject_id' => $fixture['subject']->id,
                'title' => "واجب $i",
                'instructions' => 'حل التمارين.',
                'due_at' => now()->addDays($i + 1),
                'published_at' => now(),
            ]);
        }

        $cost = $this->countQueries(function () use ($student): void {
            $this->actingAs($student)
                ->getJson('/api/mobile/v1/student/assignments')
                ->assertOk();
        });

        $this->assertLessThan(12, $cost, "the assignment list cost $cost queries");
    }

    public function test_the_delta_feed_is_one_query_per_requested_type(): void
    {
        // Plus the audience resolution. The feed is the cold-start path, so a
        // per-row query here is the whole first-launch budget.
        $fixture = $this->classOf(4);

        $oneType = $this->countQueries(function () use ($fixture): void {
            $this->actingAs($fixture['teacher'])
                ->getJson('/api/mobile/v1/sync/delta?types=attendance_record')
                ->assertOk();
        });

        $this->assertLessThan(15, $oneType, "one type cost $oneType queries");
    }
}
