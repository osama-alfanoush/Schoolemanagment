# ONE-TIME FIX PROMPT — VITE_API_BASE_URL Production Config
# Run this separately BEFORE shipping to production

You are working on the School Management System at artifacts/school-web.

The final test report flagged this config smell:
> The production bundle hard-codes `http://127.0.0.1:8000` because `.env`
> provides `VITE_API_BASE_URL=http://127.0.0.1:8000/api`. Production builds
> should use `/api` (relative, behind a reverse proxy) or the real API origin.

## TASK: Fix the VITE_API_BASE_URL configuration

1. Read `artifacts/school-web/.env`
2. Read `artifacts/school-web/src/lib/` — find the axios instance file
3. Read `artifacts/laravel-api/config/cors.php`
4. Read `artifacts/school-web/vite.config.ts`

Then make EXACTLY these changes:

### A. Update .env files

`.env` (development — used by Vite dev server):
  VITE_API_BASE_URL=/api

`.env.production` (create if not exists):
  VITE_API_BASE_URL=/api

`.env.test` (already correct — keep `/api`):
  VITE_API_BASE_URL=/api

`.env.local.example` (create as documentation):
  # Override for local dev WITHOUT the Vite proxy:
  # VITE_API_BASE_URL=http://127.0.0.1:8000/api

### B. Add Vite proxy for local development

In `vite.config.ts`, add:
  server: {
    proxy: {
      "/api": {
        target: "http://127.0.0.1:8000",
        changeOrigin: true,
        // Do NOT rewrite — Laravel expects /api prefix
      },
    },
  },

This means:
  - Dev: browser calls /api/... → Vite proxies to Laravel on :8000
  - Prod: browser calls /api/... → Nginx routes to PHP-FPM directly
  - Test: calls /api/... → MSW intercepts (no real network)

### C. Update Laravel CORS config

In `artifacts/laravel-api/config/cors.php`:
  "allowed_origins" => [
    env("FRONTEND_URL", "http://localhost:5173"),
  ],

In `.env.production` of laravel-api:
  FRONTEND_URL=https://yourdomain.com

### D. Update Nginx config

In your nginx.conf (artifacts/laravel-api/nginx.conf or deploy/nginx.conf),
ensure this block exists:

  location /api {
      try_files $uri $uri/ /index.php?$query_string;
      proxy_pass http://php-fpm:9000;   # adjust to your PHP-FPM service name
  }

  location / {
      root /var/www/html/public/school-web;  # React dist
      try_files $uri $uri/ /index.html;      # SPA fallback
  }

### E. Verify

After making changes:
  1. npm run build
  2. grep -r "127.0.0.1" dist/ --include="*.js" | wc -l
     → must be 0
  3. npx tsc --noEmit
     → must be 0 errors
  4. npm run test
     → must be 112/112 still passing

Report:
  - Files modified (list)
  - Result of grep check (number found)
  - tsc result
  - Test count
