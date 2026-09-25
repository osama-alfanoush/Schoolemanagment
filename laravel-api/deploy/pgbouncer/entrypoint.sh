#!/bin/sh
# Renders pgbouncer.ini and the auth file from environment variables at start,
# so no credential is ever written into the repository or baked into an image.
#
# Required: DB_HOST DB_PORT DB_DATABASE DB_USERNAME DB_PASSWORD
# Optional: PGB_MAX_CLIENT_CONN PGB_DEFAULT_POOL_SIZE PGB_MIN_POOL_SIZE
#           PGB_RESERVE_POOL_SIZE
set -eu

: "${DB_HOST:?DB_HOST is required}"
: "${DB_PORT:=5432}"
: "${DB_DATABASE:?DB_DATABASE is required}"
: "${DB_USERNAME:?DB_USERNAME is required}"
: "${DB_PASSWORD:?DB_PASSWORD is required}"

: "${PGB_MAX_CLIENT_CONN:=500}"
: "${PGB_DEFAULT_POOL_SIZE:=25}"
: "${PGB_MIN_POOL_SIZE:=5}"
: "${PGB_RESERVE_POOL_SIZE:=5}"

CONF_DIR=/etc/pgbouncer
mkdir -p "$CONF_DIR"

sed \
  -e "s|__DB_HOST__|${DB_HOST}|g" \
  -e "s|__DB_PORT__|${DB_PORT}|g" \
  -e "s|__DB_NAME__|${DB_DATABASE}|g" \
  -e "s|__DB_USER__|${DB_USERNAME}|g" \
  -e "s|__MAX_CLIENT_CONN__|${PGB_MAX_CLIENT_CONN}|g" \
  -e "s|__DEFAULT_POOL_SIZE__|${PGB_DEFAULT_POOL_SIZE}|g" \
  -e "s|__MIN_POOL_SIZE__|${PGB_MIN_POOL_SIZE}|g" \
  -e "s|__RESERVE_POOL_SIZE__|${PGB_RESERVE_POOL_SIZE}|g" \
  /templates/pgbouncer.ini > "$CONF_DIR/pgbouncer.ini"

# PgBouncer authenticates clients itself. Storing the SCRAM verifier rather than
# the plaintext password means the file is not a reusable credential on its own.
# Generated with PostgreSQL's own algorithm via the server, so the verifier
# matches what the database would accept.
if [ -n "${DB_SCRAM_VERIFIER:-}" ]; then
  printf '"%s" "%s"\n' "$DB_USERNAME" "$DB_SCRAM_VERIFIER" > "$CONF_DIR/userlist.txt"
else
  # Fallback for local and staging: plain auth against the pooler, which then
  # authenticates to PostgreSQL normally. Acceptable only because the pooler is
  # not reachable outside the private network. Production should supply
  # DB_SCRAM_VERIFIER instead.
  echo 'warning: DB_SCRAM_VERIFIER not set; falling back to plain auth on the pooler' >&2
  sed -i 's/^auth_type = scram-sha-256/auth_type = plain/' "$CONF_DIR/pgbouncer.ini"
  printf '"%s" "%s"\n' "$DB_USERNAME" "$DB_PASSWORD" > "$CONF_DIR/userlist.txt"
fi

chmod 600 "$CONF_DIR/userlist.txt"

echo "==> PgBouncer: transaction pooling, max_client_conn=${PGB_MAX_CLIENT_CONN}, default_pool_size=${PGB_DEFAULT_POOL_SIZE} -> ${DB_HOST}:${DB_PORT}/${DB_DATABASE}"
exec pgbouncer "$CONF_DIR/pgbouncer.ini"
