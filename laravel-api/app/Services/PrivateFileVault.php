<?php

declare(strict_types=1);

namespace App\Services;

use Illuminate\Contracts\Filesystem\Filesystem;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use InvalidArgumentException;
use Symfony\Component\HttpFoundation\StreamedResponse;

/**
 * The single way personal files enter and leave storage.
 *
 * Everything here exists because the alternative failed in a specific way:
 *
 *  - Paths are generated, never derived from client input. A path built from an
 *    uploaded filename is a traversal primitive; a path built from a student's
 *    name or admission number leaks that identity to anyone who sees a URL, a
 *    log line or a bucket listing.
 *  - The extension is taken from the detected MIME type, not from the name the
 *    client supplied, so "photo.php" cannot become a .php object.
 *  - Reads are confined to this disk and rejected if the resolved key escapes
 *    the category prefix.
 */
final class PrivateFileVault
{
    /**
     * Categories of private file, each with the MIME types it accepts and a
     * ceiling in kilobytes. Anything not listed cannot be stored at all.
     *
     * The maps are intentionally allow-lists of exact MIME types. An extension
     * allow-list is not equivalent: the browser and the OS will happily label
     * a PHP script "image.jpg".
     *
     * @var array<string, array{mimes: list<string>, max_kb: int}>
     */
    private const CATEGORIES = [
        'profile-photo' => [
            'mimes' => ['image/jpeg', 'image/png', 'image/webp'],
            'max_kb' => 5120,
        ],
        'assignment-attachment' => [
            'mimes' => [
                'application/pdf',
                'image/jpeg', 'image/png', 'image/webp',
                'text/plain',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                'application/vnd.ms-excel',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
            ],
            'max_kb' => 20480,
        ],
        'submission' => [
            'mimes' => [
                'application/pdf',
                'image/jpeg', 'image/png', 'image/webp',
                'text/plain',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                'application/vnd.ms-excel',
                'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                'application/zip',
            ],
            'max_kb' => 20480,
        ],
    ];

    /**
     * Extension chosen from the DETECTED type. SVG is deliberately absent
     * everywhere: it is an XML document that can carry script, so an SVG
     * accepted as an "image" and later rendered in the app's origin is stored
     * cross-site scripting.
     *
     * @var array<string, string>
     */
    private const EXTENSIONS = [
        'image/jpeg' => 'jpg',
        'image/png' => 'png',
        'image/webp' => 'webp',
        'application/pdf' => 'pdf',
        'text/plain' => 'txt',
        'application/msword' => 'doc',
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'docx',
        'application/vnd.ms-excel' => 'xls',
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' => 'xlsx',
        'application/zip' => 'zip',
    ];

    /**
     * The only types that may be served inline, keyed by the extension this
     * vault assigned at upload time from an already-validated MIME.
     *
     * Profile photos exist to be displayed. Forcing every response to
     * `application/octet-stream; attachment` meant an <img> tag could never
     * render one -- the browser refuses, correctly, because nosniff forbids it
     * from guessing. Every avatar in the application was a broken image.
     *
     * Inlining is confined to three raster formats. SVG is absent from
     * EXTENSIONS entirely, so it cannot reach this map, and neither can HTML,
     * PDF or anything else with an active content model. Combined with nosniff
     * (the browser must honour the declared type) and the unchanged
     * `default-src 'none'; sandbox` policy, an inlined response has no way to
     * execute in this origin.
     */
    private const INLINE_TYPES = [
        'jpg' => 'image/jpeg',
        'png' => 'image/png',
        'webp' => 'image/webp',
    ];

    public function __construct(private readonly CurrentSchool $currentSchool) {}

    /**
     * @return list<string>
     */
    public static function categories(): array
    {
        return array_keys(self::CATEGORIES);
    }

    /**
     * Validation rules for a category, so a controller rejects a bad upload
     * before any bytes are written.
     *
     * @return list<string>
     */
    public static function rulesFor(string $category): array
    {
        $spec = self::CATEGORIES[$category] ?? throw new InvalidArgumentException("Unknown file category [$category].");

        return [
            'file',
            'mimetypes:'.implode(',', $spec['mimes']),
            'max:'.$spec['max_kb'],
        ];
    }

