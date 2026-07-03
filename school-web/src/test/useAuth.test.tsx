import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { useAuth } from '@/lib/auth';
import { renderHook, act } from '@testing-library/react';
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

describe('useAuth hook', () => {
  beforeEach(() => {
    localStorage.clear();
    vi.restoreAllMocks();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('returns null user when not authenticated', () => {
    const { result } = renderHook(() => useAuth(), {
      wrapper: ({ children }) => (
        <QueryClientProvider client={makeClient()}>
          <AuthProvider>{children}</AuthProvider>
        </QueryClientProvider>
      ),
    });

    expect(result.current.user).toBeNull();
    expect(result.current.loading).toBe(false);
  });

  it('returns user after successful login', async () => {
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
      )
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
    server.use(
      http.post('/api/auth/login', () =>
        HttpResponse.json({
          access_token: 'student-token',
          refresh_token: 'refresh',
          token_type: 'Bearer',
          expires_in: 3600,
          user: {
            id: 10,
            name: 'Ali Student',
            email: 'student@school.test',
            role: 'student',
            is_active: true,
            locale: null,
            photo_path: null,
          },
        })
      )
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
});
