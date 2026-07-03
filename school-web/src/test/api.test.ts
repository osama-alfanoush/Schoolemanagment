import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { apiFetch, Auth, tokenStore } from '@/lib/api';
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

describe('API layer', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.restoreAllMocks();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('includes Bearer token in request headers', async () => {
    tokenStore.setSession('test-access-token', 'test-refresh-token', {
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
        headers: expect.objectContaining({
          Authorization: 'Bearer test-access-token',
        }),
      })
    );
  });

  it('login returns access token and user', async () => {
    const fetchSpy = vi.spyOn(global, 'fetch').mockResolvedValue(
      new Response(JSON.stringify({
        access_token: 'token-abc',
        refresh_token: 'refresh-xyz',
        token_type: 'Bearer',
        expires_in: 3600,
        user: { id: 1, name: 'Admin', email: 'admin@test.com', role: 'admin', is_active: true },
      }), {
        status: 200,
        headers: { 'content-type': 'application/json' },
      })
    );

    const result = await Auth.login('admin@test.com', 'password');

    expect(result.access_token).toBe('token-abc');
    expect(result.user.role).toBe('admin');
    expect(fetchSpy).toHaveBeenCalledWith(
      expect.stringContaining('/api/auth/login'),
      expect.objectContaining({ method: 'POST' })
    );
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
