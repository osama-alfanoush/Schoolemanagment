import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { apiFetch, Auth, authStore } from '@/lib/api';
import { server } from './msw-handlers';
import { http, HttpResponse } from 'msw';

const localStorageMock = (() => {
  let store: Record<string, string> = {};
  return {
    getItem: (key: string) => store[key] ?? null,
    setItem: (key: string, value: string) => { store[key] = value; },
    removeItem: (key: string) => { delete store[key]; },
    clear: () => { store = {}; },
  };
})();
Object.defineProperty(window, 'localStorage', { value: localStorageMock });

function requestUrl(input: RequestInfo | URL): string {
  if (typeof input === 'string') return input;
  if (input instanceof URL) return input.toString();
  return input.url;
}

describe('API layer', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.restoreAllMocks();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('uses credentialed cookie requests without exposing an Authorization token', async () => {
    authStore.setSession({
      id: 1, name: 'Test', email: 'test@test.com', role: 'admin', is_active: true,
    });

    const fetchSpy = vi.spyOn(global, 'fetch').mockResolvedValue(
      new Response(JSON.stringify({}), {
        status: 200,
        headers: { 'content-type': 'application/json' },
      })
    );

    await apiFetch('/test');

    expect(fetchSpy).toHaveBeenCalledWith(
      expect.stringContaining('/api/test'),
      expect.objectContaining({
        credentials: 'include',
      })
    );
    const request = fetchSpy.mock.calls[0]?.[1];
    const headers = new Headers(request?.headers);
    expect(headers.get('Authorization')).toBeNull();
    expect(headers.get('X-Auth-Mode')).toBe('cookie');
  });

  it('login initializes CSRF and returns user without browser-visible tokens', async () => {
    const fetchSpy = vi.spyOn(global, 'fetch').mockImplementation((input) => {
      const url = requestUrl(input);
      const payload = url.includes('/auth/csrf-cookie')
        ? { csrf_token: 'csrf-for-login' }
        : {
        token_type: 'Bearer',
        expires_in: 3600,
        user: { id: 1, name: 'Admin', email: 'admin@test.com', role: 'admin', is_active: true },
      };
      return Promise.resolve(new Response(JSON.stringify(payload), {
        status: 200,
        headers: { 'content-type': 'application/json' },
      }));
    });

    const result = await Auth.login('admin@test.com', 'password');

    expect('user' in result).toBe(true);
    if (!('user' in result)) throw new Error('Expected a completed login response');
    expect(result.user.role).toBe('admin');
    expect('access_token' in result).toBe(false);
    expect(fetchSpy.mock.calls.some(([url]) => requestUrl(url).includes('/api/auth/login'))).toBe(true);
  });

  it('returns error message on failed request', async () => {
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({ message: 'Validation failed' }, { status: 422 })
      )
    );

    await expect(Auth.login('bad', 'bad')).rejects.toThrow('Validation failed');
  });

  it('apiFetch throws on server error with message', async () => {
    server.use(
      http.get('/api/test-500', () =>
        HttpResponse.json({ message: 'Internal server error' }, { status: 500 })
      )
    );

    await expect(apiFetch('/test-500')).rejects.toThrow('Internal server error');
  });

  it('apiFetch calls with correct method and body', async () => {
    const fetchSpy = vi.spyOn(global, 'fetch').mockResolvedValue(
      new Response(JSON.stringify({}), {
        status: 200,
        headers: { 'content-type': 'application/json' },
      })
    );

    await apiFetch('/api/auth/logout', { method: 'POST' });

    expect(fetchSpy).toHaveBeenCalledWith(
      expect.stringContaining('/api/auth/logout'),
      expect.objectContaining({ method: 'POST' })
    );
  });
});
