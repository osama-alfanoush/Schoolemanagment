<?php

namespace Tests\Feature\Security;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use PragmaRX\Google2FA\Google2FA;
use Tests\TestCase;

class MfaTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        config(['mfa.enabled' => true, 'mfa.required_roles' => ['admin']]);
    }

    public function test_privileged_login_is_limited_until_totp_enrollment_is_confirmed(): void
    {
        $admin = User::factory()->admin()->create(['password' => Hash::make('Password1')]);

        $login = $this->postJson('/api/auth/login', [
            'email' => $admin->email,
            'password' => 'Password1',
            'device_name' => 'test-device',
        ])->assertStatus(202)
            ->assertJsonPath('mfa_required', true)
            ->assertJsonPath('mfa_enrollment_required', true);

        $limited = $login->json('mfa_token');
        $this->withToken($limited)->getJson('/api/admin/users')->assertForbidden();

        $enrollment = $this->withToken($limited)->postJson('/api/auth/mfa/enroll')->assertOk();
        $secret = $enrollment->json('secret');
        $code = app(Google2FA::class)->getCurrentOtp($secret);

        $confirm = $this->withToken($limited)->postJson('/api/auth/mfa/confirm', [
            'code' => $code,
            'device_name' => 'test-device',
        ])->assertOk()->assertJsonCount(10, 'recovery_codes');

        $this->app['auth']->forgetGuards();
        $applicationResponse = $this->withToken($confirm->json('access_token'))->getJson('/api/auth/me');
        $applicationResponse->assertOk();
        $this->app['auth']->forgetGuards();
        $this->withToken($limited)->postJson('/api/auth/mfa/enroll')->assertUnauthorized();
    }

    public function test_recovery_code_is_hashed_single_use_and_totp_cannot_be_replayed(): void
    {
        $totp = app(Google2FA::class);
        $secret = $totp->generateSecretKey(32);
        $recovery = 'ABCDE-12345';
        $admin = User::factory()->admin()->create([
            'password' => Hash::make('Password1'),
            'mfa_secret' => $secret,
            'mfa_confirmed_at' => now(),
            'mfa_recovery_codes' => [Hash::make($recovery)],
        ]);

        $limited = $this->postJson('/api/auth/login', [
            'email' => $admin->email,
            'password' => 'Password1',
        ])->assertStatus(202)->assertJsonPath('mfa_enrollment_required', false)->json('mfa_token');

        $this->withToken($limited)->postJson('/api/auth/mfa/challenge', ['recovery_code' => $recovery])
            ->assertOk();
        $this->assertCount(0, $admin->fresh()->mfa_recovery_codes);

        $secondLimited = $this->postJson('/api/auth/login', [
            'email' => $admin->email,
            'password' => 'Password1',
        ])->assertStatus(202)->json('mfa_token');
        $this->withToken($secondLimited)->postJson('/api/auth/mfa/challenge', ['recovery_code' => $recovery])
            ->assertUnprocessable();

        $code = $totp->getCurrentOtp($secret);
        $this->withToken($secondLimited)->postJson('/api/auth/mfa/challenge', ['code' => $code])->assertOk();
        $thirdLimited = $this->postJson('/api/auth/login', [
            'email' => $admin->email,
            'password' => 'Password1',
        ])->assertStatus(202)->json('mfa_token');
        $this->withToken($thirdLimited)->postJson('/api/auth/mfa/challenge', ['code' => $code])
            ->assertUnprocessable();
    }

    public function test_help_desk_recovery_requires_two_distinct_administrators_and_revokes_sessions(): void
    {
        $totp = app(Google2FA::class);
        $target = User::factory()->finance()->create([
            'mfa_secret' => $totp->generateSecretKey(32), 'mfa_confirmed_at' => now(),
            'mfa_recovery_codes' => [Hash::make('ABCDE-12345')],
        ]);
        $target->createToken('access:test', ['access']);
        $requester = User::factory()->admin()->create();
        $approver = User::factory()->admin()->create();

        $response = $this->actingAs($requester)->postJson("/api/admin/users/{$target->id}/mfa-recovery", ['reason' => 'Verified staff lost their device'])->assertCreated();
        $requestId = $response->json('data.id');
        $this->actingAs($requester)->postJson("/api/admin/mfa-recovery/{$requestId}/approve")->assertUnprocessable();
        $this->actingAs($approver)->postJson("/api/admin/mfa-recovery/{$requestId}/approve")->assertOk();

        $target->refresh();
        $this->assertNull($target->mfa_confirmed_at);
        $this->assertSame(0, $target->tokens()->count());
        $this->assertDatabaseHas('mfa_recovery_requests', ['id' => $requestId, 'status' => 'approved', 'approved_by' => $approver->id]);
    }
}
