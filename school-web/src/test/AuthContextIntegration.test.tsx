import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useAuth } from '@/lib/auth';
import { AuthProvider } from '@/lib/auth';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { server } from './msw-handlers';
import { http, HttpResponse } from 'msw';

function makeClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

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

function Wrapper({ children }: { children: React.ReactNode }) {
  return (
    <QueryClientProvider client={makeClient()}>
      <AuthProvider>{children}</AuthProvider>
    </QueryClientProvider>
  );
}

describe('AuthContext integration', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.restoreAllMocks();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('login stores identity but no credentials in localStorage', async () => {
    const financeUser = {
      id: 99,
      name: 'Token Test User',
      email: 'token@test.com',
      role: 'finance',
      is_active: true,
      locale: null,
      photo_path: null,
    };
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'test-access-token',
          refresh_token: 'test-refresh-token',
          token_type: 'Bearer',
          expires_in: 3600,
          user: financeUser,
        })
      ),
      // login() re-fetches /auth/me to hydrate permissions — keep it consistent.
      http.get('/api/auth/me', () => HttpResponse.json({ user: financeUser }))
    );

    const { result } = renderHook(() => useAuth(), { wrapper: Wrapper });

    await act(async () => {
      await result.current.login('token@test.com', 'password');
    });

    expect(result.current.user?.email).toBe('token@test.com');
    expect(localStorage.getItem('sm_cookie_session')).toBe('1');
    expect(localStorage.getItem('sm_access_token')).toBeNull();
    expect(localStorage.getItem('sm_refresh_token')).toBeNull();
  });

  it('logout clears the local session marker', async () => {
    let logoutRequests = 0;
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'logout-token',
          refresh_token: 'logout-refresh',
          token_type: 'Bearer',
          expires_in: 3600,
          user: {
            id: 77,
            name: 'Logout User',
            email: 'logout@test.com',
            role: 'hr',
            is_active: true,
            locale: null,
            photo_path: null,
          },
        })
      ),
      http.post('/api/auth/logout', () => {
        logoutRequests += 1;
        return new HttpResponse(null, { status: 204 });
      })
    );

    const { result } = renderHook(() => useAuth(), { wrapper: Wrapper });

    await act(async () => {
      await result.current.login('logout@test.com', 'password');
    });

    expect(result.current.user).not.toBeNull();

    await act(async () => {
      await result.current.logout();
    });

    expect(result.current.user).toBeNull();
    expect(localStorage.getItem('sm_cookie_session')).toBeNull();
    expect(logoutRequests).toBe(1);
  });

  it('uses real /api/auth/me to restore session on page load', async () => {
    localStorage.setItem('sm_cookie_session', '1');
    const { result } = renderHook(() => useAuth(), { wrapper: Wrapper });
    await vi.waitFor(() => expect(result.current.loading).toBe(false));
    expect(result.current.user?.email).toBe('test@school.com');
  });

  
});
