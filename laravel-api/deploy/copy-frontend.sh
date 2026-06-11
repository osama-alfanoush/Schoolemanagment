#!/bin/bash
# Copies the built React dist into the named Docker volume used by NGINX
set -e

DIST_PATH="../school-web/dist"
CONTAINER="school_nginx"

if [ ! -d "$DIST_PATH" ]; then
  echo "❌ dist/ not found. Run: npm run build"
  exit 1
fi

echo "📦 Copying frontend dist to nginx volume..."

docker run --rm \
  -v "$(cd "$DIST_PATH" && pwd)":/src:ro \
  -v school_api_frontend_dist:/dst \
  alpine \
  sh -c "rm -rf /dst/* && cp -r /src/. /dst/"

echo "✅ Frontend deployed to nginx volume"
echo "   Restart nginx: docker compose restart nginx"
