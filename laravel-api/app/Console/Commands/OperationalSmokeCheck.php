<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Queue;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Throwable;

class OperationalSmokeCheck extends Command
{
    protected $signature = 'ops:smoke {--json : Emit machine-readable JSON}';

    protected $description = 'Verify database, cache/locks, queue, and object-storage dependencies';

    public function handle(): int
    {
        $checks = [];

        $this->runCheck($checks, 'database', function (): array {
            DB::selectOne('select 1 as healthy');

            return ['driver' => DB::connection()->getDriverName()];
        });

        $this->runCheck($checks, 'cache_and_lock', function (): array {
            $key = 'ops-smoke:'.Str::uuid();
            Cache::put($key, 'ok', 30);

            if (Cache::get($key) !== 'ok') {
                throw new \RuntimeException('Cache read-after-write failed.');
            }

            $lock = Cache::lock($key.':lock', 10);
            if (! $lock->get()) {
                throw new \RuntimeException('Distributed lock acquisition failed.');
            }

            $lock->release();
            Cache::forget($key);

            return ['store' => config('cache.default')];
        });

        $this->runCheck($checks, 'queue', function (): array {
            $connection = config('queue.default');
            if (app()->environment(['production', 'staging']) && $connection === 'sync') {
                throw new \RuntimeException('The synchronous queue is not allowed in staging or production.');
            }

            Queue::connection($connection)->size();

            return ['connection' => $connection];
        });

        $this->runStorageCheck($checks, 'private_storage', config('filesystems.default'));
        $this->runStorageCheck($checks, 'public_upload_storage', config('filesystems.uploads_disk'));

        $healthy = collect($checks)->every(fn (array $check): bool => $check['status'] === 'ok');
        $result = [
            'status' => $healthy ? 'ok' : 'failed',
            'environment' => app()->environment(),
            'checked_at' => now()->utc()->toIso8601String(),
            'checks' => $checks,
        ];

        if ($this->option('json')) {
            $this->line(json_encode($result, JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES));
        } else {
            foreach ($checks as $name => $check) {
                $message = sprintf('%s: %s', $name, $check['status']);
                $check['status'] === 'ok' ? $this->info($message) : $this->error($message.' - '.$check['error']);
            }
        }

        return $healthy ? self::SUCCESS : self::FAILURE;
    }

    private function runStorageCheck(array &$checks, string $name, string $disk): void
    {
        $this->runCheck($checks, $name, function () use ($disk): array {
            $path = 'operational-smoke/'.Str::uuid().'.txt';
            $filesystem = Storage::disk($disk);

            try {
                if (! $filesystem->put($path, 'ok') || $filesystem->get($path) !== 'ok') {
                    throw new \RuntimeException('Storage read-after-write failed.');
                }
            } finally {
                $filesystem->delete($path);
            }

            return ['disk' => $disk, 'driver' => config("filesystems.disks.{$disk}.driver")];
        });
    }

    private function runCheck(array &$checks, string $name, callable $operation): void
    {
        $startedAt = microtime(true);

        try {
            $details = $operation();
            $checks[$name] = [
                'status' => 'ok',
                'duration_ms' => round((microtime(true) - $startedAt) * 1000, 2),
                ...$details,
            ];
        } catch (Throwable $exception) {
            report($exception);
            $checks[$name] = [
                'status' => 'failed',
                'duration_ms' => round((microtime(true) - $startedAt) * 1000, 2),
                'error' => class_basename($exception),
            ];
        }
    }
}
