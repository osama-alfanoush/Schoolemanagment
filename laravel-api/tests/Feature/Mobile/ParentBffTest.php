<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\AttendanceRecord;
use App\Models\ClassRoom;
use App\Models\Grade;
use App\Models\GradeComponent;
use App\Models\Notification;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\User;
use App\Services\Mobile\ParentHomeService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class ParentBffTest extends TestCase
{
    use RefreshDatabase;

    private const BOOTSTRAP = '/api/mobile/v1/session/bootstrap';

    private const HOME = '/api/mobile/v1/parent/home';

    /* ---------- fixtures ---------- */

    /** @return array{parent: User, child: User, class: ClassRoom} */
    private function family(string $childName = 'ليان'): array
    {
        $parent = User::factory()->parentRole()->create();
        $child = User::factory()->student()->create(['name' => $childName]);
        $child->parents()->attach($parent);

        $class = ClassRoom::factory()->create();
        StudentProfile::factory()->create([
            'user_id' => $child->id,
            'class_room_id' => $class->id,
        ]);

        return ['parent' => $parent, 'child' => $child, 'class' => $class];
    }

    private function addChild(User $parent, ClassRoom $class, string $name): User
    {
        $child = User::factory()->student()->create(['name' => $name]);
        $child->parents()->attach($parent);
        StudentProfile::factory()->create([
            'user_id' => $child->id,
            'class_room_id' => $class->id,
        ]);

        return $child;
    }

    /** A grade in a gradebook whose state is [$state]. */
    private function gradeFor(
        User $child,
        ClassRoom $class,
        float $score,
        string $state = 'finalized',
    ): Grade {
        $subject = Subject::factory()->create();
        $yearId = DB::table('academic_years')->value('id')
            ?? DB::table('academic_years')->insertGetId([
                'school_id' => $class->school_id,
                'name' => '2025-2026',
                'start_date' => now()->subMonths(3)->toDateString(),
                'end_date' => now()->addMonths(6)->toDateString(),
                'is_current' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        $termId = DB::table('terms')->value('id')
            ?? DB::table('terms')->insertGetId([
                'school_id' => $class->school_id,
                'academic_year_id' => $yearId,
                'name' => 'Term 1',
                'type' => 'semester',
                'start_date' => now()->subMonths(2)->toDateString(),
                'end_date' => now()->addMonths(2)->toDateString(),
                'sequence' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        $periodId = DB::table('grading_periods')->insertGetId([
            'school_id' => $class->school_id,
            'term_id' => $termId,
            'name' => 'Period '.$child->id,
            'start_date' => now()->subMonth()->toDateString(),
            'end_date' => now()->addMonth()->toDateString(),
            'sequence' => $child->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        $gradebookId = DB::table('gradebooks')->insertGetId([
            'school_id' => $class->school_id,
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'grading_period_id' => $periodId,
            'state' => $state,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $component = GradeComponent::factory()->create([
            'class_room_id' => $class->id,
            'subject_id' => $subject->id,
            'max_score' => 100,
        ]);
        $component->forceFill(['gradebook_id' => $gradebookId])->save();

        return Grade::create([
            'student_user_id' => $child->id,
            'grade_component_id' => $component->id,
            'score' => $score,
            'entered_by' => $child->id,
        ]);
    }

    /** An installment plan for [$child] with one instalment due on [$dueDate]. */
    private function installmentFor(
        User $child,
        string $dueDate,
        string $amount = '150.00',
        string $paid = '0.00',
    ): void {
        $planId = DB::table('payment_plans')->insertGetId([
            'school_id' => $child->studentProfile?->school_id
                ?? DB::table('schools')->value('id'),
            'plan_no' => 'PLAN-'.$child->id,
            'student_user_id' => $child->id,
            'total_amount' => $amount,
            'num_installments' => 1,
            'start_date' => $dueDate,
            'status' => 'active',
            'created_by' => $child->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        DB::table('installments')->insert([
            'school_id' => DB::table('schools')->value('id'),
            'payment_plan_id' => $planId,
            'sequence_no' => 1,
            'due_date' => $dueDate,
            'amount' => $amount,
            'paid_amount' => $paid,
            'status' => 'pending',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }

    /* ---------- bootstrap ---------- */

    public function test_bootstrap_reports_every_role_the_user_holds_not_just_one(): void
    {
        // A teacher whose own child attends the school is ordinary. Reporting
        // only users.role is what makes them unable to see their child's fees.
        $user = User::factory()->teacher()->create();
        $user->schoolRoles()->create([
            'school_id' => DB::table('schools')->value('id'),
            'role' => 'parent',
        ]);

        $roles = $this->actingAs($user)
            ->getJson(self::BOOTSTRAP)
            ->assertOk()
            ->json('data.roles');

        $this->assertEqualsCanonicalizing(['parent', 'teacher'], $roles);
    }

    public function test_bootstrap_carries_the_children_the_home_screen_draws(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();

        $response = $this->actingAs($parent)->getJson(self::BOOTSTRAP)->assertOk();

        $response->assertJsonPath('data.children.0.id', $child->id)
            ->assertJsonPath('data.children.0.class_room_id', $class->id)
            ->assertJsonPath('data.children.0.class_name', $class->name);
    }

    public function test_bootstrap_carries_the_version_gate_and_feature_flags(): void
    {
        config([
            'mobile.min_supported_version' => '1.2.0',
            'mobile.force_upgrade' => true,
            'mobile.features' => ['parent_payments' => false],
        ]);
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->getJson(self::BOOTSTRAP)
            ->assertOk()
            ->assertJsonPath('data.min_supported_version', '1.2.0')
            ->assertJsonPath('data.force_upgrade', true)
            ->assertJsonPath('data.features.parent_payments', false);
    }

    public function test_bootstrap_translates_the_schools_branding_into_what_the_app_can_apply(): void
    {
        // A school that has opened the settings screen. (One that has not is
        // covered separately: it must get the defaults, not a 500.)
        DB::table('school_settings')->insert([
            'school_id' => DB::table('schools')->value('id'),
            'school_name' => 'مدرسة الاختبار',
            'academic_year' => '2025-2026',
            'primary_color' => '#6C63FF',
            'accent_color' => '#14B8A6',
            'sidebar_style' => 'white',
            'border_radius' => 'sharp',
            'font_style' => 'modern',
            'created_at' => now(),
            'updated_at' => now(),
        ]);
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->getJson(self::BOOTSTRAP)
            ->assertOk()
            // The web stores a keyword; the app needs a number.
            ->assertJsonPath('data.theme.borderRadius', 0)
            ->assertJsonPath('data.theme.accentColor', '#14B8A6')
            // One bundled face, and the right one: the web's choices are
            // Latin-first and have no Arabic coverage.
            ->assertJsonPath('data.theme.fontFamily', 'Tajawal');
    }

    public function test_a_school_that_never_opened_the_settings_screen_still_boots(): void
    {
        // No school_settings row at all. The first launch of a brand-new school
        // must get the defaults, not a 500 on a null property read.
        $this->assertSame(0, DB::table('school_settings')->count());
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->getJson(self::BOOTSTRAP)
            ->assertOk()
            ->assertJsonPath('data.theme.borderRadius', 20)
            ->assertJsonPath('data.theme.accentColor', '#FF6584');
    }

    public function test_a_teacher_gets_no_children_from_bootstrap(): void
    {
        $teacher = User::factory()->teacher()->create();

        $this->actingAs($teacher)
            ->getJson(self::BOOTSTRAP)
            ->assertOk()
            ->assertJsonPath('data.children', []);
    }

    public function test_bootstrap_requires_a_role_with_a_mobile_app(): void
    {
        foreach (['admin', 'finance', 'hr'] as $role) {
            $this->actingAs(User::factory()->create(['role' => $role]))
                ->getJson(self::BOOTSTRAP)
                ->assertStatus(403);
        }
    }

    /* ---------- home ---------- */

    public function test_home_carries_the_card_for_each_child(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();

        [$weekStart] = ParentHomeService::schoolWeek();
        foreach (['present', 'present', 'present', 'absent'] as $offset => $status) {
            AttendanceRecord::create([
                'student_user_id' => $child->id,
                'class_room_id' => $class->id,
                'date' => $weekStart->copy()->addDays($offset)->toDateString(),
                'status' => $status,
                'marked_by' => $parent->id,
            ]);
        }
        $this->gradeFor($child, $class, 88);
        $this->installmentFor($child, now()->addDays(10)->toDateString());

        $response = $this->actingAs($parent)->getJson(self::HOME)->assertOk();

        $response->assertJsonPath('data.children.0.id', $child->id)
            ->assertJsonPath('data.children.0.attendance.present_percent', 75)
            ->assertJsonPath('data.children.0.attendance.absent_days', 1)
            ->assertJsonPath('data.children.0.latest_grade.score', '88.00')
            ->assertJsonPath('data.children.0.next_installment.overdue', false);
    }

    public function test_money_on_the_home_screen_is_integer_minor_units_at_the_stored_scale(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        $this->installmentFor($child, now()->addDays(5)->toDateString(), '150.00', '25.50');

        $response = $this->actingAs($parent)->getJson(self::HOME)->assertOk();

        $response->assertJsonPath('data.children.0.next_installment.amount', [
            'minor' => 15000,
            'currency' => 'JOD',
            'decimals' => 2,
        ]);
        // 150.00 - 25.50 = 124.50 JOD = 12 450 qirsh, computed without a float.
        $response->assertJsonPath(
            'data.children.0.next_installment.outstanding.minor',
            12450,
        );
    }

    public function test_an_overdue_installment_says_so_and_counts_the_days(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();
        $this->installmentFor($child, now()->subDays(3)->toDateString());

        $response = $this->actingAs($parent)->getJson(self::HOME)->assertOk();

        $response->assertJsonPath('data.children.0.next_installment.overdue', true);
        $this->assertSame(
            -3,
            $response->json('data.children.0.next_installment.days_remaining'),
        );
    }

    public function test_a_grade_whose_gradebook_is_not_finalized_is_not_shown(): void
    {
        // Showing a teacher's working draft to a parent is the failure that
        // cannot be undone, so an unfinalized gradebook fails closed.
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->gradeFor($child, $class, 41, 'draft');

        $this->actingAs($parent)
            ->getJson(self::HOME)
            ->assertOk()
            ->assertJsonPath('data.children.0.latest_grade', null);
    }

    public function test_a_week_with_no_register_taken_is_not_a_perfect_week(): void
    {
        ['parent' => $parent] = $this->family();

        $this->actingAs($parent)
            ->getJson(self::HOME)
            ->assertOk()
            ->assertJsonPath('data.children.0.attendance.present_percent', null);
    }

    public function test_the_unread_count_is_this_accounts_own(): void
    {
        ['parent' => $parent] = $this->family();
        ['parent' => $other] = $this->family();

        Notification::factory()->count(2)->create([
            'user_id' => $parent->id,
            'read_at' => null,
        ]);
        Notification::factory()->count(5)->create([
            'user_id' => $other->id,
            'read_at' => null,
        ]);

        $this->actingAs($parent)
            ->getJson(self::HOME)
            ->assertOk()
            ->assertJsonPath('data.unread_count', 2);
    }

    public function test_a_parent_with_no_children_gets_a_valid_empty_payload(): void
    {
        $parent = User::factory()->parentRole()->create();

        $response = $this->actingAs($parent)->getJson(self::HOME)->assertOk();

        $this->assertSame([], $response->json('data.children'));
        $this->assertSame(0, $response->json('data.unread_count'));
    }

    /* ---------- authorization ---------- */

    public function test_a_parent_never_sees_another_familys_child_on_the_home_screen(): void
    {
        ['parent' => $mine, 'child' => $myChild] = $this->family('ليان');
        ['child' => $theirChild] = $this->family('سلمى');

        $response = $this->actingAs($mine)->getJson(self::HOME)->assertOk();

        $ids = array_column($response->json('data.children'), 'id');
        $this->assertSame([$myChild->id], $ids);
        $this->assertNotContains($theirChild->id, $ids);
    }

    public function test_requesting_another_parents_child_is_refused_and_logged(): void
    {
        ['parent' => $mine] = $this->family();
        ['child' => $theirChild] = $this->family();

        $this->actingAs($mine)
            ->getJson("/api/mobile/v1/parent/children/{$theirChild->id}/overview")
            ->assertStatus(403);

        // The refusal is on the record, not just on the wire.
        $this->assertDatabaseHas('audit_logs', ['action' => 'authorization_denied']);
    }

    public function test_a_parent_can_open_their_own_child(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();

        $this->actingAs($parent)
            ->getJson("/api/mobile/v1/parent/children/{$child->id}/overview")
            ->assertOk()
            ->assertJsonPath('data.id', $child->id);
    }

    public function test_a_teacher_cannot_reach_the_parent_home_screen(): void
    {
        $this->actingAs(User::factory()->teacher()->create())
            ->getJson(self::HOME)
            ->assertStatus(403);
    }

    /* ---------- conditional GET ---------- */

    public function test_an_unchanged_home_screen_answers_304_with_no_body(): void
    {
        ['parent' => $parent] = $this->family();

        $first = $this->actingAs($parent)->getJson(self::HOME)->assertOk();
        $etag = $first->headers->get('ETag');
        $this->assertNotEmpty($etag);

        $this->actingAs($parent)
            ->withHeader('If-None-Match', $etag)
            ->getJson(self::HOME)
            ->assertStatus(304)
            ->assertNoContent(304);
    }

    public function test_a_changed_home_screen_answers_200_with_a_new_tag(): void
    {
        ['parent' => $parent, 'child' => $child] = $this->family();

        $etag = $this->actingAs($parent)->getJson(self::HOME)->assertOk()
            ->headers->get('ETag');

        $this->installmentFor($child, now()->addDays(7)->toDateString());

        $second = $this->actingAs($parent)
            ->withHeader('If-None-Match', $etag)
            ->getJson(self::HOME)
            ->assertOk();

        $this->assertNotSame($etag, $second->headers->get('ETag'));
    }

    public function test_a_weakened_tag_from_a_proxy_still_validates(): void
    {
        ['parent' => $parent] = $this->family();

        $etag = $this->actingAs($parent)->getJson(self::BOOTSTRAP)->assertOk()
            ->headers->get('ETag');

        $this->actingAs($parent)
            ->withHeader('If-None-Match', 'W/'.$etag)
            ->getJson(self::BOOTSTRAP)
            ->assertStatus(304);
    }

    public function test_one_familys_tag_never_validates_anothers_screen(): void
    {
        ['parent' => $mine] = $this->family('ليان');
        ['parent' => $theirs] = $this->family('سلمى');

        $etag = $this->actingAs($theirs)->getJson(self::HOME)->assertOk()
            ->headers->get('ETag');

        $this->app['auth']->forgetGuards();

        $this->actingAs($mine)
            ->withHeader('If-None-Match', $etag)
            ->getJson(self::HOME)
            ->assertOk();
    }

    public function test_the_response_is_never_cached_by_a_shared_proxy(): void
    {
        ['parent' => $parent] = $this->family();

        $cacheControl = $this->actingAs($parent)->getJson(self::HOME)->assertOk()
            ->headers->get('Cache-Control');

        $this->assertStringContainsString('private', $cacheControl);
        $this->assertStringNotContainsString('public', $cacheControl);
    }

    /* ---------- cost ---------- */

    public function test_the_home_screen_costs_the_same_for_one_child_as_for_five(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();

        $count = function () use ($parent): int {
            $this->actingAs($parent);
            DB::flushQueryLog();
            DB::enableQueryLog();
            $this->getJson(self::HOME)->assertOk();
            $queries = count(DB::getQueryLog());
            DB::disableQueryLog();

            return $queries;
        };

        $withOne = $count();

        foreach (['سلمى', 'يوسف', 'رهف', 'كرم'] as $name) {
            $sibling = $this->addChild($parent, $class, $name);
            $this->gradeFor($sibling, $class, 70);
            $this->installmentFor($sibling, now()->addDays(9)->toDateString());
        }

        $withFive = $count();

        $this->assertSame(
            $withOne,
            $withFive,
            "One child cost {$withOne} queries and five cost {$withFive}; "
            .'the home screen must not scale with the number of children.',
        );
    }

    public function test_the_home_screen_stays_under_a_hard_query_ceiling(): void
    {
        ['parent' => $parent, 'child' => $child, 'class' => $class] = $this->family();
        $this->gradeFor($child, $class, 90);
        $this->installmentFor($child, now()->addDays(4)->toDateString());

        $this->actingAs($parent);
        DB::flushQueryLog();
        DB::enableQueryLog();
        $this->getJson(self::HOME)->assertOk();
        $queries = count(DB::getQueryLog());
        DB::disableQueryLog();

        // Authentication, tenant resolution, the child-id lookup, then one
        // query each for children, attendance, installments, grades, timetable
        // and the unread count.
        $this->assertLessThanOrEqual(
            15,
            $queries,
            "The parent home screen issued {$queries} queries.",
        );
    }
}
