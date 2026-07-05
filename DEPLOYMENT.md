# Free Deployment Guide — GitHub Pages (frontend) + Railway (backend)

Repo: `https://github.com/osama-alfanoush/Schoolemanagment`
Frontend URL after deploy: `https://osama-alfanoush.github.io/Schoolemanagment/`
Backend URL after deploy: `https://<your-service>.up.railway.app` (Railway assigns it — the one placeholder you must fill in).

## Architecture

- **Monorepo, two deploy pipelines.** `school-web/` deploys to GitHub Pages via
  `.github/workflows/deploy-frontend.yml`; `laravel-api/` deploys to Railway,
  which builds `laravel-api/Dockerfile.railway` (selected by
  `laravel-api/railway.json`, Root Directory = `laravel-api`).
- Auth is Sanctum **bearer tokens in localStorage** (not cookies), so the
  cross-origin split (github.io ↔ railway.app) works with plain CORS — no
  third-party-cookie problems.
- CORS is env-driven: set `CORS_ALLOWED_ORIGINS=https://osama-alfanoush.github.io`
  on Railway.

## Order of operations (do Railway first — Pages needs the API URL)

### Part A — Railway (backend)

1. **Create account**: https://railway.app → *Login* → *Login with GitHub* →
   authorize Railway.
