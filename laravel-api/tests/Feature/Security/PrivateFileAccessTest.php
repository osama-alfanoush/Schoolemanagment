<?php

declare(strict_types=1);

namespace Tests\Feature\Security;

use App\Models\Assignment;
use App\Models\ClassRoom;
use App\Models\Organization;
use App\Models\School;
use App\Models\StudentProfile;
use App\Models\Subject;
use App\Models\Submission;
use App\Models\User;
use App\Services\CurrentSchool;
use App\Services\PrivateFileVault;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use PHPUnit\Framework\Attributes\DataProvider;
use Tests\TestCase;

/**
 * Personal files — profile photos, submitted work, teacher attachments — used
 * to live on a world-readable disk. They are now private, and the only way out
 * is an endpoint that checks school scope, record ownership and role.
 *
 * These tests exist to make that non-negotiable: each one fails if the
 * authorization check is removed, weakened, or bypassed by a crafted key.
 */
class PrivateFileAccessTest extends TestCase
{
    use RefreshDatabase;

    private School $schoolA;

    private School $schoolB;

    protected function setUp(): void
    {
        parent::setUp();

        Storage::fake('private_uploads');
        Storage::fake('uploads');

        $this->schoolA = School::query()->firstOrFail();
        $this->schoolB = School::query()->create([
            'organization_id' => Organization::query()->firstOrFail()->id,
            'name' => 'Second School',
            'code' => 'SECOND',
            'timezone' => 'UTC',
            'is_active' => true,
        ]);
    }

    private function vault(): PrivateFileVault
    {
        return app(PrivateFileVault::class);
    }

    /** Give a user a photo stored in the given school's prefix. */
    private function withPhoto(User $user, ?School $school = null): User
    {
        $school ??= $this->schoolA;
        $key = app(CurrentSchool::class)->run(
            $school->id,
            fn () => $this->vault()->store(UploadedFile::fake()->create('x.jpg', 8, 'image/jpeg'), 'profile-photo')
        );
        $user->forceFill(['photo_path' => $key])->save();

        return $user;
    }

    // ---------------------------------------------------------------- uploads

    public function test_a_stored_key_contains_no_personal_information(): void
    {
        $user = $this->loginAs('student');

        $key = app(CurrentSchool::class)->run(
            $this->schoolA->id,
            fn () => $this->vault()->store(
                UploadedFile::fake()->create('ahmed-al-fulani-passport-photo.jpg', 8, 'image/jpeg'),
                'profile-photo'
            )
        );

        // No original filename, no email — only tenant, category and an opaque
        // identifier.
        $this->assertStringNotContainsString('ahmed', strtolower($key));
        $this->assertStringNotContainsString('fulani', strtolower($key));
        $this->assertStringNotContainsString('passport', strtolower($key));

        // The filename is a 26-character ULID and nothing else. Asserting that
        // it merely "does not contain the user id" would be unreliable — a ULID
        // is random base32 and can contain any digit by chance — so the shape
        // itself is what is pinned: a generated identifier, never a value
        // derived from the record or the upload.
        [$tenant, $category, $filename] = explode('/', $key);
        $this->assertSame((string) $this->schoolA->id, $tenant);
        $this->assertSame('profile-photo', $category);
        $this->assertMatchesRegularExpression('/^[0-9A-HJKMNP-TV-Z]{26}\.jpg$/i', $filename);
        $this->assertNotSame((string) $user->id, pathinfo($filename, PATHINFO_FILENAME));
    }

    /**
     * @return array<string, array{0: string, 1: string}>
     */
    public static function hostileUploads(): array
    {
        return [
            'php script named as an image' => ['evil.jpg', 'text/x-php'],
            'html with script' => ['x.png', 'text/html'],
            'svg carrying script' => ['logo.svg', 'image/svg+xml'],
            'windows executable' => ['setup.png', 'application/x-dosexec'],
            'shell script' => ['run.jpg', 'application/x-sh'],
        ];
    }

