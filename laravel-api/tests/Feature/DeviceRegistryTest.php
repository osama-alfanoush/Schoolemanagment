<?php

namespace Tests\Feature;

use App\Models\PersonalAccessToken;
use App\Models\School;
use App\Models\User;
use App\Models\UserDevice;
use App\Services\CurrentSchool;
use App\Services\DeviceRegistry;
use App\Services\TokenIssuer;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Request;
use RuntimeException;
use Tests\TestCase;

class DeviceRegistryTest extends TestCase
{
    use RefreshDatabase;

    public function test_registration_creates_a_tenant_scoped_device_and_audit_entry(): void
    {
        $user = User::factory()->create();
        $school = School::query()->firstOrFail();

        $this->actingAs($user)->postJson('/api/notifications/register-device', [
            'device_id' => 'device-one',
            'token' => 'push-one',
            'platform' => 'ios',
            'app_version' => '2.0.0',
            'os_version' => '18.1',
            'user_id' => User::factory()->create()->id,
            'school_id' => 999999,
        ])->assertOk()->assertJsonPath('device_id', 'device-one');

        $this->assertDatabaseHas('user_devices', [
            'user_id' => $user->id,
            'school_id' => $school->id,
            'device_id' => 'device-one',
            'push_token' => 'push-one',
        ]);
        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $user->id,
            'school_id' => $school->id,
            'action' => 'device_registered',
            'entity_type' => 'user_device',
        ]);
    }

    public function test_reregistering_the_same_device_id_upserts_one_row(): void
    {
        $user = User::factory()->create();

        $payload = [
            'device_id' => 'stable-device-id',
            'token' => 'push-first',
            'platform' => 'android',
            'app_version' => '1.0.0',
        ];
        $this->actingAs($user)->postJson('/api/notifications/register-device', $payload)->assertOk();
        $payload['token'] = 'push-second';
        $payload['app_version'] = '1.1.0';
        $this->actingAs($user)->postJson('/api/notifications/register-device', $payload)->assertOk();

        $this->assertSame(1, UserDevice::withoutGlobalScope('school')
            ->where('user_id', $user->id)
            ->where('device_id', 'stable-device-id')
            ->count());
        $this->assertDatabaseHas('user_devices', [
            'user_id' => $user->id,
            'device_id' => 'stable-device-id',
            'push_token' => 'push-second',
            'app_version' => '1.1.0',
        ]);
    }

    public function test_revoke_marks_the_device_revokes_its_tokens_and_clears_push_together(): void
    {
        [$user, $device] = $this->registeredDevice('device-revoke', 'push-revoke');
        app(TokenIssuer::class)->pair($user, 'Phone', null, 'device-revoke');

        $this->actingAs($user)->postJson('/api/notifications/unregister-device', [
            'device_id' => 'device-revoke',
        ])->assertOk();

        $device->refresh();
        $this->assertNotNull($device->revoked_at);
        $this->assertNull($device->push_token);
        $this->assertSame(0, PersonalAccessToken::query()
            ->where('tokenable_id', $user->id)
            ->where('device_id', 'device-revoke')
            ->whereNull('revoked_at')
            ->count());
        $this->assertDatabaseHas('audit_logs', [
            'user_id' => $user->id,
            'action' => 'device_revoked',
            'entity_id' => $device->id,
        ]);
    }

    public function test_revoke_is_atomic_when_push_clearing_fails_after_token_revocation(): void
    {
        [$user, $device] = $this->registeredDevice('device-atomic', 'push-atomic');
        app(TokenIssuer::class)->pair($user, 'Phone', null, 'device-atomic');
        $request = Request::create('/api/notifications/unregister-device', 'POST');
        $request->setUserResolver(static fn () => $user);

        $failOnce = true;
        UserDevice::updating(function (UserDevice $updating) use (&$failOnce): void {
            if ($failOnce && $updating->isDirty('push_token') && $updating->push_token === null) {
                $failOnce = false;
                throw new RuntimeException('forced push clear failure');
            }
        });

        try {
            $schoolId = School::query()->firstOrFail()->id;
            app(CurrentSchool::class)->run(
                $schoolId,
                fn () => app(DeviceRegistry::class)->revoke($request, $user, 'device-atomic')
            );
            $this->fail('The forced mid-transaction failure was not raised.');
        } catch (RuntimeException $exception) {
            $this->assertSame('forced push clear failure', $exception->getMessage());
        }

        $device->refresh();
        $this->assertNull($device->revoked_at);
        $this->assertSame('push-atomic', $device->push_token);
        $this->assertSame(2, PersonalAccessToken::query()
            ->where('tokenable_id', $user->id)
            ->where('device_id', 'device-atomic')
            ->whereNull('revoked_at')
            ->count());
    }

    public function test_user_cannot_read_or_revoke_another_users_device(): void
    {
        $owner = User::factory()->create();
        $actor = User::factory()->create();
        [, $device] = $this->registeredDevice('owners-device', 'owners-push', $owner);

        $this->actingAs($actor)->getJson('/api/notifications/devices')
            ->assertOk()
            ->assertJsonMissing(['device_id' => 'owners-device']);
        $this->actingAs($actor)->postJson('/api/notifications/unregister-device', [
            'device_id' => 'owners-device',
        ])->assertNotFound();

        $device->refresh();
        $this->assertNull($device->revoked_at);
        $this->assertSame('owners-push', $device->push_token);
    }

    public function test_user_cannot_read_or_write_a_device_from_another_school(): void
    {
        $user = User::factory()->create();
        $defaultSchool = School::query()->firstOrFail();
        $otherSchool = School::create([
            'organization_id' => $defaultSchool->organization_id,
            'name' => 'Other School',
            'code' => 'OTHER',
            'timezone' => 'UTC',
            'is_active' => true,
        ]);
        $device = app(CurrentSchool::class)->run($otherSchool->id, fn () => UserDevice::create([
            'user_id' => $user->id,
            'device_id' => 'other-school-device',
            'platform' => 'ios',
            'push_token' => 'other-school-push',
            'last_seen_at' => now(),
        ]));

        $this->actingAs($user)->getJson('/api/notifications/devices')
            ->assertOk()
            ->assertJsonMissing(['device_id' => 'other-school-device']);
        $this->actingAs($user)->postJson('/api/notifications/register-device', [
            'device_id' => 'other-school-device',
            'token' => 'attacker-update',
            'platform' => 'android',
        ])->assertForbidden();
        $this->actingAs($user)->postJson('/api/notifications/unregister-device', [
            'device_id' => 'other-school-device',
        ])->assertNotFound();

        $device->refresh();
        $this->assertNull($device->revoked_at);
        $this->assertSame('other-school-push', $device->push_token);
        $this->assertSame($otherSchool->id, $device->school_id);
    }

    /** @return array{User, UserDevice} */
    private function registeredDevice(string $deviceId, string $pushToken, ?User $user = null): array
    {
        $user ??= User::factory()->create();
        $school = School::query()->firstOrFail();
        $device = app(CurrentSchool::class)->run($school->id, fn () => UserDevice::create([
            'user_id' => $user->id,
            'device_id' => $deviceId,
            'platform' => 'ios',
            'push_token' => $pushToken,
            'last_seen_at' => now(),
        ]));

        return [$user, $device];
    }
}
