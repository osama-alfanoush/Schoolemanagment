<?php

declare(strict_types=1);

namespace App\Console\Commands;

use App\Models\NotificationTemplate;
use App\Models\School;
use App\Models\User;
use App\Services\CurrentSchool;
use App\Services\NotificationService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;

class QualifyStagingIntegrations extends Command
{
    protected $signature = 'ops:qualify-integrations {--json : Emit machine-readable JSON}';

    protected $description = 'Exercise staging object storage, in-app notifications, and queued mail';

    public function handle(): int
    {
        if (! app()->environment('staging')) {
            $this->error('Integration qualification is restricted to APP_ENV=staging.');

            return self::FAILURE;
        }

        $schoolId = (int) School::query()->orderBy('id')->value('id');
        $userId = (int) User::query()->where('email', 'admin@school.test')->value('id');
        if ($schoolId < 1 || $userId < 1) {
            $this->error('Seeded qualification school and admin are required.');

            return self::FAILURE;
        }

        $storageChecks = [];
        foreach (['s3', 'uploads'] as $disk) {
            $path = 'qualification/'.bin2hex(random_bytes(8)).'.txt';
            $contents = "staging-integration-qualification\n";
            Storage::disk($disk)->put($path, $contents);
            $storageChecks[$disk] = hash_equals($contents, (string) Storage::disk($disk)->get($path));
            Storage::disk($disk)->delete($path);
        }

        $notification = app(CurrentSchool::class)->run($schoolId, function () use ($userId) {
            NotificationTemplate::seedDefaults();

            return NotificationService::sendWithTemplate($userId, 'announcement', [
                'school_name' => 'Staging School A',
                'title' => 'Integration qualification',
                'preview' => 'Mail and notification delivery',
                'announcement_id' => 1,
            ]);
        });

        $deliveries = $notification?->deliveries()->pluck('status', 'channel')->all() ?? [];
        $result = [
            'storage' => $storageChecks,
            'notification_id' => $notification?->id,
            'deliveries' => $deliveries,
            'mail_queue' => config('queue.default'),
            'mail_transport' => config('mail.default'),
        ];

        $this->line(json_encode($result, JSON_PRETTY_PRINT | JSON_THROW_ON_ERROR));

        $passed = ! in_array(false, $storageChecks, true)
            && $notification !== null
            && ($deliveries['in_app'] ?? null) === 'delivered'
            && ($deliveries['email'] ?? null) === 'sent';

        return $passed ? self::SUCCESS : self::FAILURE;
    }
}
