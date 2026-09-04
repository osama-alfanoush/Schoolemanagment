<?php

declare(strict_types=1);

namespace Tests\Feature\Mobile;

use App\Models\ParentInvite;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class ParentInviteTest extends TestCase
{
    use RefreshDatabase;

    private const ISSUE = '/api/admin/parent-invites';

    private const ACTIVATE = '/api/mobile/v1/onboarding/activate';

    private function issueFor(User $guardian, ?User $admin = null): string
    {
        $response = $this->actingAs($admin ?? User::factory()->admin()->create())
            ->postJson(self::ISSUE, ['guardian_user_id' => $guardian->id])
            ->assertStatus(201);

        return $response->json('data.code');
    }

    /* ---------- issuing ---------- */

    public function test_an_admin_issues_a_code_that_is_returned_exactly_once(): void
    {
        $guardian = User::factory()->parentRole()->create();

        $code = $this->issueFor($guardian);

        $this->assertMatchesRegularExpression('/^[0-9A-Z]{4}-[0-9A-Z]{4}-[0-9A-Z]{4}$/', $code);

        // Nothing recoverable is stored: only a keyed hash of the code.
        $stored = DB::table('parent_invites')->first();
        $this->assertNotNull($stored);
        $this->assertStringNotContainsString(
            str_replace('-', '', $code),
            (string) json_encode($stored),
        );
    }

    public function test_the_code_never_reaches_the_audit_trail(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        $audit = (string) json_encode(DB::table('audit_logs')->get());

        $this->assertStringNotContainsString(str_replace('-', '', $code), $audit);
        $this->assertStringContainsString('parent_invite_issued', $audit);
    }

    public function test_only_an_admin_can_issue_a_code(): void
    {
        $guardian = User::factory()->parentRole()->create();

        foreach (['parent', 'teacher', 'student', 'finance'] as $role) {
            $this->actingAs(User::factory()->create(['role' => $role]))
                ->postJson(self::ISSUE, ['guardian_user_id' => $guardian->id])
                ->assertStatus(403);
        }

        $this->assertDatabaseCount('parent_invites', 0);
    }

    public function test_a_code_cannot_be_issued_for_a_non_guardian(): void
    {
        $teacher = User::factory()->teacher()->create();

        $this->actingAs(User::factory()->admin()->create())
            ->postJson(self::ISSUE, ['guardian_user_id' => $teacher->id])
            ->assertStatus(422);
    }

    public function test_issuing_a_new_code_kills_the_previous_one(): void
    {
        // A slip found in a school bag months later must not still work.
        $guardian = User::factory()->parentRole()->create();
        $first = $this->issueFor($guardian);
        $this->issueFor($guardian);

        $this->postJson(self::ACTIVATE, [
            'code' => $first,
            'device_id' => 'device-a',
        ])->assertStatus(422);
    }

    /* ---------- activating ---------- */

    public function test_a_guardian_activates_without_ever_typing_a_password(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        $response = $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
            'device_name' => 'android',
        ])->assertOk();

        $this->assertNotEmpty($response->json('access_token'));
        $this->assertNotEmpty($response->json('refresh_token'));
        $this->assertSame($guardian->id, $response->json('user.id'));
        $this->assertFalse($response->json('must_change_password'));

        // And the session works. forgetGuards() drops the acting admin from
        // the earlier issue call; without it the bearer token is ignored and
        // this would assert against the wrong user.
        $this->app['auth']->forgetGuards();

        $this->withHeader('Authorization', 'Bearer '.$response->json('access_token'))
            ->getJson('/api/auth/me')
            ->assertOk()
            ->assertJsonPath('user.id', $guardian->id);
    }

    public function test_activation_binds_the_token_family_to_the_device(): void
    {
        // DeviceRegistry.revoke() kills tokens by this binding. A session
        // issued without it could never be revoked remotely.
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertOk();

        $this->assertSame(
            2,
            DB::table('personal_access_tokens')
                ->where('tokenable_id', $guardian->id)
                ->where('device_id', 'device-a')
                ->count(),
        );
    }

    public function test_activation_without_a_device_id_is_refused(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        $this->postJson(self::ACTIVATE, ['code' => $code])->assertStatus(422);
        $this->assertDatabaseMissing('parent_invites', ['redeemed_at' => null, 'attempts' => 1]);
    }

    public function test_activation_replaces_the_temporary_password_staff_generated(): void
    {
        // The guardian never learns a password, so leaving the admin-generated
        // one valid would keep a credential alive that only staff have seen.
        $guardian = User::factory()->parentRole()->create([
            'password' => Hash::make('TempPass123'),
            'must_change_password' => true,
        ]);
        $code = $this->issueFor($guardian);

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertOk();

        $this->postJson('/api/auth/login', [
            'email' => $guardian->email,
            'password' => 'TempPass123',
        ])->assertStatus(422);

        $this->assertFalse((bool) $guardian->fresh()->must_change_password);
    }

    /* ---------- single use ---------- */

    public function test_a_code_cannot_be_used_twice(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertOk();

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-b',
        ])->assertStatus(422);

        $this->assertSame(
            1,
            (int) DB::table('parent_invites')->whereNotNull('redeemed_at')->count(),
        );
    }

    public function test_an_expired_code_is_refused(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        ParentInvite::query()->update(['expires_at' => now()->subDay()]);

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertStatus(422);
    }

    public function test_repeated_guesses_burn_the_code(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        // The attempt counter is on the row, so guessing against a *known*
        // code cannot be retried indefinitely even from many addresses.
        ParentInvite::query()->update(['attempts' => 10]);

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertStatus(422);

        $this->assertDatabaseHas('parent_invites', ['redeemed_at' => null]);
    }

    public function test_an_unknown_code_is_refused_the_same_way_as_a_spent_one(): void
    {
        // Identical answers, so the endpoint cannot be used to discover which
        // codes exist or which guardians have already activated.
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        $spent = $this->postJson(self::ACTIVATE, ['code' => $code, 'device_id' => 'a']);
        $spent->assertOk();

        $again = $this->postJson(self::ACTIVATE, ['code' => $code, 'device_id' => 'b']);
        $unknown = $this->postJson(self::ACTIVATE, [
            'code' => 'ZZZZ-ZZZZ-ZZZZ',
            'device_id' => 'b',
        ]);

        $again->assertStatus(422);
        $unknown->assertStatus(422);
        $this->assertSame($again->json('message'), $unknown->json('message'));
    }

    /* ---------- binding ---------- */

    public function test_a_code_signs_in_the_guardian_it_was_issued_for_and_no_other(): void
    {
        $mine = User::factory()->parentRole()->create();
        $theirs = User::factory()->parentRole()->create();

        $code = $this->issueFor($mine);

        $response = $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertOk();

        $this->assertSame($mine->id, $response->json('user.id'));
        $this->assertNotSame($theirs->id, $response->json('user.id'));

        // And the other guardian's account is untouched.
        $this->assertDatabaseMissing('personal_access_tokens', [
            'tokenable_id' => $theirs->id,
        ]);
    }

    public function test_a_deactivated_guardian_cannot_activate(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);
        $guardian->update(['is_active' => false]);

        $this->postJson(self::ACTIVATE, [
            'code' => $code,
            'device_id' => 'device-a',
        ])->assertStatus(422);
    }

    public function test_the_code_is_read_with_or_without_its_separators(): void
    {
        $guardian = User::factory()->parentRole()->create();
        $code = $this->issueFor($guardian);

        // A parent typing it off a printed slip will do either.
        $this->postJson(self::ACTIVATE, [
            'code' => strtolower(str_replace('-', ' ', $code)),
            'device_id' => 'device-a',
        ])->assertOk();
    }
}
