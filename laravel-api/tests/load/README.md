# Load Testing

Uses [k6](https://k6.io) to simulate traffic against the School Management API.

## Prerequisites

Install k6:

```bash
# macOS
brew install k6

# Ubuntu/Debian
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt-get update && sudo apt-get install k6

# Windows (Chocolatey)
choco install k6
```

## Run Commands

### 1. Normal school day baseline

Simulates 50 concurrent users over a 9-minute window (2m ramp-up, 5m steady, 2m ramp-down).

```bash
k6 run tests/load/baseline.js \
  -e BASE_URL=https://staging.yourdomain.com
```

Thresholds:
- 95% of requests < 500ms
- Failure rate < 1%
- Login latency p95 < 800ms
- Dashboard latency p95 < 400ms

### 2. Report card day peak

Simulates 500 concurrent users — expected during grade-release periods.

```bash
k6 run tests/load/peak.js \
  -e BASE_URL=https://staging.yourdomain.com
```

Thresholds:
- 95% of requests < 800ms
- Failure rate < 2%

### 3. Stress test / find breaking point

Pushes 2000 VUs for 2 minutes to discover the system's breaking point.

```bash
k6 run --vus=2000 --duration=2m tests/load/peak.js \
  -e BASE_URL=https://staging.yourdomain.com
```

## Metrics

Custom metrics recorded:
- `login_latency` — time to complete POST /api/auth/login
- `dashboard_latency` — time to load role-specific dashboard
- `errors` — rate of non-200 responses
