#!/bin/sh
# Boot sequence for the Railway container (see Dockerfile.railway).
# Runs at container start because APP_KEY / DB_* / PORT only exist at runtime.
set -e

PORT="${PORT:-8080}"

echo "==> Running database migrations"
php artisan migrate --force

# One-time bootstrap of a fresh database: set RUN_SEED=true in the Railway
# variables for the first deploy (creates the seed accounts), then remove it.
if [ "$RUN_SEED" = "true" ]; then
  echo "==> Seeding database (RUN_SEED=true)"
  php artisan db:seed --force
fi

# Expose storage/app/public at public/storage (idempotent; ignore if present).
php artisan storage:link || true

echo "==> Caching config/routes/views/events"
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan event:cache

echo "==> Starting server on 0.0.0.0:${PORT}"
exec php artisan serve --host 0.0.0.0 --port "$PORT"