    /**
     * The extension the client supplies is meaningless — the browser and the
     * operating system will happily label a PHP script "photo.jpg". Acceptance
     * is decided by the detected content type.
     */
    #[DataProvider('hostileUploads')]
    public function test_executable_and_active_content_is_rejected_as_a_profile_photo(
        string $name,
        string $mime
    ): void {
        $user = $this->loginAs('student');

        $this->actingAs($user)
            ->post('/api/auth/profile/photo', [
                'photo' => UploadedFile::fake()->create($name, 4, $mime),
            ], ['Accept' => 'application/json'])
            ->assertStatus(422)
            ->assertJsonValidationErrors('photo');

        $this->assertNull($user->fresh()->photo_path);
        $this->assertEmpty(Storage::disk('private_uploads')->allFiles());
    }

    public function test_an_oversized_photo_is_rejected(): void
    {
        $user = $this->loginAs('student');

        $this->actingAs($user)
            ->post('/api/auth/profile/photo', [
                // The category ceiling is 5 MB.
                'photo' => UploadedFile::fake()->create('big.jpg', 6000, 'image/jpeg'),
            ], ['Accept' => 'application/json'])
            ->assertStatus(422)
            ->assertJsonValidationErrors('photo');
    }

    public function test_an_accepted_photo_is_written_to_the_private_disk_and_never_the_public_one(): void
    {
        $user = $this->loginAs('student');

        $response = $this->actingAs($user)
            ->post('/api/auth/profile/photo', [
                'photo' => UploadedFile::fake()->create('me.jpg', 8, 'image/jpeg'),
            ], ['Accept' => 'application/json'])
            ->assertOk();

        $key = $user->fresh()->photo_path;
        $this->assertNotNull($key);
        Storage::disk('private_uploads')->assertExists($key);
        $this->assertEmpty(Storage::disk('uploads')->allFiles(), 'a personal photo reached the public disk');

        // The advertised URL is an authorized endpoint, not a storage location.
        $this->assertStringContainsString('/api/files/profile-photo/'.$user->id, $response->json('photo_url'));
    }

    // ------------------------------------------------------- profile photos

    public function test_a_user_can_read_their_own_photo(): void
    {
        $user = $this->withPhoto($this->loginAs('student'));

        $this->actingAs($user)->get('/api/files/profile-photo/'.$user->id)
            ->assertOk()
            ->assertHeader('Content-Type', 'application/octet-stream')
            ->assertHeader('X-Content-Type-Options', 'nosniff');
    }

    /**
     * A downloaded file must never be rendered in the application's origin: an
     * attachment disposition plus a null CSP means stored HTML cannot execute.
     */
    public function test_a_download_can_never_render_in_the_application_origin(): void
    {
        $user = $this->withPhoto($this->loginAs('student'));

        $response = $this->actingAs($user)->get('/api/files/profile-photo/'.$user->id)->assertOk();

        $this->assertStringStartsWith('attachment;', (string) $response->headers->get('Content-Disposition'));
        $this->assertStringContainsString("default-src 'none'", (string) $response->headers->get('Content-Security-Policy'));
        $this->assertStringContainsString('no-store', (string) $response->headers->get('Cache-Control'));
    }

    public function test_a_student_cannot_read_another_students_photo(): void
    {
        $viewer = $this->loginAs('student');
        $other = $this->withPhoto(User::factory()->student()->create());

        $this->actingAs($viewer)->get('/api/files/profile-photo/'.$other->id)
            ->assertForbidden();
    }

    public function test_a_parent_can_read_a_linked_child_but_not_an_unlinked_one(): void
    {
        $parent = $this->loginAs('parentRole');
        $child = $this->withPhoto(User::factory()->student()->create());
        $stranger = $this->withPhoto(User::factory()->student()->create());
        $child->parents()->attach($parent);

        $this->actingAs($parent)->get('/api/files/profile-photo/'.$child->id)->assertOk();
        $this->actingAs($parent)->get('/api/files/profile-photo/'.$stranger->id)->assertForbidden();
    }

    public function test_a_teacher_cannot_read_the_photo_of_a_student_they_do_not_teach(): void
    {
        $teacher = $this->loginAs('teacher');
        $student = $this->withPhoto(User::factory()->student()->create());

        $this->actingAs($teacher)->get('/api/files/profile-photo/'.$student->id)
            ->assertForbidden();
    }

    // ------------------------------------------------------- cross-school

