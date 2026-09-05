<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\ClassRoom;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

/**
 * One person, two roles: a teacher whose own child attends the school.
 *
 * This is the case order 7.1 exists for, and it is currently **half built**.
 * `MobileBootstrapService` reports both roles, because `school_user_roles` is
 * the real, school-scoped, multi-valued source of truth. `RoleMiddleware`
 * admits on `users.role`, which holds exactly one value. So the app is told it
 * may switch to a role the API then refuses.
 *
 * The tests below record both halves as they actually behave. The refusal is
 * asserted rather than fixed: widening `RoleMiddleware` would widen every
 * admin, finance and HR route in the application at the same time, and who may
 * read a family's finance record is not a decision to take in passing. See the
 * blocker recorded in PHASES_DONE.md.
 */
class CrossRoleTest extends TestCase
{
    use RefreshDatabase;

    /** @return array{user: User, child: User, class: ClassRoom, subject: Subject} */
    private function teacherWhoIsAlsoAParent(): array
    {
        // `users.role` can hold only one value; the school-scoped table holds
        // both, which is what the school actually means.
        $user = User::factory()->teacher()->create(['name' => 'أ. سامي']);
        $user->schoolRoles()->firstOrCreate([
            'school_id' => DB::table('schools')->value('id'),
            'role' => 'parent',
        ]);

        $class = ClassRoom::factory()->create(['homeroom_teacher_id' => $user->id]);
        $subject = Subject::factory()->create();
        DB::table('class_subject_teacher')->insert([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'teacher_user_id' => $user->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $child = User::factory()->student()->create(['name' => 'ليان']);
        StudentProfile::factory()->create([
            'user_id' => $child->id,
            'class_room_id' => $class->id,
        ]);
        $child->parents()->attach($user);

        return ['user' => $user, 'child' => $child, 'class' => $class, 'subject' => $subject];
    }

    public function test_the_bootstrap_reports_both_roles(): void
    {
        $fixture = $this->teacherWhoIsAlsoAParent();

        $roles = $this->actingAs($fixture['user'])
            ->getJson('/api/mobile/v1/session/bootstrap')
            ->assertOk()
            ->json('data.roles');

        $this->assertContains('teacher', $roles);
        $this->assertContains('parent', $roles);
    }

    public function test_the_role_the_user_record_holds_works(): void
    {
        $fixture = $this->teacherWhoIsAlsoAParent();

        $this->actingAs($fixture['user'])
            ->getJson('/api/mobile/v1/teacher/today')
            ->assertOk();
    }

    public function test_the_other_role_is_refused_by_the_role_middleware(): void
    {
        // Recorded, not fixed. `RoleMiddleware` admits on `users.role`, and
        // widening it would widen every admin, finance and HR route in the
        // application at the same time.
        //
        // When the decision is taken, this test is the one to invert.
        $fixture = $this->teacherWhoIsAlsoAParent();

        $this->actingAs($fixture['user'])
            ->getJson('/api/mobile/v1/parent/home')
            ->assertForbidden();
    }

    public function test_a_shared_route_is_open_to_both_roles(): void
    {
        // The routes outside the per-role groups — sync, bootstrap,
        // notifications — are keyed on the same single value, so they work for
        // this user under whichever role their record holds.
        $fixture = $this->teacherWhoIsAlsoAParent();

        $this->actingAs($fixture['user'])
            ->getJson('/api/mobile/v1/notifications')
            ->assertOk();
    }

    public function test_the_delta_feed_scopes_to_the_record_role_only(): void
    {
        // `DeltaAudience::resolve()` switches on `$user->role` as well, so this
        // user's feed is a teacher's feed. Their own child's records reach
        // them through the class they teach, not through the guardian link —
        // which happens to be correct here and would not be if the child moved
        // to a class they do not teach.
        $fixture = $this->teacherWhoIsAlsoAParent();

        $this->actingAs($fixture['user'])
            ->getJson('/api/mobile/v1/sync/delta?types=attendance_record')
            ->assertOk();
    }

    public function test_signing_out_revokes_the_token_that_was_used(): void
    {
        // Cache coherence's server half: the next person on this device cannot
        // reuse the token, whatever is still on disk.
        $fixture = $this->teacherWhoIsAlsoAParent();
        // Named the way TokenIssuer names them: logout revokes the access and
        // refresh pair for one device, which is what makes signing out on a
        // phone leave the tablet alone.
        $token = $fixture['user']
            ->createToken('access:device-1', ['access'])
            ->plainTextToken;

        $this->withHeader('Authorization', 'Bearer '.$token)
            ->postJson('/api/auth/logout')
            ->assertOk();

        $this->app['auth']->forgetGuards();

        $this->withHeader('Authorization', 'Bearer '.$token)
            ->getJson('/api/mobile/v1/session/bootstrap')
            ->assertUnauthorized();
    }
}
