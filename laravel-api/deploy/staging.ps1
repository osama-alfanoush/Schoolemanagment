[CmdletBinding()]
param(
    [ValidateSet('init', 'validate', 'up', 'smoke', 'backup', 'restore', 'status', 'logs', 'down')]
    [string] $Action = 'status',
    [string] $BackupPath
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$composeFile = Join-Path $root 'docker-compose.staging.yml'
$envFile = Join-Path $root '.env.staging'

function Assert-LastExitCode([string] $Operation) {
    if ($LASTEXITCODE -ne 0) {
        throw "$Operation failed with exit code $LASTEXITCODE."
    }
}

# Windows PowerShell 5.1 converts a native command's stderr into ErrorRecords
# when the stream is redirected (CI logs, transcripts, 2>&1). With
# $ErrorActionPreference='Stop' that turns an informational docker/psql NOTICE
# into a terminating error even though the command exited 0. Native calls are
# therefore made with 'Continue' and judged solely by their exit code.
function Invoke-Native {
    param([scriptblock] $Command, [string] $Operation = 'command')
    $previous = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        & $Command
    } finally {
        $ErrorActionPreference = $previous
    }
    if ($LASTEXITCODE -ne 0) { throw "$Operation failed with exit code $LASTEXITCODE." }
}

function Invoke-Compose {
    Invoke-Native { & docker compose --env-file $envFile -f $composeFile @args } 'docker compose'
}

if ($Action -eq 'init') {
    & (Join-Path $PSScriptRoot 'initialize-staging.ps1')
    exit $LASTEXITCODE
}

if (-not (Test-Path -LiteralPath $envFile)) {
    throw 'Missing .env.staging. Run: ./deploy/staging.ps1 init'
}

switch ($Action) {
    'validate' {
        Invoke-Compose config --quiet
        Write-Host 'Staging Compose configuration is valid.'
    }
    'up' {
        Invoke-Compose build api1 nginx
        Invoke-Compose up -d postgres redis minio
        Invoke-Compose run --rm minio-init
        Invoke-Compose run --rm api1 php artisan migrate --force --no-interaction
        Invoke-Compose up -d --no-build nginx api1 api2 queue1 queue2 scheduler
        Invoke-Compose --profile operations up -d backup
        & $PSCommandPath -Action smoke
    }
    'smoke' {
        $deadline = [DateTime]::UtcNow.AddMinutes(3)
        do {
            try {
                $response = Invoke-RestMethod -Uri 'http://127.0.0.1:8080/api/healthz' -TimeoutSec 5
                if ($response.status -eq 'ok') { break }
            } catch {
                Start-Sleep -Seconds 3
            }
        } while ([DateTime]::UtcNow -lt $deadline)

        if (-not $response -or $response.status -ne 'ok') {
            throw 'Public staging liveness check did not become healthy within three minutes.'
        }

        Invoke-Compose exec -T api1 php artisan ops:smoke --json
        Write-Host 'Staging liveness and dependency smoke checks passed.'
    }
    'backup' {
        Invoke-Compose --profile operations run --rm backup sh /ops/backup-container.sh once
    }
    'restore' {
        $arguments = @{}
        if ($BackupPath) { $arguments.BackupPath = $BackupPath }
        & (Join-Path $PSScriptRoot 'verify-restore.ps1') @arguments
        if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    }
    'status' {
        Invoke-Compose --profile operations ps
    }
    'logs' {
        Invoke-Compose --profile operations logs --tail 200
    }
    'down' {
        Invoke-Compose --profile operations down --remove-orphans
    }
}
