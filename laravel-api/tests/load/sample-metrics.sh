#!/bin/bash
# Samples every metric Phase 4 asks for, once per interval, to a CSV.
#
# Usage: sample-metrics.sh <label> <seconds> <interval>
set -u
LABEL="${1:?label}"
DURATION="${2:-300}"
INTERVAL="${3:-10}"
OUT="${OUTDIR:?OUTDIR required}/metrics-${LABEL}.csv"

cd "$(dirname "$0")" || exit 1
API="c:/Users/DELL/Desktop/School/School-Management-Suite/School-Management-Suite/artifacts/laravel-api"
cd "$API" || exit 1

set -a; . ./.env.staging; set +a

echo "t,api1_cpu,api2_cpu,pg_cpu,pgb_cpu,redis_cpu,api1_mem_mb,api2_mem_mb,pg_mem_mb,fpm_active,fpm_idle,fpm_total,fpm_listen_q,fpm_max_children_reached,fpm_slow,pg_conns,pg_active,pg_waiting,pgb_cl_active,pgb_cl_waiting,pgb_sv_active,pgb_sv_idle,pgb_maxwait_us,redis_mem_mb,redis_clients,redis_ops,queue_depth" > "$OUT"

END=$(( $(date +%s) + DURATION ))
while [ "$(date +%s)" -lt "$END" ]; do
  TS=$(date +%s)

  # --- container CPU / memory -------------------------------------------
  STATS=$(docker stats --no-stream --format "{{.Name}} {{.CPUPerc}} {{.MemUsage}}" 2>/dev/null)
  get_cpu() { echo "$STATS" | grep -m1 "$1" | awk '{gsub(/%/,"",$2); print $2+0}'; }
  get_mem() { echo "$STATS" | grep -m1 "$1" | awk '{v=$3; if (v ~ /GiB/) {gsub(/GiB/,"",v); print int(v*1024)} else {gsub(/MiB/,"",v); print int(v)}}'; }

  A1C=$(get_cpu school-staging-api1-1); A2C=$(get_cpu school-staging-api2-1)
  PGC=$(get_cpu school-staging-postgres-1); PBC=$(get_cpu school-staging-pgbouncer-1)
  RDC=$(get_cpu school-staging-redis-1)
  A1M=$(get_mem school-staging-api1-1); A2M=$(get_mem school-staging-api2-1); PGM=$(get_mem school-staging-postgres-1)

  # --- php-fpm pool -------------------------------------------------------
  FPM=$(curl -s -m 3 http://127.0.0.1:8080/fpm-status 2>/dev/null)
  fpm_get() { echo "$FPM" | grep -m1 "^$1:" | awk -F: '{gsub(/ /,"",$2); print $2+0}'; }
  FA=$(fpm_get "active processes"); FI=$(fpm_get "idle processes"); FT=$(fpm_get "total processes")
  FQ=$(fpm_get "listen queue"); FMC=$(fpm_get "max children reached"); FS=$(fpm_get "slow requests")

  # --- PostgreSQL ---------------------------------------------------------
  PGQ=$(MSYS_NO_PATHCONV=1 docker exec -e PGPASSWORD="$DB_PASSWORD" school-staging-postgres-1 \
    psql -U "$DB_USERNAME" -d "$DB_DATABASE" -tA -F, -c \
    "select count(*), count(*) filter (where state='active'), count(*) filter (where wait_event_type='Lock') from pg_stat_activity" 2>/dev/null)
  PGCONN=$(echo "$PGQ" | cut -d, -f1); PGACT=$(echo "$PGQ" | cut -d, -f2); PGWAIT=$(echo "$PGQ" | cut -d, -f3)

  # --- PgBouncer pools ----------------------------------------------------
  PBQ=$(MSYS_NO_PATHCONV=1 docker exec -e PGPASSWORD="$DB_PASSWORD" school-staging-pgbouncer-1 \
    psql -h 127.0.0.1 -p 6432 -U "$DB_USERNAME" -d pgbouncer -tA -F, -c "SHOW POOLS" 2>/dev/null \
    | grep "^${DB_DATABASE}," | head -1)
  PBCA=$(echo "$PBQ" | cut -d, -f3); PBCW=$(echo "$PBQ" | cut -d, -f4)
  PBSA=$(echo "$PBQ" | cut -d, -f7); PBSI=$(echo "$PBQ" | cut -d, -f10)
  PBMW=$(echo "$PBQ" | cut -d, -f15)

  # --- Redis --------------------------------------------------------------
  RINFO=$(docker exec school-staging-redis-1 redis-cli -a "$REDIS_PASSWORD" --no-auth-warning info 2>/dev/null | tr -d '\r')
  rget() { echo "$RINFO" | grep -m1 "^$1:" | cut -d: -f2; }
  RMEM=$(( $(rget used_memory 2>/dev/null || echo 0) / 1048576 ))
  RCLI=$(rget connected_clients); ROPS=$(rget instantaneous_ops_per_sec)
  QD=$(docker exec school-staging-redis-1 redis-cli -a "$REDIS_PASSWORD" --no-auth-warning \
    llen "${REDIS_PREFIX:-school_management_suite_staging_database_}queues:default" 2>/dev/null | tr -d '\r')

  echo "${TS},${A1C:-0},${A2C:-0},${PGC:-0},${PBC:-0},${RDC:-0},${A1M:-0},${A2M:-0},${PGM:-0},${FA:-0},${FI:-0},${FT:-0},${FQ:-0},${FMC:-0},${FS:-0},${PGCONN:-0},${PGACT:-0},${PGWAIT:-0},${PBCA:-0},${PBCW:-0},${PBSA:-0},${PBSI:-0},${PBMW:-0},${RMEM:-0},${RCLI:-0},${ROPS:-0},${QD:-0}" >> "$OUT"

  sleep "$INTERVAL"
done
echo "wrote $OUT ($(( $(wc -l < "$OUT") - 1 )) samples)"
