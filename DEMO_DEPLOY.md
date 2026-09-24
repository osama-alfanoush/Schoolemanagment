# Customer demo deploy (single origin, Railway)

A runbook for putting the whole suite behind **one URL** to hand a customer for
evaluation. It is not the production path — see `laravel-api/README.md` and
`.github/workflows/deploy-api.yml` for that.

## What this deploys

One Railway service running `Dockerfile.demo`, which builds the React portal and
the Laravel API into a single image:

```
https://<your-service>.up.railway.app/
    /            -> nginx serves the built SPA  (/var/www/frontend)
    /api/*       -> php-fpm -> Laravel          (/var/www/public/index.php)
```

plus one Railway PostgreSQL service. Two services total.

### Why one origin and not GitHub Pages + Railway

The web client authenticates **only** by cookie — it sends `X-Auth-Mode: cookie`
with `credentials: "include"` and has no bearer-token path for the browser
(`school-web/src/lib/api.ts`). Splitting the portal onto `github.io` and the API
onto `up.railway.app` makes that a third-party cookie, and Safari — therefore
every browser on iOS — blocks third-party cookies outright. Login would work on
desktop Chrome and fail on the customer's iPhone, with no error that explains
why.

Same origin makes the cookie first-party, so `SameSite=Lax` is sufficient, CORS
does not apply at all, and `main` never has to be touched: Railway builds
directly from whichever branch you point it at.

## Prerequisites

The branch you want to show must be **pushed to GitHub**. Both platforms build
from the remote, not from your working tree.

## Choosing the platform

| | Render (`render.yaml`) | Railway (`railway.demo.json`) |
| --- | --- | --- |
| Payment method | **not required** | **required**, even for trial credit |
| Cost | free | ~\$5/month after trial credit |
| Cold start | ~50s after idle | ~30-60s if `sleepApplication` is on |
| Database | free, **deleted after ~30 days** | billed with the project |

Railway restricts a brand-new workspace until a card is attached — attempting to
create any service returns *"Your workspace has been restricted. Please attach a
payment method"*, and that applies to the trial too. So Render is the path when
no card is going to be attached; Railway is better if one is.

Both deploy the identical `Dockerfile.demo` image, so nothing below is
platform-specific except the dashboard clicks.

## Option A -- Render, no payment method

`render.yaml` at the repo root declares the web service, the database, the
region and all 14 environment variables, so there is nothing to type into a
form.

1. **render.com** → sign up with GitHub.
2. **New** → **Blueprint** → select `Schoolemanagment` → branch `mobile/wave-0`.
3. Render reads `render.yaml` and asks for exactly one value, `APP_KEY`, because
   that is the only thing deliberately not committed. Generate it with:
   ```
   node -e "console.log('base64:'+require('crypto').randomBytes(32).toString('base64'))"
   ```
4. **Apply**. The first build takes roughly 10-20 minutes — `npm ci`, a Vite
   production build, Composer install and two compiles of the Redis extension.
5. When it is live, delete the `RUN_SEED` environment variable from the service,
   then jump to *Verify* below.

Optionally set `APP_URL` to the hostname Render assigned. Nothing in the demo
breaks without it — the portal calls a relative `/api` and mail goes to the log —
it only affects links generated inside emails.

## Option B -- Railway, requires a card

### 1. Create the project

Railway → **New Project** → **Deploy from GitHub repo** → `Schoolemanagment`.
In the service's **Settings**:

| Setting | Value |
| ------- | ----- |
| Branch | the branch to demo (e.g. `mobile/wave-0`) |
| Root Directory | `/` — the repo root, **not** `laravel-api`. The image needs `school-web/` and `laravel-api/` in one build context. |
| Config-as-code path | `railway.demo.json` |

`railway.demo.json` selects `Dockerfile.demo`, the health check and
`sleepApplication`. The production `laravel-api/railway.json` is left untouched.

### 2. Add the database

**New** → **Database** → **PostgreSQL**, in the same project.

### 3. Generate the public domain first

Service → **Settings** → **Networking** → **Generate Domain**. Do this before
setting variables: `APP_URL` has to contain the final hostname, and getting it
now avoids a second redeploy.

### 4. Set the variables

Service → **Variables**. Nothing ships in the image; everything comes from here.

