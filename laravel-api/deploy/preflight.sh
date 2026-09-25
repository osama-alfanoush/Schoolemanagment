#!/bin/bash
# Fails the deploy if any required production secret is blank or still a placeholder.
set -euo pipefail
cd "$(dirname "$0")/.."

ENV_FILE=".env.prod"
[ -f "$ENV_FILE" ] || { echo "❌ $ENV_FILE not found (copy .env.prod.example → .env.prod)"; exit 1; }

# shellcheck disable=SC1090
set -a; . "$ENV_FILE"; set +a

REQUIRED="APP_KEY APP_URL CORS_ALLOWED_ORIGINS DB_PASSWORD REDIS_PASSWORD"
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
  *) echo "❌ APP_URL must use https:// in production."; fail=1 ;;
esac

if [ "${SESSION_SECURE_COOKIE:-}" != "true" ] || [ "${WEB_AUTH_COOKIE_SECURE:-}" != "true" ]; then
  echo "❌ SESSION_SECURE_COOKIE and WEB_AUTH_COOKIE_SECURE must both be 'true'."
  fail=1
fi

if [ "${APP_ENV:-}" != "production" ] || [ "${APP_DEBUG:-}" != "false" ]; then
  echo "❌ Production requires APP_ENV=production and APP_DEBUG=false."
  fail=1
fi

case ",${CORS_ALLOWED_ORIGINS:-}," in
  *localhost*|*127.0.0.1*|*,\**,)
    echo "❌ CORS_ALLOWED_ORIGINS must contain explicit production HTTPS origins only."
    fail=1
    ;;
esac
if printf '%s' "${CORS_ALLOWED_ORIGINS:-}" | tr ',' '\n' | grep -Ev '^https://[^/]+(:[0-9]+)?$' | grep -q .; then
  echo "❌ CORS_ALLOWED_ORIGINS contains an invalid or non-HTTPS origin."
  fail=1
fi

if [ "$fail" -ne 0 ]; then
  echo "Preflight FAILED — fix the above before deploying."
  exit 1
fi

echo "✅ Preflight passed."
