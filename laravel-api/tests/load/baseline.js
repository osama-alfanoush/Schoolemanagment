import http from 'k6/http';
import { check, sleep, group } from 'k6';
import { Rate, Trend } from 'k6/metrics';

const errorRate    = new Rate('errors');
const loginLatency = new Trend('login_latency');
const dashLatency  = new Trend('dashboard_latency');

export const options = {
  stages: [
    { duration: '2m', target: 50  },
    { duration: '5m', target: 50  },
    { duration: '2m', target: 0   },
  ],
  thresholds: {
    http_req_duration:  ['p(95)<500'],
    http_req_failed:    ['rate<0.01'],
    login_latency:      ['p(95)<800'],
    dashboard_latency:  ['p(95)<400'],
  },
};

const BASE = __ENV.BASE_URL || 'http://localhost';

const USERS = [
  { email:'student@school.test',   password:'password', role:'student'  },
  { email:'teacher@school.test',   password:'password', role:'teacher'  },
  { email:'parent@school.test',    password:'password', role:'parent'   },
  { email:'admin@school.test',     password:'password', role:'admin'    },
  { email:'accounting@school.test',password:'password', role:'accounting'},
  { email:'warehouse@school.test', password:'password', role:'warehouse' },
];

export default function () {
  const user = USERS[Math.floor(Math.random() * USERS.length)];

  group('auth', () => {
    const start = Date.now();
    const res = http.post(`${BASE}/api/auth/login`,
      JSON.stringify({ email: user.email, password: user.password, device_name: 'k6' }),
      { headers: { 'Content-Type': 'application/json' } }
    );
    loginLatency.add(Date.now() - start);
    check(res, { 'login 200': r => r.status === 200 });
    errorRate.add(res.status !== 200);

    const token = res.json('token');
    if (!token) return;

    const hdrs = { Authorization: `Bearer ${token}`, 'Content-Type': 'application/json' };

    group('dashboard', () => {
      const s2 = Date.now();
      const dr = http.get(`${BASE}/api/${user.role}/dashboard`, { headers: hdrs });
      dashLatency.add(Date.now() - s2);
      check(dr, { 'dashboard 200': r => r.status === 200 });
    });

    group('health', () => {
      const hr = http.get(`${BASE}/api/health`);
      check(hr, { 'health ok': r => r.status === 200 });
    });
  });

  sleep(1);
}
