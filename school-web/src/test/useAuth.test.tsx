import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { useAuth } from '@/lib/auth';
import { renderHook, act } from '@testing-library/react';
import { AuthProvider } from '@/lib/auth';
import { authStore } from '@/lib/api';
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

describe('useAuth hook', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.restoreAllMocks();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('returns null user when not authenticated', async () => {
    let meRequests = 0;
    server.use(http.get('/api/auth/me', () => {
      meRequests += 1;
      return new HttpResponse(null, { status: 401 });
    }));
    const { result } = renderHook(() => useAuth(), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={makeClient()}>
          <AuthProvider>{children}</AuthProvider>
        </QueryClientProvider>
      ),
    });

    await vi.waitFor(() => expect(result.current.loading).toBe(false));
    expect(result.current.user).toBeNull();
    expect(meRequests).toBe(0);
  });

  it('returns user after successful login', async () => {
    const teacher = {
      id: 5,
      name: 'Jane Teacher',
      email: 'teacher@school.test',
      role: 'teacher',
      is_active: true,
      locale: null,
      photo_path: null,
    };
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'token-abc',
          refresh_token: 'refresh-xyz',
          token_type: 'Bearer',
          expires_in: 3600,
          user: teacher,
        })
      ),
      // login() re-fetches /auth/me to hydrate permissions — keep it consistent.
      http.get('/api/auth/me', () => HttpResponse.json({ user: teacher }))
    );

    const { result } = renderHook(() => useAuth(), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={makeClient()}>
          <AuthProvider>{children}</AuthProvider>
        </QueryClientProvider>
      ),
    });

    await act(async () => {
      await result.current.login('teacher@school.test', 'password');
    });

    expect(result.current.user).not.toBeNull();
    expect(result.current.user?.name).toBe('Jane Teacher');
    expect(result.current.user?.role).toBe('teacher');
  });

  it('clears user after logout', async () => {
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'token-abc',
          refresh_token: 'refresh-xyz',
          token_type: 'Bearer',
          expires_in: 3600,
          user: {
            id: 5,
            name: 'Jane Teacher',
            email: 'teacher@school.test',
            role: 'teacher',
            is_active: true,
            locale: null,
            photo_path: null,
          },
        })
      ),
      http.post('/api/auth/logout', () => new HttpResponse(null, { status: 204 }))
    );

    const { result } = renderHook(() => useAuth(), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={makeClient()}>
          <AuthProvider>{children}</AuthProvider>
        </QueryClientProvider>
      ),
    });

    await act(async () => {
      await result.current.login('teacher@school.test', 'password');
    });
    expect(result.current.user).not.toBeNull();

    await act(async () => {
      await result.current.logout();
    });
    expect(result.current.user).toBeNull();
  });

  it('returns correct user role', async () => {
    const student = {
      id: 10,
      name: 'Ali Student',
      email: 'student@school.test',
      role: 'student',
      is_active: true,
      locale: null,
      photo_path: null,
    };
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'student-token',
          refresh_token: 'refresh',
          token_type: 'Bearer',
          expires_in: 3600,
          user: student,
        })
      ),
      // login() re-fetches /auth/me to hydrate permissions — keep it consistent.
      http.get('/api/auth/me', () => HttpResponse.json({ user: student }))
    );

    const { result } = renderHook(() => useAuth(), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={makeClient()}>
          <AuthProvider>{children}</AuthProvider>
        </QueryClientProvider>
      ),
    });

    await act(async () => {
      await result.current.login('student@school.test', 'password');
    });

    expect(result.current.user?.role).toBe('student');
  });

  it('drops the user when the session store is cleared (e.g. after a failed refresh)', async () => {
    const teacher = {
      id: 7,
      name: 'Sam Teacher',
      email: 'sam@school.test',
      role: 'teacher',
      is_active: true,
      locale: null,
      photo_path: null,
    };
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'tok',
          refresh_token: 'ref',
          token_type: 'Bearer',
          expires_in: 3600,
          user: teacher,
        })
      ),
      http.get('/api/auth/me', () => HttpResponse.json({ user: teacher }))
    );

    const { result } = renderHook(() => useAuth(), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={makeClient()}>
          <AuthProvider>{children}</AuthProvider>
        </QueryClientProvider>
      ),
    });

    await act(async () => {
      await result.current.login('sam@school.test', 'password');
    });
    expect(result.current.user).not.toBeNull();

    // Simulate what refreshTokens() does when the refresh token is rejected:
    // the store clears itself and announces the change. The provider must
    // drop the user so RoleGuard can route to /login instead of leaving a
    // zombie session.
    act(() => {
      authStore.clear();
    });

    expect(result.current.user).toBeNull();
  });
});
