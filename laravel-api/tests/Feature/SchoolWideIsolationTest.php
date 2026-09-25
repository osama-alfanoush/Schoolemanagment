<?php

declare(strict_types=1);

namespace Tests\Feature;

use App\Models\NotificationDelivery;
use App\Models\NotificationTemplate;
use App\Models\Organization;
use App\Models\School;
use App\Models\User;
use App\Models\WarehouseCategory;
use App\Services\CurrentSchool;
use App\Services\NotificationService;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Mail;
use Tests\TestCase;

class SchoolWideIsolationTest extends TestCase
{
    use RefreshDatabase;

    private School $schoolA;

    private School $schoolB;

    protected function setUp(): void
    {
        parent::setUp();
        $this->schoolA = School::query()->firstOrFail();
        $organization = Organization::query()->firstOrFail();
        $this->schoolB = School::query()->create([
            'organization_id' => $organization->id,
            'name' => 'Second School',
            'code' => 'SECOND',
            'timezone' => 'UTC',
            'is_active' => true,
        ]);
    }

    public function test_global_scope_and_database_unique_keys_are_school_aware(): void
    {
        $context = app(CurrentSchool::class);
        $categoryA = $context->run($this->schoolA->id, fn () => WarehouseCategory::query()->create(['name' => 'Supplies']));
        $categoryB = $context->run($this->schoolB->id, fn () => WarehouseCategory::query()->create(['name' => 'Supplies']));

        $this->assertNotSame($categoryA->id, $categoryB->id);
        $this->assertSame($this->schoolA->id, (int) $categoryA->school_id);
        $this->assertSame($this->schoolB->id, (int) $categoryB->school_id);
        $this->assertTrue($context->run($this->schoolA->id, fn () => WarehouseCategory::query()->whereKey($categoryA->id)->exists()));
        $this->assertFalse($context->run($this->schoolA->id, fn () => WarehouseCategory::query()->whereKey($categoryB->id)->exists()));
    }

    public function test_http_reads_and_client_school_id_are_confined_to_authenticated_school(): void
    {
        $context = app(CurrentSchool::class);
        $categoryB = $context->run($this->schoolB->id, fn () => WarehouseCategory::query()->create(['name' => 'Private B']));
        $adminA = User::factory()->admin()->create();

        $this->actingAs($adminA)
            ->getJson('/api/warehouse/categories')
            ->assertOk()
            ->assertJsonMissing(['name' => 'Private B']);

        $createdId = $this->actingAs($adminA)->postJson('/api/warehouse/categories', [
            'name' => 'School A only',
            'school_id' => $this->schoolB->id,
        ])->assertCreated()->json('data.id');

        $this->assertSame(
            $this->schoolA->id,
            (int) WarehouseCategory::query()->withoutGlobalScope('school')->findOrFail($createdId)->school_id,
        );
        $this->assertNotSame($categoryB->id, $createdId);
    }

    public function test_login_fails_before_token_issue_when_school_context_is_ambiguous(): void
    {
        $user = User::factory()->create(['password' => bcrypt('Password1!')]);
        $user->schoolRoles()->create([
            'school_id' => $this->schoolB->id,
            'role' => $user->role,
        ]);

        $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'Password1!',
        ])->assertForbidden()->assertJsonMissingPath('access_token');

        $this->assertCount(0, $user->tokens()->get());
    }

    public function test_scheduled_notifications_are_delivered_once_and_not_at_schedule_time(): void
    {
        Mail::fake();
        $context = app(CurrentSchool::class);
        $user = User::factory()->create();

        $notification = $context->run($this->schoolA->id, function () use ($user) {
            NotificationTemplate::seedDefaults();

            return NotificationService::schedule(
                $user->id,
                'announcement',
                ['school_name' => 'School A', 'title' => 'Test', 'preview' => 'Test'],
                now()->subSecond(),
            );
        });

        $this->assertSame(0, NotificationDelivery::query()->where('notification_id', $notification->id)->count());

        $this->artisan('notifications:process-scheduled')->assertSuccessful();
        $firstCount = NotificationDelivery::query()->where('notification_id', $notification->id)->count();
        $this->assertGreaterThan(0, $firstCount);

        $this->artisan('notifications:process-scheduled')->assertSuccessful();
        $this->assertSame($firstCount, NotificationDelivery::query()->where('notification_id', $notification->id)->count());
    }
}
