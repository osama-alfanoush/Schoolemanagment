# Uptime Robot Monitoring

Configure the following monitors in [Uptime Robot](https://uptimerobot.com).

## Monitors

| Name              | URL                                     | Type  | Interval |
|-------------------|-----------------------------------------|-------|----------|
| API Health        | https://yourdomain.com/api/health       | HTTP  | 5 min    |
| Login Endpoint    | https://yourdomain.com/api/auth/login   | HTTP  | 10 min   |
| Student Dashboard | https://yourdomain.com/api/student/dashboard | HTTP | 15 min |
| Admin Dashboard   | https://yourdomain.com/api/admin/dashboard   | HTTP | 15 min |
| Frontend App      | https://yourdomain.com                  | HTTP  | 5 min    |

> **Note:** For the Login Endpoint monitor, use a POST check with the following body:
> ```json
> { "email": "monitor@school.test", "password": "monitor-check", "device_name": "uptime-robot" }
> ```
> Set "HTTP Method" to POST and add `Content-Type: application/json` header.

## Alert Settings

- **Alert after:** 2 consecutive failures
- **Notify by:** Email, Slack webhook (if configured)
- **Alert contacts:** Set via `ALERT_EMAIL` env var, plus Slack webhook URL in project settings

## Response Validation

For the API Health monitor, validate the response contains:

```json
{ "status": "ok" }
```

All authenticated endpoints (Login, Dashboard) should expect HTTP 200 or 422 (validation) as valid responses. HTTP 401/403/500 should trigger alerts.
