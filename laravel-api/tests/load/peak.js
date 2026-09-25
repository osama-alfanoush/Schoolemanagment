import http from 'k6/http';
import { check, sleep, group } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// Report-card day: the heaviest read burst the system sees, when every parent
// and student opens grades within the same hour.
//
// Same authentication model as baseline.js — sessions are established once in
// setup() and reused, because the login endpoint is rate limited per account
// and real users do not re-authenticate every 30 seconds.

const errorRate = new Rate('errors');
const loginLatency = new Trend('login_latency');
const dashLatency = new Trend('dashboard_latency');

export const options = {
  stages: [
    { duration: '1m', target: 200 },
    { duration: '5m', target: 500 },
    { duration: '3m', target: 500 },
    { duration: '1m', target: 0 },
  ],
  thresholds: {
    // Judged on steady state only; setup is a deliberate warm-up burst.
    'http_req_duration{phase:steady}': ['p(95)<800', 'p(99)<1500'],
    'http_req_failed{phase:steady}': ['rate<0.01'],
  },
};

const BASE = __ENV.BASE_URL || 'http://127.0.0.1:8080';
const PASSWORD = __ENV.LOAD_PASSWORD || 'password';

const ACCOUNTS = [
  { email: 'ali1@school.test', role: 'student' },
  { email: 'fatima4@school.test', role: 'student' },
  { email: 'aisha6@school.test', role: 'student' },
  { email: 'hassan7@school.test', role: 'student' },
  { email: 'karim9@school.test', role: 'student' },
  { email: 'layla8@school.test', role: 'student' },
  { email: 'teacher1@school.test', role: 'teacher' },
  { email: 'teacher2@school.test', role: 'teacher' },
  { email: 'teacher3@school.test', role: 'teacher' },
  { email: 'teacher4@school.test', role: 'teacher' },
  { email: 'parent1@school.test', role: 'parent' },
  { email: 'parent2@school.test', role: 'parent' },
  { email: 'parent3@school.test', role: 'parent' },
  { email: 'parent4@school.test', role: 'parent' },
];

// Grade-release traffic skews hard toward report-card and grade reads.
const READS = {
  student: ['/api/student/grades', '/api/student/report-card', '/api/student/dashboard'],
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
      {
        headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
        // setup() authenticates every account at once before the measured run.
        // Those requests are a warm-up burst — cold opcache, cold connection
        // pool, 14 simultaneous bcrypt hashes — and including them made p99
        // report a start-up artefact rather than steady-state behaviour.
        tags: { phase: 'setup' },
      },
    );
    loginLatency.add(Date.now() - started);

    if (res.status !== 200) {
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
    const res = http.get(`${BASE}${path}`, { headers, tags: { phase: 'steady' } });
    dashLatency.add(Date.now() - started);

    check(res, { 'read 200': (r) => r.status === 200 });
    errorRate.add(res.status !== 200);
  });

  sleep(1);
}