2. **New project from repo**: Dashboard → **New Project** → **Deploy from
   GitHub repo** → pick `osama-alfanoush/Schoolemanagment` (click **Configure
   GitHub App** first if the repo isn't listed, and grant it access).
3. **Set root directory**: click the created service → **Settings** tab →
   *Source* section → **Root Directory** → enter `laravel-api` → save. Railway
   redeploys and now finds `railway.json` + `Dockerfile.railway`.
4. **Add Postgres**: project canvas → **+ Create** (or right-click) →
   **Database** → **Add PostgreSQL**.
5. **Set variables**: service → **Variables** tab → **Raw Editor** → paste,
   replacing `APP_KEY` with the output of `php artisan key:generate --show`
   run locally in `laravel-api/`:

   ```
   APP_KEY=base64:REPLACE_WITH_GENERATED_KEY
   APP_ENV=production
   APP_DEBUG=false
   LOG_CHANNEL=stderr
   DB_CONNECTION=pgsql
   DB_URL=${{Postgres.DATABASE_URL}}
   CORS_ALLOWED_ORIGINS=https://osama-alfanoush.github.io
   SESSION_DRIVER=file
   CACHE_STORE=file
   QUEUE_CONNECTION=sync
   RUN_SEED=true
   ```

   `RUN_SEED=true` seeds the demo accounts (`admin@school.test` / password
   `password`, etc.) on first boot — **delete this variable after the first
   successful deploy** so later redeploys don't re-seed.

   (`${{Postgres.DATABASE_URL}}` is a Railway *reference* — type it literally;
   Railway resolves it to the Postgres service's connection string. If your
   database service has a different name, use that name instead of `Postgres`.)
6. **Expose the service**: service → **Settings** → *Networking* → **Generate
   Domain**. Copy the URL, e.g. `https://schoolemanagment-production.up.railway.app`.
7. **Set APP_URL**: back in **Variables**, add
   `APP_URL=https://<the-domain-you-just-copied>`. Railway redeploys.
8. **Verify**: open `https://<domain>/api/healthz` in the browser → should
   return `{"status":"ok","service":"school-management-api"}`.
9. *(Optional, if uploads must survive redeploys)*: service → right-click →
   **Attach Volume** → mount path `/var/www/storage/app`.

### Part B — GitHub Pages (frontend)

10. **Tell the build where the API lives**: repo on GitHub → **Settings** →
    **Secrets and variables** → **Actions** → **Variables** tab → **New
    repository variable** → Name: `VITE_API_BASE_URL`, Value:
    `https://<your-railway-domain>/api` (note the trailing `/api`).
11. **Push to `main`** (or Actions → *Deploy Frontend to GitHub Pages* →
    **Run workflow**). The workflow builds `school-web` and pushes the bundle
    to the `gh-pages` branch.
12. **Enable Pages**: repo → **Settings** → **Pages** → *Build and deployment*
    → Source: **Deploy from a branch** → Branch: `gh-pages`, folder `/ (root)`
    → **Save**. (The `gh-pages` branch only exists after the workflow's first
    successful run.)
13. **Verify**: open `https://osama-alfanoush.github.io/Schoolemanagment/`,
    then log in — API calls should hit Railway (check DevTools → Network).

### Optional local flows

- **Manual frontend deploy without Actions**: edit the `build:pages` script in
  `school-web/package.json` — replace `https://YOUR-RAILWAY-APP.up.railway.app/api`
  with your real Railway URL — then `npm run deploy` (uses the `gh-pages` npm
  package; requires git push rights).
- **Smoke-test the Railway image locally** (needs Docker Desktop):

  ```bash
  cd laravel-api
  APP_KEY="base64:..." docker compose -f docker-compose.railway.yml up --build
  curl http://localhost:8080/api/healthz
  ```

## Custom domain (optional): your-domain.com

Replace `your-domain.com` with your registered domain everywhere below.
Target layout: frontend at `https://your-domain.com`, API at
`https://api.your-domain.com`.

> **Why not `your-domain.com/api`?** GitHub Pages only serves static files and
> cannot proxy a path to Railway, and DNS cannot route by path — so a true
> same-origin layout is impossible with this hosting pair. The `api.`
> subdomain is the standard equivalent; auth is Bearer-token (not cookies), so
> one CORS origin entry is the only cross-origin cost. If you ever need one
> origin, put Cloudflare (free) in front and proxy `/api/*` to Railway with a
> Worker — out of scope here.

### DNS records to create at your registrar (only you can do this)

| Host | Type | Value | Purpose |
| ---- | ---- | ----- | ------- |
| `@` (apex) | `A` (×4) | `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153` | GitHub Pages frontend |
| `www` *(optional)* | `CNAME` | `osama-alfanoush.github.io` | www → Pages (GitHub redirects it to the apex) |
| `api` | `CNAME` | value Railway shows when you add the custom domain (looks like `xyz.up.railway.app` or a `*.railway.app` target) | Railway API |

If your registrar supports `ALIAS`/`ANAME` at the apex, you may use that with
`osama-alfanoush.github.io` instead of the four A records. TLS certificates
are issued automatically by GitHub Pages and Railway once DNS resolves —
nothing to configure yourself.

### Cut-over steps, in order

1. **Railway — add the API domain**: service → **Settings** → *Networking* →
   **Custom Domain** → enter `api.your-domain.com`. Railway shows the CNAME
   target — create that `api` CNAME record at your registrar. Wait until
   Railway shows the domain as verified (cert issued).
2. **Railway — update variables** (service → **Variables**):
   - `APP_URL=https://api.your-domain.com`
   - `CORS_ALLOWED_ORIGINS=https://your-domain.com,https://osama-alfanoush.github.io`
     (keep the Pages origin until the frontend cut-over is done, then remove it).
   Railway redeploys; the container re-runs `config:cache` on boot, so no
   manual `php artisan config:clear` is needed there.
3. **GitHub — Pages domain**: repo → **Settings** → **Pages** → *Custom
   domain* → enter `your-domain.com` → **Save**, and tick **Enforce HTTPS**
   once the DNS check passes (create the four `A` records first).
4. **GitHub — repo variables** (Settings → Secrets and variables → Actions →
   Variables):
   - `PAGES_CNAME` = `your-domain.com` — flips the workflow to build with
     base path `/` and ship the `CNAME` file into the `gh-pages` branch.
   - `VITE_API_BASE_URL` = `https://api.your-domain.com/api`.
5. **Redeploy the frontend**: Actions → *Deploy Frontend to GitHub Pages* →
   **Run workflow** (a rebuild is required — the API URL and base path are
   baked into the JS bundle at build time).
6. **Verify**: `https://api.your-domain.com/api/healthz` returns ok; open
   `https://your-domain.com`, log in, and confirm in DevTools → Network that
   calls hit `api.your-domain.com` over `https://` with no CORS or
   mixed-content errors.
7. **Clean up**: remove `https://osama-alfanoush.github.io` from
   `CORS_ALLOWED_ORIGINS` on Railway. The old
   `osama-alfanoush.github.io/Schoolemanagment` URL now redirects to the
   custom domain automatically.

## Free-tier constraints to know

- **Railway**: the free/trial plan gives a limited monthly credit — a single
  small service + Postgres fits, but the service may sleep or the credit may
  run out mid-month. Filesystem is ephemeral (see volume note above). Queue
  runs `sync` (inline) — no background worker or scheduler container.
- **GitHub Pages**: static hosting only; the SPA is public even if the repo is
  private (Pages on private repos needs a paid plan). Deep links work via the
  `404.html` fallback the workflow ships.
- **Rotate any real secrets** (Stripe, FCM) only through the Railway
  dashboard — nothing secret is committed to this repo.