| Variable | Value |
| -------- | ----- |
| `APP_KEY` | `base64:...` — generate with `php artisan key:generate --show` (or any 32 random bytes, base64-encoded, prefixed `base64:`). |
| `APP_ENV` | `staging` |
| `APP_DEBUG` | `false` |
| `APP_URL` | the domain from step 3, e.g. `https://school-demo.up.railway.app` |
| `LOG_CHANNEL` | `stderr` — routes logs to Railway's viewer. |
| `DB_CONNECTION` | `pgsql` |
| `DB_URL` | `${{Postgres.DATABASE_URL}}` — the Railway *reference*, typed exactly like that. An empty `DB_URL` silently falls back to 127.0.0.1 and the deploy fails at migration. |
| `CACHE_STORE` | `file` |
| `SESSION_DRIVER` | `file` |
| `QUEUE_CONNECTION` | `sync` |
| `SESSION_SECURE_COOKIE` | `true` |
| `WEB_AUTH_COOKIE_SECURE` | `true` |
| `TRUSTED_PROXIES` | `*` |
| `RUN_SEED` | `true` — **first deploy only**, then delete it (see step 6). |

Leave `CORS_ALLOWED_ORIGINS`, `WEB_AUTH_COOKIE_SAME_SITE` and
`SESSION_SAME_SITE` unset. Same-origin requests never trigger CORS, and the
`lax` default is correct and safer than `none`.

Three of these are load-bearing in ways that are not obvious:

- **`APP_ENV=staging`, not `production`.** `ops:preflight-env` returns early
  outside production (`app/Console/Commands/PreflightEnvironment.php:30`). In
  production it would refuse to boot here, correctly: uploads are on the
  container filesystem and there is no object storage configured. Staging also
  gates `RUN_SEED`, which the entrypoint forbids in production.
- **`APP_DEBUG=false` must be explicit.** `AppServiceProvider` clamps debug off
  only when the environment is production. In staging, whatever you set is what
  you get.
- **`WEB_AUTH_COOKIE_SECURE=true` must be explicit.** It defaults to
  `env('APP_ENV') === 'production'` (`config/web-auth.php:10`), so in staging it
  would default to *false* and the auth cookie would lose its `Secure` flag.
- **`CACHE_STORE=file`, not `database`.** The entrypoint runs
  `migrate --isolated`, which takes a cache lock *before* migrating. On a fresh
  database the cache table does not exist yet, so a database cache store cannot
  acquire that lock and the very first deploy dies.

### 5. Deploy

Railway builds on push. The first build is slow — `npm ci`, a Vite production
build, Composer install and two compiles of the Redis extension, roughly 8-15
minutes. Later builds reuse layers.

### 6. Remove the seed flag

Once the first deploy is green, **delete the `RUN_SEED` variable.** Left set, it
re-seeds on every restart, and every restart would discard whatever the customer
had entered.

### 7. Verify

```bash
curl -s https://<your-domain>/api/healthz          # expect a JSON ok payload
curl -sI https://<your-domain>/ | head -n 1        # expect HTTP/2 200 (the SPA)
```

Then open the domain in a browser and log in. Check `Set-Cookie` on the login
response in devtools: it should carry `Secure` and `SameSite=Lax`, with no
`Domain` attribute.

## Demo logins

Seeded by `database/seeders/DatabaseSeeder.php`. Every one of them has the
password `password`.

| Email | Role |
| ----- | ---- |
| `admin@school.test` | admin |
| `finance@school.test` | finance |
| `hr@school.test` | HR |
| `accounting@school.test` | finance (accounting) |
| `warehouse@school.test` | warehouse |
| `procurement@school.test` | procurement |

The seeder also creates an academic year, three classes, teachers, students,
a timetable, grade components and grades, so the dashboards are not empty.

## Known limits of this setup

Say these out loud to the customer rather than letting them discover them.

- **Cold start.** On Render's free plan the instance is stopped after 15 minutes
  idle and the next request pays for a full boot — migrations,
  config/route/view/event caches — so expect roughly 50 seconds on the first hit
  after a quiet period. Warm it yourself right before the customer opens the
  link. On Railway the same applies because `railway.demo.json` sets
  `sleepApplication: true` to conserve credit; set it to `false` while they are
  actively testing.
- **On Render the free database is deleted after about 30 days.** If the trial
  runs longer than that, everything the customer entered goes with it. For a
  longer pilot, point `DB_URL` at a free Neon project instead, which does not
  expire, or move to a paid database.
- **Uploads are ephemeral.** No volume is attached, so profile photos and
  documents are destroyed by every redeploy. Attach a Railway Volume mounted at
  `/var/www/storage/app` if the trial needs them to persist.
- **No queue worker and no scheduler.** `QUEUE_CONNECTION=sync` runs jobs inline
  in the request instead, which is why the demo does not need the `worker` and
  `scheduler` services that `docker/railway-entrypoint.sh` describes. Scheduled
  work — contract renewals, installment reminders, token pruning, audit
  retention — does not run at all here.
- **Not a production configuration.** It deliberately bypasses `ops:preflight-env`.
  Do not let it drift into being the real deployment.