    /**
     * Store an upload and return its storage key.
     *
     * The key is `{schoolId}/{category}/{ulid}.{ext}`:
     *   - school id first so a bucket policy or lifecycle rule can target one
     *     tenant, and so a stray read cannot cross tenants by accident;
     *   - a ULID rather than a database id, because an incrementing id in a URL
     *     invites enumeration and tells the reader how many records exist;
     *   - no original filename, which is where personal data hides
     *     ("ahmed-al-fulani-medical.pdf").
     */
    public function store(UploadedFile $file, string $category): string
    {
        $spec = self::CATEGORIES[$category] ?? throw new InvalidArgumentException("Unknown file category [$category].");

        $mime = (string) $file->getMimeType();
        if (! in_array($mime, $spec['mimes'], true)) {
            throw new InvalidArgumentException("File type [$mime] is not accepted for [$category].");
        }

        if ($file->getSize() > $spec['max_kb'] * 1024) {
            throw new InvalidArgumentException("File exceeds the {$spec['max_kb']} KB limit for [$category].");
        }

        $key = sprintf(
            '%d/%s/%s.%s',
            $this->currentSchool->id(),
            $category,
            (string) Str::ulid(),
            self::EXTENSIONS[$mime] ?? 'bin',
        );

        $this->disk()->putFileAs(dirname($key), $file, basename($key), 'private');

        return $key;
    }

    /**
     * Stream a stored file to an authorized caller.
     *
     * Authorization is the caller's job and must already have happened; this
     * method only guarantees that the key cannot escape the tenant prefix and
     * that the response cannot be rendered as active content in this origin.
     */
    public function stream(string $key, string $downloadName, bool $allowInlineImage = false): StreamedResponse
    {
        $this->assertKeyIsWithinTenant($key);

        abort_unless($this->disk()->exists($key), 404);

        $safeName = $this->safeDownloadName($downloadName);

        // Default posture is unchanged: an attachment of unknown type cannot
        // execute in this origin even if the stored bytes turn out to be HTML.
        $disposition = 'attachment';
        $contentType = 'application/octet-stream';

        // Callers that render the file (avatars) may opt in, and only the three
        // raster types survive the lookup. The extension is the one this vault
        // assigned from a validated MIME at upload, not anything user supplied.
        if ($allowInlineImage) {
            $extension = strtolower(pathinfo($key, PATHINFO_EXTENSION));

            if (isset(self::INLINE_TYPES[$extension])) {
                $disposition = 'inline';
                $contentType = self::INLINE_TYPES[$extension];
                $safeName = $this->safeDownloadName(
                    pathinfo($safeName, PATHINFO_FILENAME).'.'.$extension
                );
            }
        }

        return $this->disk()->download($key, $downloadName, [
            'Content-Disposition' => $disposition.'; filename="'.$safeName.'"',
            'Content-Type' => $contentType,
            // Retained deliberately. The browser must honour the declared type
            // rather than sniffing its way to something executable.
            'X-Content-Type-Options' => 'nosniff',
            'Content-Security-Policy' => "default-src 'none'; sandbox",
            'Cache-Control' => 'private, no-store, max-age=0',
        ]);
    }

    public function delete(?string $key): void
    {
        if ($key === null || $key === '') {
            return;
        }

        // A key that fails the tenant check is never deleted: it belongs to
        // another school, or it is malformed and deleting it could remove
        // something unrelated.
        try {
            $this->assertKeyIsWithinTenant($key);
        } catch (\Throwable) {
            return;
        }

        $this->disk()->delete($key);
    }

    public function exists(string $key): bool
    {
        try {
            $this->assertKeyIsWithinTenant($key);
        } catch (\Throwable) {
            return false;
        }

        return $this->disk()->exists($key);
    }

    /**
     * Reject traversal and cross-tenant reads.
     *
     * Keys are generated by this class, so a key that does not match the
     * expected shape did not come from here — it came from a client, a stale
     * row written before this class existed, or an attempt to walk out of the
     * tenant prefix with "..", an absolute path, a NUL byte or a backslash.
     */
    private function assertKeyIsWithinTenant(string $key): void
    {
        abort_if($key === '' || str_contains($key, "\0"), 400, 'Invalid file reference.');
        abort_if(str_contains($key, '..'), 403, 'Invalid file reference.');
        abort_if(str_contains($key, '\\'), 403, 'Invalid file reference.');
        abort_if(str_starts_with($key, '/'), 403, 'Invalid file reference.');

        $categories = implode('|', array_map('preg_quote', self::categories()));
        abort_unless(
            preg_match('#^\d+/(?:'.$categories.')/[0-9A-Za-z]+\.[a-z0-9]{1,5}$#', $key) === 1,
            403,
            'Invalid file reference.'
        );

        abort_unless(
            str_starts_with($key, $this->currentSchool->id().'/'),
            403,
            'This file belongs to another school.'
        );
    }

    /**
     * The download name is echoed into a header, so strip anything that could
     * break out of the quoted value or inject a second header.
     */
    private function safeDownloadName(string $name): string
    {
        $name = preg_replace('/[^A-Za-z0-9._-]/', '_', $name) ?? 'download';

        return Str::limit(ltrim($name, '.'), 120, '');
    }

    private function disk(): Filesystem
    {
        return Storage::disk((string) config('filesystems.private_uploads_disk'));
    }
}
