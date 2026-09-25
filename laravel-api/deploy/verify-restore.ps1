[CmdletBinding()]
param(
    [string] $BackupPath,
    # Keep the restored database after the drill so application smoke tests can
    # run against it. The caller becomes responsible for dropping it.
    [switch] $KeepDatabase
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$composeFile = Join-Path $root 'docker-compose.staging.yml'
$envFile = Join-Path $root '.env.staging'
$backupDirectory = Join-Path $root 'backups'
$evidenceDirectory = Join-Path $root 'restore-evidence'

if (-not (Test-Path -LiteralPath $envFile)) {
    throw 'Missing .env.staging. Run: ./deploy/staging.ps1 init'
}

if (-not $BackupPath) {
    $latest = Get-ChildItem -LiteralPath $backupDirectory -Filter '*.dump' -File |
        Sort-Object LastWriteTimeUtc -Descending |
        Select-Object -First 1
    if (-not $latest) { throw 'No staging backup was found. Run: ./deploy/staging.ps1 backup' }
    $BackupPath = $latest.FullName
}

$backup = Get-Item -LiteralPath $BackupPath
$checksumPath = $backup.FullName + '.sha256'
$countsPath = $backup.FullName.Replace('.dump', '.counts.txt')
if (-not (Test-Path -LiteralPath $checksumPath) -or -not (Test-Path -LiteralPath $countsPath)) {
    throw 'The backup checksum or source table-count manifest is missing.'
}

$expectedChecksum = ((Get-Content -LiteralPath $checksumPath -Raw).Trim() -split '\s+')[0].ToLowerInvariant()
$actualChecksum = (Get-FileHash -LiteralPath $backup.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
if ($actualChecksum -ne $expectedChecksum) { throw 'Backup checksum verification failed.' }

$restoreDatabase = 'restore_verify_' + [DateTime]::UtcNow.ToString('yyyyMMddHHmmss')
$containerBackupPath = '/backups/' + $backup.Name
$startedAt = [DateTime]::UtcNow
$restoreSucceeded = $false

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

try {
    Invoke-Compose exec -T -e "RESTORE_DATABASE=$restoreDatabase" postgres sh -ec 'dropdb --if-exists --force -U "$DB_USERNAME" "$RESTORE_DATABASE"; createdb -U "$DB_USERNAME" "$RESTORE_DATABASE"'
    Invoke-Compose exec -T -e "RESTORE_DATABASE=$restoreDatabase" -e "BACKUP_PATH=$containerBackupPath" postgres sh -ec 'pg_restore --exit-on-error --no-owner --no-privileges -U "$DB_USERNAME" -d "$RESTORE_DATABASE" "$BACKUP_PATH"'

    $restoredCounts = $null
    Invoke-Native {
        $script:restoredCounts = & docker compose --env-file $envFile -f $composeFile exec -T -e "RESTORE_DATABASE=$restoreDatabase" postgres sh -ec 'psql --no-psqlrc -U "$DB_USERNAME" -d "$RESTORE_DATABASE" -f /ops/sql/table-counts.sql'
    } 'restored table counts'
    $restoredCounts = $script:restoredCounts

    $expectedCounts = (Get-Content -LiteralPath $countsPath | Where-Object { $_.Trim() }) -join "`n"
    $actualCounts = ($restoredCounts | Where-Object { $_.Trim() }) -join "`n"
    if ($actualCounts.Trim() -ne $expectedCounts.Trim()) {
        throw 'Restored table counts do not match the source backup manifest.'
    }

    # Matching counts only prove rows moved. These assertions prove the rows are
    # still usable: tenant ownership, cross-school joins, double-entry balance,
    # payment ceilings, payroll ownership and audit attributability.
    Invoke-Compose exec -T -e "RESTORE_DATABASE=$restoreDatabase" postgres sh -ec 'psql --no-psqlrc -v ON_ERROR_STOP=1 -U "$DB_USERNAME" -d "$RESTORE_DATABASE" -f /ops/sql/restore-assertions.sql'

    # The application must be able to read the restored schema, and the schema
    # must still satisfy the tenant-index invariant.
    Invoke-Compose run --rm -e "DB_DATABASE=$restoreDatabase" api1 php artisan migrate:status --no-interaction
    Invoke-Compose run --rm -e "DB_DATABASE=$restoreDatabase" api1 php artisan tenancy:verify-indexes
    # Idempotency: migrating an already-restored database must be a no-op.
    Invoke-Compose run --rm -e "DB_DATABASE=$restoreDatabase" api1 php artisan migrate --force --no-interaction
    # Operational smoke tests against the restored environment.
    Invoke-Compose run --rm -e "DB_DATABASE=$restoreDatabase" api1 php artisan ops:smoke --json
    $restoreSucceeded = $true
} finally {
    if ($KeepDatabase -and $restoreSucceeded) {
        Write-Host "Restored database kept for follow-up testing: $restoreDatabase"
    } else {
        $previousPreference = $ErrorActionPreference
        $ErrorActionPreference = 'Continue'
        & docker compose --env-file $envFile -f $composeFile exec -T -e "RESTORE_DATABASE=$restoreDatabase" postgres sh -ec 'dropdb --if-exists --force -U "$DB_USERNAME" "$RESTORE_DATABASE"' 2>&1 | Out-Null
        $ErrorActionPreference = $previousPreference
    }
}

$durationSeconds = [Math]::Round(([DateTime]::UtcNow - $startedAt).TotalSeconds, 2)
$rtoSeconds = 7200
$rtoLine = Get-Content -LiteralPath $envFile | Where-Object { $_ -match '^RESTORE_RTO_SECONDS=' } | Select-Object -First 1
if ($rtoLine) { $rtoSeconds = [int]($rtoLine -replace '^RESTORE_RTO_SECONDS=', '') }

New-Item -ItemType Directory -Path $evidenceDirectory -Force | Out-Null
$evidence = [ordered]@{
    checked_at_utc = [DateTime]::UtcNow.ToString('o')
    backup_file = $backup.Name
    sha256 = $actualChecksum
    temporary_database = $restoreDatabase
    table_counts_match = $restoreSucceeded
    integrity_assertions_passed = $restoreSucceeded
    application_migrations_readable = $restoreSucceeded
    migrate_idempotent = $restoreSucceeded
    tenant_indexes_verified = $restoreSucceeded
    operational_smoke_passed = $restoreSucceeded
    database_retained = [bool]$KeepDatabase
    duration_seconds = $durationSeconds
    rto_target_seconds = $rtoSeconds
    rto_met = $restoreSucceeded -and $durationSeconds -le $rtoSeconds
    result = if ($restoreSucceeded) { 'passed' } else { 'failed' }
}
$evidencePath = Join-Path $evidenceDirectory ('restore-' + [DateTime]::UtcNow.ToString('yyyyMMddTHHmmssZ') + '.json')
$evidence | ConvertTo-Json | Set-Content -LiteralPath $evidencePath -Encoding utf8

if (-not $evidence.rto_met) { throw 'Restore completed but exceeded the configured RTO.' }
Write-Host "Restore verification passed in $durationSeconds seconds. Evidence: $evidencePath"
