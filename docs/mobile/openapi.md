# OpenAPI contract

`laravel-api/openapi.yaml` is the canonical API contract for both the React web client and future Flutter clients. It is generated from the Laravel `/api/*` routes by Scramble and must not be edited by hand.

## Regenerate

From `laravel-api`:

```bash
composer install
php artisan openapi:generate
npx @redocly/cli lint openapi.yaml
```

The command writes an OpenAPI 3.1 document, verifies that every Laravel API operation appears in it, and uses the environment-neutral relative server `/api`. For Scramble's static-analysis details, run:

```bash
php artisan scramble:analyze -v
```

## Client consumption

Client generators must read the committed `laravel-api/openapi.yaml`; they must not scrape a deployed server or maintain a parallel schema.

- React can feed the file to an OpenAPI TypeScript generator and commit or build the resulting types according to the web project's policy.
- Flutter can feed the same file to its selected Dart OpenAPI generator. The generated client's runtime base URL supplies the scheme and host, while the contract contributes `/api`.
- Generated client files are outputs. API contract changes begin in Laravel, followed by regeneration of `openapi.yaml`, review of its diff, and then client type regeneration.

## Drift policy

CI runs `php artisan openapi:generate` and then `git diff --exit-code -- openapi.yaml`. A route or inferred contract change that was not regenerated fails the build. Regenerate and commit the reviewed YAML in the same change as the Laravel contract change.

CI also runs Redocly lint. Structural OpenAPI errors fail the build; visible warnings are not suppressed and must be evaluated during review. The current Scramble analysis has seven inference warnings in three existing update endpoints:

- `PATCH /api/accounting/chart-of-accounts/{id}`
- `PATCH /api/warehouse/items/{id}`
- `PATCH /api/hr/staff/{id}`

These routes are present in the contract. Their dynamic uniqueness rules are only partially inferred because they depend on runtime model or tenant state. No `/api/*` operation is omitted.

The generator intentionally expands Laravel `Route::match` declarations into one OpenAPI operation per HTTP method and ignores only Laravel's implicit `HEAD` alias for `GET` routes.
