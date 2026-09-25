# Staging and Restore Qualification

## Scope

The local staging stack is for synthetic or sanitized data only. It exercises the same application runtime concerns that must later be provisioned with managed services:

- Two PHP-FPM API replicas behind Nginx.
- Two Redis queue workers and one scheduler.
- PostgreSQL 16.
- Authenticated Redis with append-only persistence.
- Separate, versioned MinIO buckets for private records and public uploads.
- A scheduled PostgreSQL custom-format backup worker.
- SHA-256, table-count, migration-status, and RTO restore verification.

This stack does not prove managed database failover, off-site backup durability, production TLS/WAF behavior, paging, or a cloud-provider SLA.

## Commands

Run from `laravel-api` in PowerShell:

```powershell
./deploy/staging.ps1 init
./deploy/staging.ps1 validate
./deploy/staging.ps1 up
./deploy/staging.ps1 smoke
./deploy/staging.ps1 backup
./deploy/staging.ps1 restore
./deploy/staging.ps1 status
./deploy/staging.ps1 down
```

`init` creates an ignored `.env.staging` containing randomly generated local-only secrets. It refuses to overwrite an existing file so rotation cannot happen accidentally.

`up` builds immutable frontend/backend images, migrates once, starts both replicas and workers, enables daily backups, and runs the dependency smoke check.

`restore` chooses the newest dump unless `-BackupPath` is supplied. It:

1. Verifies the dump SHA-256.
2. Restores into a uniquely named temporary database.
3. Compares every public table count with the source manifest.
4. Runs Laravel `migrate:status` against the restored database.
5. Drops the temporary database even if verification fails.
6. Writes ignored JSON evidence under `restore-evidence/`.

## First verified local run

- Date: July 17, 2026
- Public liveness: passed
- PostgreSQL smoke: passed
- Redis cache and distributed-lock smoke: passed
- Redis queue smoke: passed
- Private S3-compatible object-storage smoke: passed
- Public-upload S3-compatible object-storage smoke: passed
- Backup SHA-256: passed
- Restored table counts: passed
- Restored migration status: passed
- Restore duration: 8.85 seconds
- Configured local RTO: 7,200 seconds

The evidence demonstrates that the code and local container topology can back up and restore the current synthetic staging database. A witnessed restore from encrypted, off-site production backups is still required before live data.
