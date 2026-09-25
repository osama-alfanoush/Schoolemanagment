#!/bin/bash
# Run ONCE on first deployment to a new server
set -euo pipefail
cd "$(dirname "$0")/.."

echo "=== School Suite — First Run Setup ==="

# Validate secrets up front (also guards the ${VAR:?} interpolation in compose).
bash deploy/preflight.sh

# Always source .env.prod for compose interpolation, not the shell/root .env.
COMPOSE="docker compose --env-file .env.prod -f docker-compose.prod.yml"

echo "🔨 Building Docker images..."
$COMPOSE build

echo "🗄️  Starting database and cache..."
$COMPOSE up -d postgres redis

echo "⏳ Waiting for postgres to be ready..."
sleep 15

echo "🗃️  Running migrations..."
$COMPOSE run --rm api1 php artisan migrate --force

echo "🔗 Linking public storage..."
$COMPOSE run --rm api1 php artisan storage:link || true

echo "⚡ Caching config, routes, views..."
$COMPOSE run --rm api1 php artisan config:cache
$COMPOSE run --rm api1 php artisan route:cache
$COMPOSE run --rm api1 php artisan view:cache
$COMPOSE run --rm api1 php artisan event:cache

echo "🚀 Starting all services..."
$COMPOSE up -d

echo "🌐 Deploying frontend..."
bash deploy/copy-frontend.sh

echo "⏳ Waiting for services..."
sleep 10
curl --fail --silent --show-error http://localhost/api/healthz | python3 -m json.tool
$COMPOSE exec -T api1 php artisan ops:smoke --json

echo ""
echo "=== First run complete ==="
echo "   App:     \$APP_URL"
echo "   Admin:   deploy/prod-up.sh exec api1 php artisan school:provision-admin you@example.com --school=1"
echo "   Logs:    deploy/prod-up.sh logs -f"
