#!/bin/bash
# Run on server to apply updates
set -e

echo "=== School Suite — Update Deploy ==="

echo "🔧 Maintenance mode ON..."
docker compose -f docker-compose.prod.yml exec api1 php artisan down --retry=60

echo "🔨 Rebuilding API image..."
docker compose -f docker-compose.prod.yml build api1 api2 horizon scheduler

echo "🗃️  Running migrations..."
docker compose -f docker-compose.prod.yml run --rm api1 php artisan migrate --force

echo "⚡ Rebuilding caches..."
docker compose -f docker-compose.prod.yml run --rm api1 php artisan optimize:clear
docker compose -f docker-compose.prod.yml run --rm api1 php artisan optimize

echo "♻️  Restarting services..."
docker compose -f docker-compose.prod.yml up -d --force-recreate api1 api2 horizon scheduler

docker compose -f docker-compose.prod.yml exec horizon php artisan horizon:terminate 2>/dev/null || true
sleep 5

if [ -d "../school-web/dist" ]; then
  echo "🌐 Updating frontend..."
  bash deploy/copy-frontend.sh
  docker compose -f docker-compose.prod.yml restart nginx
fi

echo "✅ Maintenance mode OFF..."
docker compose -f docker-compose.prod.yml exec api1 php artisan up

echo ""
echo "=== Update complete ==="
docker compose -f docker-compose.prod.yml ps
