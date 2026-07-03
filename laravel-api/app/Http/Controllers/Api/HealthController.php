<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Storage;

class HealthController extends Controller
{
    public function __invoke()
    {
        $checks = [
            'database' => $this->checkDatabase(),
            'redis' => $this->checkRedis(),
            'storage' => $this->checkStorage(),
            'cache' => $this->checkCache(),
            'queue' => $this->checkQueue(),
            'environment' => $this->checkEnvironment(),
        ];

        $hasErrors = collect($checks)
            ->filter(fn ($c) => $c['status'] === 'error')
            ->isNotEmpty();

        return response()->json([
            'status' => $hasErrors ? 'degraded' : 'ok',
            'service' => 'school-management-api',
            'version' => config('app.version', '1.0.0'),
            'timestamp' => now()->toIso8601String(),
            'checks' => $checks,
        ], $hasErrors ? 503 : 200);
    }

    private function checkDatabase(): array
    {
        try {
            DB::select('SELECT 1');

            return ['status' => 'ok', 'message' => 'Connected'];
        } catch (\Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }

    private function checkRedis(): array
    {
        if (! class_exists('Redis')) {
            return ['status' => 'warning', 'message' => 'Redis extension not installed'];
        }
        try {
            Redis::ping();

            return ['status' => 'ok', 'message' => 'Connected'];
        } catch (\Exception $e) {
            return ['status' => 'warning', 'message' => 'Redis unreachable — cache/session degraded'];
        }
    }

    private function checkStorage(): array
    {
        try {
            $testFile = 'health-'.uniqid().'.tmp';
            Storage::put($testFile, 'ok');
            $contents = Storage::get($testFile);
            Storage::delete($testFile);

            $disk = config('filesystems.default');
            $free = disk_free_space(storage_path());
            $total = disk_total_space(storage_path());
            $freePercent = $total > 0 ? round(($free / $total) * 100) : 0;

            return [
                'status' => $contents === 'ok' ? 'ok' : 'error',
                'message' => 'Read/Write OK',
                'disk' => $disk,
                'free_percent' => $freePercent,
            ];
        } catch (\Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }

    private function checkCache(): array
    {
        try {
            $key = 'health-'.uniqid();
            Cache::put($key, 'ok', 1);
            $value = Cache::get($key);
            Cache::forget($key);

            return [
                'status' => $value === 'ok' ? 'ok' : 'error',
                'message' => 'Driver: '.config('cache.default'),
            ];
        } catch (\Exception $e) {
            return ['status' => 'error', 'message' => $e->getMessage()];
        }
    }

    private function checkQueue(): array
    {
        try {
            $driver = config('queue.default');
            $failed = 0;
            try {
                $failer = app('queue.failer');
                if (method_exists($failer, 'count')) {
                    $failed = $failer->count();
                }
            } catch (\Throwable $e) {
                // Failed-job provider unavailable — report driver only.
            }

            return [
                'status' => $failed > 0 ? 'warning' : 'ok',
                'message' => $failed > 0 ? "{$failed} failed job(s)" : 'Driver: '.$driver,
                'driver' => $driver,
                'failed' => $failed,
            ];
        } catch (\Exception $e) {
            return ['status' => 'warning', 'message' => $e->getMessage()];
        }
    }

    private function checkEnvironment(): array
    {
        $warnings = [];
        if (app()->environment('production')) {
            if (config('app.debug')) {
                $warnings[] = 'APP_DEBUG is enabled';
            }
            if (config('app.env') !== 'production') {
                $warnings[] = 'APP_ENV mismatch';
            }
        }

        return [
            'status' => empty($warnings) ? 'ok' : 'warning',
            'env' => config('app.env'),
            'debug' => config('app.debug'),
            'warnings' => $warnings,
        ];
    }
}
