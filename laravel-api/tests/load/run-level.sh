#!/bin/bash
# One capacity level: start the metric sampler, run k6 at a fixed VU count,
# collect both. Usage: run-level.sh <label> <vus> <steady_seconds> [base_url]
set -u
LABEL="${1:?label}"
VUS="${2:?vus}"
STEADY="${3:-150}"
BASE="${4:-http://127.0.0.1:8090}"

SP="C:/Users/DELL/AppData/Local/Temp/claude/c--Users-DELL-Desktop-School-School-Management-Suite-School-Management-Suite-artifacts/62b5f4ff-3bb9-478b-a0c4-d2fc71995ce7/scratchpad"
API="c:/Users/DELL/Desktop/School/School-Management-Suite/School-Management-Suite/artifacts/laravel-api"
OUT="$SP/perf"
mkdir -p "$OUT"
cd "$API" || exit 1
W=$(pwd -W)

RAMP=20
TOTAL=$(( RAMP + STEADY + 10 ))

echo "### level ${LABEL}: ${VUS} VU, ${STEADY}s steady (sampling ${TOTAL}s)"

# Reset PgBouncer counters so maxwait reflects this level only.
set -a; . ./.env.staging; set +a
MSYS_NO_PATHCONV=1 docker exec -e PGPASSWORD="$DB_PASSWORD" school-staging-pgbouncer-1 \
  psql -h 127.0.0.1 -p 6432 -U "$DB_USERNAME" -d pgbouncer -c "RECONNECT" >/dev/null 2>&1

OUTDIR="$OUT" bash "$SP/sample-metrics.sh" "$LABEL" "$TOTAL" 5 > /dev/null 2>&1 &
SAMPLER=$!

MSYS_NO_PATHCONV=1 docker run --rm --network host \
  -v "$W/tests/load:/scripts" grafana/k6:latest run \
  -e BASE_URL="$BASE" \
  --stage "${RAMP}s:${VUS}" --stage "${STEADY}s:${VUS}" --stage 5s:0 \
  --summary-export="/scripts/results/summary-${LABEL}.json" \
  --summary-trend-stats="avg,min,med,p(50),p(95),p(99),max" \
  /scripts/peak.js > "$OUT/k6-${LABEL}.log" 2>&1

wait $SAMPLER
echo "### level ${LABEL} complete"
grep -E "http_req_duration|http_req_failed|http_reqs|iterations|checks_succ|✓|✗" "$OUT/k6-${LABEL}.log" | tail -12
