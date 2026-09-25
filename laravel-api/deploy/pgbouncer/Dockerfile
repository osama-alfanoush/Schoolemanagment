# syntax=docker/dockerfile:1
#
# PgBouncer with the project's pooling policy baked in and its credentials
# supplied at runtime. Alpine 3.21 ships PgBouncer 1.23, which is past the 1.21
# release that tracks protocol-level prepared statements per client — the
# feature that makes transaction pooling safe for PDO's pdo_pgsql driver.
#
# postgresql-client provides pg_isready for the healthcheck and, as a side
# effect, the unprivileged `postgres` account this image drops to (the pgbouncer
# package alone creates no user). A pooler that cannot be reached is not
# pooler that cannot be reached is not healthy, and the orchestrator should
# restart it rather than leave the application with a dead pool.
FROM alpine:3.21

RUN apk add --no-cache pgbouncer postgresql-client && \
    mkdir -p /etc/pgbouncer /templates && \
    chown -R postgres:postgres /etc/pgbouncer

COPY pgbouncer.ini /templates/pgbouncer.ini
COPY entrypoint.sh /usr/local/bin/pgbouncer-entrypoint.sh
RUN chmod +x /usr/local/bin/pgbouncer-entrypoint.sh

USER postgres
EXPOSE 6432

HEALTHCHECK --interval=10s --timeout=5s --retries=6 --start-period=10s \
    CMD pg_isready -h 127.0.0.1 -p 6432 -U "${DB_USERNAME:-postgres}" -d "${DB_DATABASE:-postgres}" || exit 1

ENTRYPOINT ["/usr/local/bin/pgbouncer-entrypoint.sh"]
