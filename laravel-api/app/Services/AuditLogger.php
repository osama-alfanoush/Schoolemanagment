<?php

namespace App\Services;

use App\Models\AuditLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class AuditLogger
{
    public static function log(Request $request, string $action, string $entityType = null, int $entityId = null, array $changes = [], ?int $userId = null): void
    {
        $data = [
            'user_id' => $userId ?? $request->user()?->id,
            'action' => $action,
            'entity_type' => $entityType,
            'entity_id' => $entityId,
            'changes' => $changes,
            'ip' => $request->ip(),
            'user_agent' => substr((string)$request->userAgent(), 0, 500),
        ];

        $channel = config('audit.log_channel', 'daily');
        if ($channel && $channel !== 'database') {
            Log::channel($channel)->info('Audit: ' . $action, $data);
        }

        AuditLog::create($data);
    }

    public static function clean(int $keepDays = 90): int
    {
        $cutoff = now()->subDays($keepDays);
        return AuditLog::where('created_at', '<', $cutoff)->delete();
    }
}
