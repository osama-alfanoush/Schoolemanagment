#!/bin/bash
# Run on server to apply updates
set -euo pipefail
cd "$(dirname "$0")/.."

echo "=== School Suite — Update Deploy ==="

bash deploy/preflight.sh

# Always source .env.prod for compose interpolation, not the shell/root .env.
COMPOSE="docker compose --env-file .env.prod -f docker-compose.prod.yml"

echo "🔧 Maintenance mode ON..."
$COMPOSE exec api1 php artisan down --retry=60
$COMPOSE exec api2 php artisan down --retry=60
trap '$COMPOSE exec api1 php artisan up >/dev/null 2>&1 || true; $COMPOSE exec api2 php artisan up >/dev/null 2>&1 || true' EXIT

echo "🔨 Rebuilding images..."
$COMPOSE build api1 api2 queue scheduler

echo "🗃️  Running migrations..."
# --isolated takes a cache lock so a retry or an overlapping deploy runs the
# migration set once. pgsql_direct bypasses PgBouncer: transaction pooling may
# put each statement on a different server connection, and CREATE INDEX
# CONCURRENTLY must own its connection for the whole build.
$COMPOSE run --rm api1 php artisan migrate --force --isolated --database=pgsql_direct

echo "⚡ Rebuilding caches..."
$COMPOSE run --rm api1 php artisan optimize:clear
$COMPOSE run --rm api1 php artisan optimize

echo "♻️  Restarting services..."
$COMPOSE up -d --force-recreate api1 api2 queue scheduler

echo "🧹 Signalling queue workers to reload code..."
$COMPOSE exec api1 php artisan queue:restart 2>/dev/null || true
sleep 5

if [ -d "../school-web/dist/public" ]; then
  echo "🌐 Updating frontend..."
  bash deploy/copy-frontend.sh
fi

# ALWAYS restart the edge, not only when the frontend changed.
#
# nginx resolves the addresses in its `upstream` block once, at startup.
# --force-recreate gives api1/api2 new container IPs, so after every backend
# deploy nginx keeps dialling the old ones and the whole site returns 502 —
# indefinitely, because nothing else triggers a re-resolve. This was previously
# only fixed as a side effect of a frontend build being present, so a
# backend-only deploy took the site down and left it down.
echo "🔁 Restarting the edge so it re-resolves the new app containers..."
$COMPOSE restart nginx

echo "✅ Maintenance mode OFF..."
$COMPOSE exec api1 php artisan up
$COMPOSE exec api2 php artisan up
trap - EXIT

# Prove the deploy actually serves traffic before declaring success. A silent
# 502 is exactly the failure this script used to cause.
echo "🩺 Verifying liveness..."
for attempt in $(seq 1 30); do
  if curl -fsS -m 5 "http://127.0.0.1/api/healthz" >/dev/null 2>&1; then
    echo "   liveness OK after ${attempt} attempt(s)"
    break
  fi
  if [ "$attempt" -eq 30 ]; then
    echo "❌ Service is not answering /api/healthz after the deploy." >&2
    echo "   Roll back to the previous image SHA; see docs/production-runbook.md §3." >&2
    exit 1
  fi
  sleep 2
done

echo ""
echo "=== Update complete ==="
$COMPOSE ps
