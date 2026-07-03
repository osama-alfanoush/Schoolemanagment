#!/bin/bash
# Fails the deploy if any required production secret is blank or still a placeholder.
set -euo pipefail
cd "$(dirname "$0")/.."

ENV_FILE=".env.prod"
[ -f "$ENV_FILE" ] || { echo "❌ $ENV_FILE not found (copy .env.prod.example → .env.prod)"; exit 1; }

# shellcheck disable=SC1090
set -a; . "$ENV_FILE"; set +a

REQUIRED="APP_KEY DB_PASSWORD REDIS_PASSWORD MINIO_KEY MINIO_SECRET"
PLACEHOLDERS="CHANGE_THIS GENERATE_WITH_ARTISAN YOUR_SERVER_IP"

fail=0
for var in $REQUIRED; do
  val="${!var:-}"
  if [ -z "$val" ] || [ "$val" = "null" ]; then
    echo "❌ $var is blank"
    fail=1
    continue
  fi
  for ph in $PLACEHOLDERS; do
    case "$val" in
      *"$ph"*) echo "❌ $var still contains placeholder '$ph'"; fail=1 ;;
    esac
  done
done

case "${APP_URL:-}" in
  https://*) ;;
  *) echo "⚠️  APP_URL is not https:// — use HTTPS in production." ;;
esac

if [ "${SESSION_SECURE_COOKIE:-}" != "true" ]; then
  echo "⚠️  SESSION_SECURE_COOKIE is not 'true'."
fi

if [ "$fail" -ne 0 ]; then
  echo "Preflight FAILED — fix the above before deploying."
  exit 1
fi

echo "✅ Preflight passed."
