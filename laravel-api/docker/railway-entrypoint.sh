#!/bin/sh
# Boot sequence for the Railway container (see Dockerfile.railway).
# Runs at container start because APP_KEY / DB_* / PORT only exist at runtime.
#
# One immutable image, three roles. Deploy the same image as three Railway
# services and set PROCESS_ROLE on each:
#
#   PROCESS_ROLE=web        (default) nginx + php-fpm under supervisord.
#                           Runs migrations once, before serving.
#   PROCESS_ROLE=worker     queue:work — required, or queued jobs never run.
#   PROCESS_ROLE=scheduler  schedule:work — required, or cron tasks never run.
#
# Without a worker and a scheduler service, queued mail, notifications, outbox
# delivery, contract-renewal checks, installment reminders, token pruning and
# audit retention silently never fire.
set -e

PORT="${PORT:-8080}"
PROCESS_ROLE="${PROCESS_ROLE:-web}"

echo "==> Role: ${PROCESS_ROLE} | release: ${APP_RELEASE:-unknown}"

# Config/route/view/event caches are built at boot rather than at image build
# because they bake in environment values that only exist now.
echo "==> Caching config/routes/views/events"
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan event:cache

# Refuses to start a production instance with unsafe env vars (debug on,
# insecure cookies, wildcard CORS, sqlite, a lockless cache store, a local
# uploads disk on ephemeral storage...). Runs after config:cache so it
# validates exactly what the application will read. Every role runs it: a
# worker with a broken configuration is as dangerous as a web replica.
echo "==> Validating environment"
php artisan ops:preflight-env

case "$PROCESS_ROLE" in
  worker)
    # exec so the worker is PID 1 and receives SIGTERM directly from the
    # platform. Laravel's worker traps it and finishes the job in flight before
    # exiting, which is what makes a redeploy non-destructive for queued work.
    # --max-time recycles the process periodically to bound memory growth.
    echo "==> Starting queue worker"
    exec php artisan queue:work \
      --queue="${QUEUE_NAMES:-default}" \
      --tries="${QUEUE_TRIES:-3}" \
      --backoff="${QUEUE_BACKOFF:-10,60,300}" \
      --max-time="${QUEUE_MAX_TIME:-3600}" \
      --max-jobs="${QUEUE_MAX_JOBS:-1000}" \
      --timeout="${QUEUE_TIMEOUT:-60}" \
      --rest="${QUEUE_REST:-0}"
    ;;
  scheduler)
    # schedule:work runs the scheduler loop in the foreground. Tasks that must
    # not overlap already declare withoutOverlapping(), which takes a cache
    # lock, so a brief overlap across a redeploy cannot double-run them.
    echo "==> Starting scheduler"
    exec php artisan schedule:work
    ;;
  web) ;;
  *)
    echo "ERROR: unknown PROCESS_ROLE '${PROCESS_ROLE}' (expected web, worker or scheduler)" >&2
    exit 1
    ;;
esac

# --- web role -------------------------------------------------------------

# Migrations run on the web role only, and exactly once.
#
# --isolated takes a cache lock, so a scaled-out web service or a redeploy that
# overlaps the previous release runs the migration set once instead of racing.
# ops:preflight-env rejects a cache store that cannot hold locks, so the flag
# can never silently degrade into a no-op.
#
# They run over DB_MIGRATION_CONNECTION, which points at PostgreSQL directly
# rather than through PgBouncer. Transaction-mode pooling breaks session-scoped
# statements, and CREATE INDEX CONCURRENTLY must not be multiplexed onto a
# shared server connection.
MIGRATION_CONNECTION="${DB_MIGRATION_CONNECTION:-pgsql_direct}"
echo "==> Running database migrations on connection '${MIGRATION_CONNECTION}'"
php artisan migrate --force --isolated --database="${MIGRATION_CONNECTION}"

# Demo data is strictly a non-production convenience. Production accounts must
# be provisioned deliberately; never recreate known-password users on startup.
if [ "$RUN_SEED" = "true" ] && [ "$APP_ENV" != "production" ]; then
  echo "==> Seeding non-production database (RUN_SEED=true)"
  php artisan db:seed --force
elif [ "$RUN_SEED" = "true" ]; then
  echo "ERROR: RUN_SEED is forbidden when APP_ENV=production" >&2
  exit 1
fi

# Only meaningful when a persistent volume is mounted at storage/. The
# supported production configuration is object storage (UPLOADS_DRIVER=s3);
# ops:preflight-env refuses to boot with a local uploads disk unless the
# operator explicitly acknowledges that a durable volume is attached.
php artisan storage:link || true

# Render the nginx server block. Only ${PORT} is substituted; every other
# $variable in the template is an nginx runtime variable and must survive.
echo "==> Rendering nginx configuration for port ${PORT}"
PORT="$PORT" envsubst '${PORT}' \
  < /etc/nginx/templates/default.conf.template \
  > /etc/nginx/http.d/default.conf
nginx -t -c /etc/nginx/nginx.conf

echo "==> Starting nginx + php-fpm on 0.0.0.0:${PORT}"
exec supervisord -c /etc/supervisor/supervisord.conf
