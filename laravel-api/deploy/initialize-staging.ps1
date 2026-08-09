[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$target = Join-Path $root '.env.staging'

if (Test-Path -LiteralPath $target) {
    throw '.env.staging already exists. Delete it explicitly only if you intend to rotate every local staging secret.'
}

function New-Secret([int] $Bytes = 32) {
    $buffer = New-Object byte[] $Bytes
    $generator = [Security.Cryptography.RandomNumberGenerator]::Create()
    try {
        $generator.GetBytes($buffer)
    } finally {
        $generator.Dispose()
    }
    return [Convert]::ToBase64String($buffer).Replace('+', '_').Replace('/', '-').TrimEnd('=')
}

$template = Get-Content -LiteralPath (Join-Path $root '.env.staging.example') -Raw
$appKey = 'base64:' + (New-Secret 32)
$dbPassword = New-Secret 36
$redisPassword = New-Secret 36
$minioKey = 'staging-' + (New-Secret 12)
$minioSecret = New-Secret 36

$content = $template
$content = $content.Replace('APP_KEY=GENERATE_WITH_STAGING_INIT', "APP_KEY=$appKey")
$content = $content.Replace('DB_PASSWORD=GENERATE_WITH_STAGING_INIT', "DB_PASSWORD=$dbPassword")
$content = $content.Replace('REDIS_PASSWORD=GENERATE_WITH_STAGING_INIT', "REDIS_PASSWORD=$redisPassword")
$content = $content.Replace('AWS_ACCESS_KEY_ID=GENERATE_WITH_STAGING_INIT', "AWS_ACCESS_KEY_ID=$minioKey")
$content = $content.Replace('AWS_SECRET_ACCESS_KEY=GENERATE_WITH_STAGING_INIT', "AWS_SECRET_ACCESS_KEY=$minioSecret")

[IO.File]::WriteAllText($target, $content, [Text.UTF8Encoding]::new($false))
Write-Host 'Created laravel-api/.env.staging with generated local-only secrets.'
