#!/bin/bash
# Thin wrapper around docker compose that ALWAYS sources production secrets from
# .env.prod for BOTH container env (env_file:) and Compose ${VAR} interpolation
# (--env-file). Without --env-file, ${DB_PASSWORD}/${REDIS_PASSWORD}/${MINIO_*}
# resolve from the shell or a stray root .env instead of .env.prod.
#
# Usage: deploy/prod-up.sh up -d        deploy/prod-up.sh logs -f api1
set -euo pipefail
cd "$(dirname "$0")/.."

ENV_FILE=".env.prod"
[ -f "$ENV_FILE" ] || { echo "❌ $ENV_FILE not found (copy .env.prod.example → .env.prod)"; exit 1; }

exec docker compose --env-file "$ENV_FILE" -f docker-compose.prod.yml "$@"
