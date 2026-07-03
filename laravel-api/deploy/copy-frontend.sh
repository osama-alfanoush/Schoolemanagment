#!/bin/bash
# Copies the built React SPA into the named Docker volume that NGINX serves.
set -euo pipefail

# Vite builds to dist/public (see school-web/vite.config.ts outDir). Copying the
# parent dist/ would nest the app under public/ and make NGINX serve 404s.
DIST_PATH="../school-web/dist/public"

# Compose prefixes volume names with the project name, which defaults to this
# directory (laravel-api). Override with COMPOSE_PROJECT_NAME if you renamed it.
PROJECT="${COMPOSE_PROJECT_NAME:-laravel-api}"
VOLUME="${PROJECT}_frontend_dist"

if [ ! -d "$DIST_PATH" ]; then
  echo "❌ $DIST_PATH not found. Run: (cd ../school-web && npm run build)"
  exit 1
fi

if ! docker volume inspect "$VOLUME" >/dev/null 2>&1; then
  echo "❌ Docker volume '$VOLUME' not found."
  echo "   Start the stack first (deploy/prod-up.sh up -d) or set COMPOSE_PROJECT_NAME."
  exit 1
fi

echo "📦 Copying $DIST_PATH → volume $VOLUME ..."

docker run --rm \
  -v "$(cd "$DIST_PATH" && pwd)":/src:ro \
  -v "$VOLUME":/dst \
  alpine \
  sh -c "rm -rf /dst/* && cp -r /src/. /dst/"

echo "✅ Frontend deployed to volume $VOLUME"
echo "   Restart nginx: deploy/prod-up.sh restart nginx"
