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

echo "🔨 Rebuilding images..."
$COMPOSE build api1 api2 queue scheduler

echo "🗃️  Running migrations..."
$COMPOSE run --rm api1 php artisan migrate --force

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
  $COMPOSE restart nginx
fi

echo "✅ Maintenance mode OFF..."
$COMPOSE exec api1 php artisan up

echo ""
echo "=== Update complete ==="
$COMPOSE ps
