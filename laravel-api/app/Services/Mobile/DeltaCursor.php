<?php

declare(strict_types=1);

namespace App\Services\Mobile;

/**
 * The opaque, monotonic position of one client in the delta feed.
 *
 * Internally it is a keyset position per stream — `(updated_at, id)` — because
 * that is the only pagination that cannot skip or repeat a row when the table
 * is written to mid-scan, the way an OFFSET can. Externally it is a signed
 * blob: clients must not read it, construct it, or carry one between users, so
 * it is authenticated with the app key and bound to the user and school it was
 * issued for.
 *
 * Encoding the same positions twice yields the same string. That is what makes
 * two identical calls return an identical cursor.
 */
final class DeltaCursor
{
    private const VERSION = 1;

    /** @param array<string, array{0: string, 1: int}> $positions stream key => [updated_at, id] */
    private function __construct(
        private readonly array $positions,
        private readonly int $userId,
        private readonly int $schoolId,
    ) {}

    public static function start(int $userId, int $schoolId): self
    {
        return new self([], $userId, $schoolId);
    }

    /**
     * @throws InvalidDeltaCursor when the blob is malformed, unsigned, or was
     *                            issued to a different user or school.
     */
    public static function decode(?string $raw, int $userId, int $schoolId): self
    {
        if ($raw === null || trim($raw) === '') {
            return self::start($userId, $schoolId);
        }

        $parts = explode('.', trim($raw), 2);
        if (count($parts) !== 2) {
            throw new InvalidDeltaCursor('Malformed cursor.');
        }

        [$body, $signature] = $parts;
        $expected = self::sign($body);

        if (! hash_equals($expected, $signature)) {
            throw new InvalidDeltaCursor('Cursor signature does not verify.');
        }

        $json = base64_decode(strtr($body, '-_', '+/'), true);
        $decoded = $json === false ? null : json_decode($json, true);

        if (! is_array($decoded) || ($decoded['v'] ?? null) !== self::VERSION) {
            throw new InvalidDeltaCursor('Unsupported cursor version.');
        }

        // A cursor is scoped to the session that was issued it. Replaying one
        // across users could not leak data — every query is re-scoped from the
        // token on each request — but it would silently skip rows, which looks
        // like data loss and is far harder to diagnose than a 422.
        if ((int) ($decoded['u'] ?? 0) !== $userId || (int) ($decoded['s'] ?? 0) !== $schoolId) {
            throw new InvalidDeltaCursor('Cursor was issued for a different session.');
        }

        $positions = [];
        foreach ((array) ($decoded['p'] ?? []) as $key => $position) {
            if (! is_string($key) || ! is_array($position) || count($position) !== 2) {
                throw new InvalidDeltaCursor('Malformed cursor position.');
            }
            $positions[$key] = [(string) $position[0], (int) $position[1]];
        }

        ksort($positions);

        return new self($positions, $userId, $schoolId);
    }

    public function encode(): string
    {
        $positions = $this->positions;
        ksort($positions);

        $body = rtrim(strtr(base64_encode((string) json_encode([
            'v' => self::VERSION,
            'u' => $this->userId,
            's' => $this->schoolId,
            'p' => $positions === [] ? new \stdClass : $positions,
        ], JSON_UNESCAPED_SLASHES)), '+/', '-_'), '=');

        return $body.'.'.self::sign($body);
    }

    /** @return array{0: string, 1: int}|null */
    public function positionFor(string $stream): ?array
    {
        return $this->positions[$stream] ?? null;
    }

    /**
     * Advance one stream. A position that is not strictly ahead of the one
     * already held is ignored, so the cursor can only ever move forward.
     */
    public function advanced(string $stream, string $updatedAt, int $id): self
    {
        $current = $this->positions[$stream] ?? null;

        if ($current !== null && ! self::isAhead($current, [$updatedAt, $id])) {
            return $this;
        }

        return new self(
            [...$this->positions, $stream => [$updatedAt, $id]],
            $this->userId,
            $this->schoolId,
        );
    }

    /**
     * @param  array{0: string, 1: int}  $current
     * @param  array{0: string, 1: int}  $candidate
     */
    private static function isAhead(array $current, array $candidate): bool
    {
        return $candidate[0] > $current[0]
            || ($candidate[0] === $current[0] && $candidate[1] > $current[1]);
    }

    private static function sign(string $body): string
    {
        // Truncated to 16 bytes: enough to make forging one impractical, short
        // enough that the cursor stays a reasonable query-string value.
        $mac = hash_hmac('sha256', $body, (string) config('app.key'), true);

        return rtrim(strtr(base64_encode(substr($mac, 0, 16)), '+/', '-_'), '=');
    }
}
