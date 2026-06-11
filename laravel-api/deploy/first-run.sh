#!/bin/bash
# Run ONCE on first deployment to a new server
set -e

echo "=== School Suite — First Run Setup ==="

if [ ! -f .env.prod ]; then
  echo "❌ .env.prod not found!"
  echo "   Copy .env.prod.example → .env.prod"
  echo "   Fill in all CHANGE_THIS values"
  exit 1
fi

if grep -q "GENERATE_WITH_ARTISAN" .env.prod; then
  echo "❌ APP_KEY not set in .env.prod"
  echo "   Run: php artisan key:generate"
  echo "   Or generate manually and paste it"
  exit 1
fi

echo "🔨 Building Docker images..."
docker compose -f docker-compose.prod.yml build

echo "🗄️  Starting database and cache..."
docker compose -f docker-compose.prod.yml up -d postgres redis

echo "⏳ Waiting for postgres to be ready..."
sleep 15

echo "🗃️  Running migrations..."
docker compose -f docker-compose.prod.yml run --rm api1 php artisan migrate --force

echo "⚡ Caching config, routes, views..."
docker compose -f docker-compose.prod.yml run --rm api1 php artisan config:cache
docker compose -f docker-compose.prod.yml run --rm api1 php artisan route:cache
docker compose -f docker-compose.prod.yml run --rm api1 php artisan view:cache
docker compose -f docker-compose.prod.yml run --rm api1 php artisan event:cache

echo "🚀 Starting all services..."
docker compose -f docker-compose.prod.yml up -d

echo "🌐 Deploying frontend..."
bash deploy/copy-frontend.sh

echo "⏳ Waiting for services..."
sleep 10
curl -s http://localhost/api/health | python3 -m json.tool || echo "⚠️  Health check failed — check logs"

echo ""
echo "=== First run complete ==="
echo "   App:     http://YOUR_SERVER_IP"
echo "   MinIO:   http://YOUR_SERVER_IP:9001"
echo "   Logs:    docker compose logs -f"
