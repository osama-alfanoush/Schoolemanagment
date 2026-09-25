<?php

declare(strict_types=1);

namespace App\Services\Mobile;

use App\Models\ParentInvite;
use App\Models\User;
use App\Services\AuditLogger;
use App\Services\CurrentSchool;
use App\Services\TokenIssuer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use RuntimeException;

/**
 * Issues and redeems the codes that let a guardian activate without a password.
 *
 * Two properties carry the whole design:
 *
 *  - **A code is bound to one guardian at issue time.** Redeeming it can only
 *    ever sign in that guardian, so a code read out to the wrong person on the
 *    phone opens nobody else's account.
 *  - **Redemption is single-use and atomic.** The row is claimed inside a
 *    locked transaction, so two devices racing the same code produce one
 *    session and one rejection, not two sessions.
 */
final class ParentInviteService
{
    /**
     * Crockford-style base32 without I, L, O or U: nothing in it can be
     * misread down a phone line or mistyped from a printed slip.
     */
    private const ALPHABET = '0123456789ABCDEFGHJKMNPQRSTVWXYZ';

    private const CODE_LENGTH = 12;

    private const GROUP_SIZE = 4;

    /** Attempts against one code before it is burned. */
    public const MAX_ATTEMPTS = 10;

    public function __construct(
        private readonly TokenIssuer $tokenIssuer,
        private readonly CurrentSchool $currentSchool,
    ) {}

    /**
     * Issues a code for [$guardian], returning the plaintext exactly once.
     *
     * Any code previously issued to this guardian and not yet redeemed is
     * expired first: leaving several live at once means a slip found in a bag
     * months later still works.
     *
     * @return array{invite: ParentInvite, code: string}
     */
    public function issue(Request $request, User $guardian, User $issuedBy, int $validForDays = 14): array
    {
        if ($guardian->role !== 'parent') {
            throw new RuntimeException('Activation codes are for guardian accounts.');
        }

        $schoolId = $this->currentSchool->id();

        return DB::transaction(function () use ($request, $guardian, $issuedBy, $schoolId, $validForDays): array {
            ParentInvite::query()
                ->where('guardian_user_id', $guardian->id)
                ->whereNull('redeemed_at')
                ->update(['expires_at' => now()->subSecond()]);

            $code = $this->generateCode();

            $invite = ParentInvite::query()->create([
                'school_id' => $schoolId,
                'guardian_user_id' => $guardian->id,
                'code_hash' => $this->hash($code),
                'expires_at' => now()->addDays($validForDays),
                'issued_by' => $issuedBy->id,
            ]);

            // Identifiers only. The code never reaches a log or an audit row —
            // an audit trail that records the credential is a credential store.
            AuditLogger::log($request, 'parent_invite_issued', 'parent_invite', $invite->id, [
                'guardian_user_id' => $guardian->id,
                'expires_at' => $invite->expires_at->toIso8601String(),
            ], $issuedBy->id);

            return ['invite' => $invite, 'code' => $this->format($code)];
        });
    }

    /**
     * Redeems a code and issues a session for the guardian it was bound to.
     *
     * @return array{user: User, tokens: array<string, mixed>}
     *
     * @throws InvalidInviteCode
     */
    public function redeem(Request $request, string $code, string $deviceId, string $deviceName): array
    {
        $hash = $this->hash($this->normalise($code));

        return DB::transaction(function () use ($request, $hash, $deviceId, $deviceName): array {
            /** @var ParentInvite|null $invite */
            $invite = ParentInvite::query()
                ->where('code_hash', $hash)
                ->lockForUpdate()
                ->first();

            // One rejection for every reason: an unknown code, a spent one and
            // an expired one are indistinguishable to the caller, so the
            // endpoint cannot be used to discover which codes exist.
            if ($invite === null) {
                throw new InvalidInviteCode;
            }

            $invite->increment('attempts');

            if (! $invite->isUsable() || $invite->attempts > self::MAX_ATTEMPTS) {
                AuditLogger::log($request, 'parent_invite_rejected', 'parent_invite', $invite->id, [
                    'reason' => $invite->isRedeemed() ? 'already_redeemed'
                        : ($invite->isExpired() ? 'expired' : 'too_many_attempts'),
                ], $invite->guardian_user_id);

                throw new InvalidInviteCode;
            }

            $guardian = User::query()
                ->withoutGlobalScope('schoolMembership')
                ->whereKey($invite->guardian_user_id)
                ->lockForUpdate()
                ->first();

            if ($guardian === null || ! $guardian->is_active) {
                AuditLogger::log($request, 'parent_invite_rejected', 'parent_invite', $invite->id, [
                    'reason' => 'account_unavailable',
                ], $invite->guardian_user_id);

                throw new InvalidInviteCode;
            }

            // The temporary password an admin generated for this account is
            // replaced with something nobody holds. Activation by code means
            // the guardian never learns a password, so leaving the old one
            // valid would keep a credential alive that only staff have seen.
            $guardian->forceFill([
                'password' => Hash::make(Str::random(64)),
                'must_change_password' => false,
                'last_login_at' => now(),
                'login_attempts' => 0,
                'locked_until' => null,
            ])->save();

            $invite->forceFill([
                'redeemed_at' => now(),
                'redeemed_device_id' => $deviceId,
            ])->save();

            $tokens = $this->tokenIssuer->pair($guardian, $deviceName, null, $deviceId);

            AuditLogger::log($request, 'parent_invite_redeemed', 'parent_invite', $invite->id, [
                'guardian_user_id' => $guardian->id,
            ], $guardian->id);

            return ['user' => $guardian, 'tokens' => $tokens];
        });
    }

    /** Uppercases and strips the separators people type or omit. */
    public function normalise(string $code): string
    {
        return preg_replace('/[^0-9A-Z]/', '', strtoupper(trim($code))) ?? '';
    }

    /**
     * Keyed hash, not a salted one.
     *
     * A salted hash cannot be looked up, and the code is the lookup key. HMAC
     * with the app key keeps a database leak on its own useless: brute-forcing
     * the 60 bits of entropy in a code would also need the application key.
     */
    private function hash(string $normalisedCode): string
    {
        return hash_hmac('sha256', $normalisedCode, (string) config('app.key'));
    }

    private function generateCode(): string
    {
        $alphabet = self::ALPHABET;
        $code = '';

        for ($i = 0; $i < self::CODE_LENGTH; $i++) {
            $code .= $alphabet[random_int(0, strlen($alphabet) - 1)];
        }

        return $code;
    }

    /** `XXXX-XXXX-XXXX`, which is what gets printed and read aloud. */
    private function format(string $code): string
    {
        return implode('-', str_split($code, self::GROUP_SIZE));
    }
}