    /**
     * The decisive test. A user in school B must not be able to read a file
     * belonging to school A, even with a valid id, and the response must not
     * distinguish "exists elsewhere" from "does not exist".
     */
    public function test_a_user_cannot_read_a_photo_belonging_to_another_school(): void
    {
        $victim = $this->withPhoto(User::factory()->student()->create(), $this->schoolA);

        $outsider = User::factory()->admin()->create();
        $outsider->schoolRoles()->delete();
        $outsider->schoolRoles()->create(['school_id' => $this->schoolB->id, 'role' => 'admin']);

        $this->actingAs($outsider)->get('/api/files/profile-photo/'.$victim->id)
            ->assertNotFound();
    }

    /**
     * Defence in depth: even if a row somehow carries another school's key —
     * a pre-tenancy record, a bad import, a compromised write — the vault
     * refuses to read outside the caller's prefix.
     */
    public function test_the_vault_refuses_a_key_from_another_school(): void
    {
        $foreignKey = app(CurrentSchool::class)->run(
            $this->schoolB->id,
            fn () => $this->vault()->store(UploadedFile::fake()->create('x.jpg', 8, 'image/jpeg'), 'profile-photo')
        );

        $user = $this->loginAs('admin');
        $user->forceFill(['photo_path' => $foreignKey])->save();

        $this->actingAs($user)->get('/api/files/profile-photo/'.$user->id)
            ->assertForbidden();
    }

    /**
     * @return array<string, array{0: string}>
     */
    public static function traversalKeys(): array
    {
        return [
            'parent traversal' => ['1/profile-photo/../../../.env'],
            'absolute path' => ['/etc/passwd'],
            'backslash traversal' => ['1\\profile-photo\\..\\..\\.env'],
            'other school prefix' => ['9999/profile-photo/01ABCDEF.jpg'],
            'unknown category' => ['1/secrets/01ABCDEF.jpg'],
            'empty key' => [''],
        ];
    }

    /**
     * Storage keys are generated, never accepted from a client, but a row can
     * still be poisoned. The vault treats any key that does not match the
     * generated shape as hostile.
     */
    #[DataProvider('traversalKeys')]
    public function test_a_malformed_or_traversing_key_is_refused(string $key): void
    {
        $user = $this->loginAs('admin');
        $user->forceFill(['photo_path' => $key])->save();

        $status = $this->actingAs($user)->get('/api/files/profile-photo/'.$user->id)->getStatusCode();

        $this->assertContains($status, [400, 403, 404], "key [$key] produced $status");
    }

    // ------------------------------------------------- submissions and work

