#!/bin/sh
set -eu

mkdir -p /backups

backup_once() {
  timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
  base="/backups/${BACKUP_PREFIX:-school}_${timestamp}"
  temporary="${base}.dump.partial"

  pg_dump \
    --host="$DB_HOST" \
    --port="$DB_PORT" \
    --username="$DB_USERNAME" \
    --dbname="$DB_DATABASE" \
    --format=custom \
    --no-owner \
    --no-privileges \
    --file="$temporary"

  mv "$temporary" "${base}.dump"
  sha256sum "${base}.dump" > "${base}.dump.sha256"
  psql \
    --host="$DB_HOST" \
    --port="$DB_PORT" \
    --username="$DB_USERNAME" \
    --dbname="$DB_DATABASE" \
    --no-psqlrc \
    --file=/ops/sql/table-counts.sql > "${base}.counts.txt"

  # Database rows and uploaded files form one recoverable application backup.
  # The storage volume is mounted read-only into this container.
  #
  # BOTH trees must be captured. app/public holds school logos and other
  # non-sensitive assets; app/private/uploads is where PrivateFileVault writes
  # every personal file -- profile photos, assignment attachments and student
  # submissions. This archive originally covered app/public only, which predated
  # private storage: a restore would have rebuilt a database whose file rows all
  # pointed at bytes that no longer existed, and the loss would only have
  # surfaced when someone opened a pupil's record.
  uploads_paths=""
  [ -d /storage/app/public ] && uploads_paths="$uploads_paths app/public"
  [ -d /storage/app/private ] && uploads_paths="$uploads_paths app/private"

  if [ -n "$uploads_paths" ]; then
    # Word splitting is intended here: uploads_paths holds separate tar operands.
    # shellcheck disable=SC2086
    tar -czf "${base}.uploads.tar.gz.partial" -C /storage $uploads_paths
    mv "${base}.uploads.tar.gz.partial" "${base}.uploads.tar.gz"
    sha256sum "${base}.uploads.tar.gz" > "${base}.uploads.tar.gz.sha256"
  else
    echo "WARNING: no upload directories found under /storage -- files not backed up" >&2
  fi

  printf '%s\n' "$timestamp" > /backups/last-success.txt
  find /backups -type f -mtime "+${BACKUP_RETENTION_DAYS:-14}" -delete
  echo "Backup completed: ${base}.dump"
}

if [ "${1:-}" = "once" ]; then
  backup_once
  exit 0
fi

while true; do
  backup_once
  sleep "${BACKUP_INTERVAL_SECONDS:-86400}"
done
