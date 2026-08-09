$ErrorActionPreference = 'Stop'
$compose = Join-Path $PSScriptRoot '..\docker-compose.postgres-test.yml'
docker compose -f $compose up -d --wait
try {
    $env:DB_CONNECTION = 'pgsql'
    $env:DB_HOST = '127.0.0.1'
    $env:DB_PORT = '55432'
    $env:DB_DATABASE = 'school_test'
    $env:DB_USERNAME = 'school_test'
    $env:DB_PASSWORD = 'school_test'
    php (Join-Path $PSScriptRoot '..\artisan') migrate:fresh --force
    if ($LASTEXITCODE -ne 0) { throw "PostgreSQL migration failed with exit code $LASTEXITCODE" }
    php (Join-Path $PSScriptRoot '..\vendor\bin\phpunit') -c (Join-Path $PSScriptRoot '..\phpunit.postgres.xml')
    $testExitCode = $LASTEXITCODE
} finally {
    docker compose -f $compose down -v
}
exit $testExitCode
