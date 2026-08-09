#!/bin/sh
# Boot sequence for the Railway container (see Dockerfile.railway).
# Runs at container start because APP_KEY / DB_* / PORT only exist at runtime.
#
# One image, three roles. Deploy the same image as three Railway services and
# set PROCESS_ROLE on each:
#
#   PROCESS_ROLE=web        (default) HTTP server; runs migrations first
#   PROCESS_ROLE=worker     queue:work — required or queued jobs never run
#   PROCESS_ROLE=scheduler  schedule:work — required or cron tasks never run
#
# Without a worker and a scheduler service, notifications, outbox delivery,
# contract-renewal checks and installment reminders silently never fire.
set -e

PORT="${PORT:-8080}"
PROCESS_ROLE="${PROCESS_ROLE:-web}"

echo "==> Caching config/routes/views/events"
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan event:cache

# Refuses to start a production instance with unsafe env vars (debug on,
# insecure cookies, wildcard CORS, sqlite, lockless cache store...). Runs after
# config:cache so it validates exactly what the app will read.
echo "==> Validating environment"
php artisan ops:preflight-env

case "$PROCESS_ROLE" in
  worker)
    echo "==> Starting queue worker"
    exec php artisan queue:work \
      --queue="${QUEUE_NAMES:-default}" \
      --tries="${QUEUE_TRIES:-3}" \
      --backoff="${QUEUE_BACKOFF:-10,60,300}" \
      --max-time="${QUEUE_MAX_TIME:-3600}" \
      --timeout="${QUEUE_TIMEOUT:-60}"
    ;;
  scheduler)
    echo "==> Starting scheduler"
    exec php artisan schedule:work
    ;;
esac

# --- web role -------------------------------------------------------------
# --isolated takes a cache lock so concurrent replicas (or a redeploy that
# overlaps the previous release) run the migration set exactly once instead
# of racing. Requires a lock-capable cache store, which preflight enforces.
echo "==> Running database migrations"
php artisan migrate --force --isolated

# Demo data is strictly a non-production convenience. Production accounts must
# be provisioned deliberately; never recreate known-password users on startup.
if [ "$RUN_SEED" = "true" ] && [ "$APP_ENV" != "production" ]; then
  echo "==> Seeding non-production database (RUN_SEED=true)"
  php artisan db:seed --force
elif [ "$RUN_SEED" = "true" ]; then
  echo "ERROR: RUN_SEED is forbidden when APP_ENV=production" >&2
  exit 1
fi

# Expose storage/app/public at public/storage (idempotent; ignore if present).
# NOTE: the container filesystem is ephemeral. Set UPLOADS_DRIVER=s3 so user
# uploads survive a redeploy; preflight warns when this is still local.
php artisan storage:link || true

echo "==> Starting server on 0.0.0.0:${PORT} (release ${APP_RELEASE:-unknown})"
exec php artisan serve --host 0.0.0.0 --port "$PORT"
