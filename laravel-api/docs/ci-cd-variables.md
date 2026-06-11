# CI/CD Environment Variables

These variables must be set in GitLab → Settings → CI/CD → Variables.

| Variable            | Description                      | Protected | Masked |
|---------------------|----------------------------------|-----------|--------|
| `STAGING_SSH_KEY`   | SSH private key for staging      | Yes       | Yes    |
| `STAGING_HOST`      | Staging server hostname          | Yes       | No     |
| `PROD_SSH_KEY`      | SSH private key for production   | Yes       | Yes    |
| `PROD_HOST`         | Production server hostname       | Yes       | No     |
| `APP_KEY`           | Laravel app key (base64:...)     | Yes       | Yes    |
| `SENTRY_LARAVEL_DSN`| Sentry DSN for error tracking    | Yes       | Yes    |
| `DB_PASSWORD`       | Production database password     | Yes       | Yes    |
| `REDIS_PASSWORD`    | Production Redis password        | Yes       | Yes    |

## How to generate values

```bash
# Generate Laravel APP_KEY
php -r "echo 'base64:'.base64_encode(random_bytes(32));"
```

## Notes

- **Protected** variables are only exposed to pipelines running on protected branches (e.g. `main`).
- **Masked** variables are hidden in job logs. Do not use special characters (`$`, `{`, `}`, `(`, `)`, `'`, `"`, `\`) in masked values — they will cause masking to fail silently.
- The deploy jobs use SSH keys for rsync. Generate a dedicated deploy key pair and add the public key to the server's `~/.ssh/authorized_keys`.
