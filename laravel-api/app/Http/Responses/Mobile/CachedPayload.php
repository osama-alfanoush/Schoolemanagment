<?php

declare(strict_types=1);

namespace App\Http\Responses\Mobile;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

/**
 * Conditional GET for the mobile read endpoints.
 *
 * A parent on a phone opens the home screen many times a day and almost
 * nothing has changed between opens. Answering 304 costs one round trip and no
 * body, which on a slow connection is the difference between the screen
 * appearing at once and appearing after a spinner.
 *
 * The tag is a strong validator over the serialised payload, so it changes when
 * and only when the answer changes. It is derived from the payload rather than
 * from `updated_at` columns on purpose: the payload is what the client caches,
 * and a tag computed from anything else eventually disagrees with it.
 */
final class CachedPayload
{
    /**
     * Answers 304 when the client's copy is still current, 200 otherwise.
     *
     * @param  array<string, mixed>  $payload
     */
    public static function respond(Request $request, array $payload): JsonResponse
    {
        $body = ['data' => $payload];
        $etag = self::tag($body);

        $response = self::matches($request, $etag)
            ? new JsonResponse(null, Response::HTTP_NOT_MODIFIED)
            : new JsonResponse($body);

        return $response
            ->setEtag(trim($etag, '"'))
            // Private: this is one family's data and must never be held by a
            // shared proxy. must-revalidate keeps the client asking, which is
            // what makes the ETag do the work instead of a guessed lifetime.
            ->header('Cache-Control', 'private, no-cache, must-revalidate');
    }

    /** @param array<string, mixed> $body */
    public static function tag(array $body): string
    {
        return '"'.hash('sha256', (string) json_encode($body)).'"';
    }

    /**
     * True when any tag the client offered matches.
     *
     * `If-None-Match` may carry a list, and a proxy may weaken a tag by
     * prefixing `W/`. Comparing the raw header string would miss both.
     */
    private static function matches(Request $request, string $etag): bool
    {
        $header = $request->headers->get('If-None-Match');

        if ($header === null || $header === '') {
            return false;
        }

        if (trim($header) === '*') {
            return true;
        }

        foreach (explode(',', $header) as $candidate) {
            if (self::normalise($candidate) === self::normalise($etag)) {
                return true;
            }
        }

        return false;
    }

    private static function normalise(string $tag): string
    {
        $tag = trim($tag);

        if (str_starts_with($tag, 'W/')) {
            $tag = substr($tag, 2);
        }

        return trim($tag, '"');
    }
}
