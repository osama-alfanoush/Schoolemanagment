import http from 'k6/http';
import { check, sleep, group } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// Normal school-day traffic: 50 concurrent users over a 9-minute window.
//
// Authentication happens ONCE per account in setup(), not once per iteration.
// That is both realistic (a user signs in at the start of a session and reuses
// the token for hours) and required: the login endpoint is deliberately rate
// limited to 8 attempts/minute per account, so a login-per-iteration script
// measures the rate limiter rather than the application.
//
// Accounts whose role requires MFA (admin, finance, hr, warehouse, procurement)
// cannot complete a scripted password login — the API answers 202 with an MFA
// challenge by design. Load is therefore driven through the non-privileged
// roles that make up the overwhelming majority of real traffic.

const errorRate = new Rate('errors');
const loginLatency = new Trend('login_latency');
const dashLatency = new Trend('dashboard_latency');

export const options = {
  stages: [
    { duration: '2m', target: 50 },
    { duration: '5m', target: 50 },
    { duration: '2m', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
    login_latency: ['p(95)<800'],
    dashboard_latency: ['p(95)<400'],
  },
};

const BASE = __ENV.BASE_URL || 'http://127.0.0.1:8080';
const PASSWORD = __ENV.LOAD_PASSWORD || 'password';

const ACCOUNTS = [
  { email: 'ali1@school.test', role: 'student' },
  { email: 'fatima4@school.test', role: 'student' },
  { email: 'aisha6@school.test', role: 'student' },
  { email: 'hassan7@school.test', role: 'student' },
  { email: 'teacher1@school.test', role: 'teacher' },
  { email: 'teacher2@school.test', role: 'teacher' },
  { email: 'teacher3@school.test', role: 'teacher' },
  { email: 'parent1@school.test', role: 'parent' },
  { email: 'parent2@school.test', role: 'parent' },
  { email: 'parent3@school.test', role: 'parent' },
];

// Read paths exercised per role. Each is a real screen the role opens first.
const READS = {
  student: ['/api/student/dashboard', '/api/student/grades', '/api/student/attendance'],
  teacher: ['/api/teacher/classes', '/api/teacher/timetable'],
  parent: ['/api/parent/children'],
};

export function setup() {
  const sessions = [];

  for (const account of ACCOUNTS) {
    const started = Date.now();
    const res = http.post(
      `${BASE}/api/auth/login`,
      JSON.stringify({ email: account.email, password: PASSWORD, device_name: 'k6' }),
      { headers: { 'Content-Type': 'application/json', Accept: 'application/json' } },
    );
    loginLatency.add(Date.now() - started);

    if (res.status !== 200) {
      // Surfaced rather than swallowed: a failed setup login means the seeded
      // fixture drifted, and the whole run would otherwise report a false pass.
      console.error(`setup login failed for ${account.email}: HTTP ${res.status}`);
      continue;
    }

    sessions.push({ role: account.role, token: res.json('access_token') || res.json('token') });
  }

  if (sessions.length === 0) {
    throw new Error('No load-test session could be established; check seeded accounts and LOAD_PASSWORD.');
  }

  return { sessions };
}

export default function (data) {
  const session = data.sessions[Math.floor(Math.random() * data.sessions.length)];
  const headers = {
    Authorization: `Bearer ${session.token}`,
    'Content-Type': 'application/json',
    Accept: 'application/json',
  };

  group('read', () => {
    const paths = READS[session.role];
    const path = paths[Math.floor(Math.random() * paths.length)];

    const started = Date.now();
    const res = http.get(`${BASE}${path}`, { headers });
    dashLatency.add(Date.now() - started);

    check(res, { 'read 200': (r) => r.status === 200 });
    errorRate.add(res.status !== 200);
  });

  group('liveness', () => {
    // The PUBLIC liveness probe. /api/health is the detailed dependency report
    // and is admin-only on purpose, so it is not part of the load profile.
    const res = http.get(`${BASE}/api/healthz`);
    check(res, { 'healthz 200': (r) => r.status === 200 });
    errorRate.add(res.status !== 200);
  });

  sleep(1);
}