    private function seedClassWork(): array
    {
        $context = app(CurrentSchool::class);

        return $context->run($this->schoolA->id, function () {
            $teacher = User::factory()->teacher()->create();
            $classRoom = ClassRoom::query()->create([
                'name' => 'Year 5', 'grade' => '5', 'section' => 'A',
                'homeroom_teacher_id' => $teacher->id, 'capacity' => 30,
            ]);
            $student = User::factory()->student()->create();
            StudentProfile::query()->create([
                'user_id' => $student->id, 'class_room_id' => $classRoom->id,
                'admission_no' => 'ADM-'.$student->id,
            ]);

            $subject = Subject::query()->create(['name' => 'Literature', 'code' => 'LIT']);
            DB::table('class_subject_teacher')->insert([
                'school_id' => $this->schoolA->id,
                'class_room_id' => $classRoom->id,
                'subject_id' => $subject->id,
                'teacher_user_id' => $teacher->id,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            $assignment = Assignment::query()->create([
                'teacher_user_id' => $teacher->id,
                'class_room_id' => $classRoom->id,
                'subject_id' => $subject->id,
                'title' => 'Essay',
                'instructions' => 'Write',
                'due_at' => now()->addWeek(),
                'max_score' => 100,
                'attachment_path' => $this->vault()->store(
                    UploadedFile::fake()->create('brief.pdf', 10, 'application/pdf'),
                    'assignment-attachment'
                ),
            ]);

            $submission = Submission::query()->create([
                'assignment_id' => $assignment->id,
                'student_user_id' => $student->id,
                'submitted_at' => now(),
                'status' => 'submitted',
                'file_path' => $this->vault()->store(
                    UploadedFile::fake()->create('answer.pdf', 10, 'application/pdf'),
                    'submission'
                ),
            ]);

            return compact('teacher', 'classRoom', 'student', 'assignment', 'submission', 'subject');
        });
    }

    public function test_a_student_can_read_their_own_submission(): void
    {
        ['student' => $student, 'submission' => $submission] = $this->seedClassWork();

        $this->actingAs($student)->get('/api/files/submission/'.$submission->id)->assertOk();
    }

    /**
     * A classmate is in the same class and the same school and still has no
     * business reading another pupil's work.
     */
    public function test_a_classmate_cannot_read_another_students_submission(): void
    {
        ['classRoom' => $classRoom, 'submission' => $submission] = $this->seedClassWork();

        $classmate = app(CurrentSchool::class)->run($this->schoolA->id, function () use ($classRoom) {
            $peer = User::factory()->student()->create();
            StudentProfile::query()->create([
                'user_id' => $peer->id, 'class_room_id' => $classRoom->id,
                'admission_no' => 'ADM-peer-'.$peer->id,
            ]);

            return $peer;
        });

        $this->actingAs($classmate)->get('/api/files/submission/'.$submission->id)
            ->assertForbidden();
    }

    public function test_the_assigning_teacher_can_read_a_submission(): void
    {
        ['teacher' => $teacher, 'submission' => $submission] = $this->seedClassWork();

        $this->actingAs($teacher)->get('/api/files/submission/'.$submission->id)->assertOk();
    }

    public function test_an_unrelated_teacher_cannot_read_a_submission(): void
    {
        ['submission' => $submission] = $this->seedClassWork();
        $otherTeacher = User::factory()->teacher()->create();

        $this->actingAs($otherTeacher)->get('/api/files/submission/'.$submission->id)
            ->assertForbidden();
    }

    public function test_a_parent_of_the_submitting_student_can_read_it_and_another_parent_cannot(): void
    {
        ['student' => $student, 'submission' => $submission] = $this->seedClassWork();

        $parent = User::factory()->parentRole()->create();
        $student->parents()->attach($parent);
        $otherParent = User::factory()->parentRole()->create();

        $this->actingAs($parent)->get('/api/files/submission/'.$submission->id)->assertOk();
        $this->actingAs($otherParent)->get('/api/files/submission/'.$submission->id)->assertForbidden();
    }

    public function test_a_student_in_the_class_can_read_the_assignment_attachment(): void
    {
        ['student' => $student, 'assignment' => $assignment] = $this->seedClassWork();

        $this->actingAs($student)->get('/api/files/assignment/'.$assignment->id.'/attachment')->assertOk();
    }

    public function test_a_student_outside_the_class_cannot_read_the_assignment_attachment(): void
    {
        ['assignment' => $assignment] = $this->seedClassWork();
        $outsider = User::factory()->student()->create();

        $this->actingAs($outsider)->get('/api/files/assignment/'.$assignment->id.'/attachment')
            ->assertForbidden();
    }

    public function test_a_user_from_another_school_cannot_read_a_submission(): void
    {
        ['submission' => $submission] = $this->seedClassWork();

        $outsider = User::factory()->admin()->create();
        $outsider->schoolRoles()->delete();
        $outsider->schoolRoles()->create(['school_id' => $this->schoolB->id, 'role' => 'admin']);

        $this->actingAs($outsider)->get('/api/files/submission/'.$submission->id)
            ->assertNotFound();
    }

    public function test_private_file_routes_reject_unauthenticated_callers(): void
    {
        ['submission' => $submission, 'assignment' => $assignment, 'student' => $student] = $this->seedClassWork();

        foreach ([
            '/api/files/profile-photo/'.$student->id,
            '/api/files/assignment/'.$assignment->id.'/attachment',
            '/api/files/submission/'.$submission->id,
        ] as $uri) {
            $this->get($uri, ['Accept' => 'application/json'])->assertStatus(401);
        }
    }

    /**
     * The parent link is itself school-scoped, so a link row belonging to
     * another school must not grant access.
     */
    public function test_a_parent_link_from_another_school_grants_nothing(): void
    {
        $child = $this->withPhoto(User::factory()->student()->create(), $this->schoolA);
        $parent = $this->loginAs('parentRole');

        // A link row written under school B, while the caller operates in A.
        DB::table('parent_student')->insert([
            'school_id' => $this->schoolB->id,
            'parent_user_id' => $parent->id,
            'student_user_id' => $child->id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        $this->actingAs($parent)->get('/api/files/profile-photo/'.$child->id)
            ->assertForbidden();
    }
}
