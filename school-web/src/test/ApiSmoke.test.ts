import { describe, it, expect, vi, beforeEach } from 'vitest';
import { http, HttpResponse } from 'msw';
import { server } from './msw-handlers';
import { apiFetch, apiDownload, ApiError, tokenStore } from '@/lib/api';

beforeEach(() => {
  localStorage.clear();
});

describe('apiFetch', () => {
  it('performs a GET request and returns JSON', async () => {
    const data = await apiFetch('/auth/me');
    expect(data).toHaveProperty('user');
  });

  it('throws ApiError on non-ok response', async () => {
    server.use(
      http.get('/api/test-error', () => new HttpResponse(null, { status: 500 }))
    );
    await expect(apiFetch('/test-error')).rejects.toThrow(ApiError);
  });

  it('throws ApiError with status 0 on network error', async () => {
    server.use(
      http.get('/api/test-network', () => HttpResponse.error())
    );
    await expect(apiFetch('/test-network')).rejects.toMatchObject({
      status: 0,
      message: 'Network error',
    });
  });
});

describe('tokenStore', () => {
  it('stores and retrieves access token', () => {
    tokenStore.setSession('access123', 'refresh123', {
      id: 1, name: 'T', email: 't@t.com', role: 'admin', is_active: true,
    });
    expect(tokenStore.getAccess()).toBe('access123');
    expect(tokenStore.getRefresh()).toBe('refresh123');
  });

  it('stores minimal user info', () => {
    tokenStore.setSession('a', 'r', {
      id: 1, name: 'Test', email: 't@t.com', role: 'admin', is_active: true,
      locale: 'en', photo_path: null,
    });
    const user = tokenStore.getUser();
    expect(user?.id).toBe(1);
    expect(user?.role).toBe('admin');
    expect(user).not.toHaveProperty('is_active');
  });

  it('clears all stored data', () => {
    tokenStore.setSession('a', 'r', {
      id: 1, name: 'T', email: 't@t.com', role: 'admin', is_active: true,
    });
    tokenStore.clear();
    expect(tokenStore.getAccess()).toBeNull();
    expect(tokenStore.getRefresh()).toBeNull();
    expect(tokenStore.getUser()).toBeNull();
  });

  it('returns null for corrupted user data', () => {
    localStorage.setItem('sm_user', '{invalid json');
    expect(tokenStore.getUser()).toBeNull();
  });
});

describe('apiDownload', () => {
  it('throws ApiError when no token is stored', async () => {
    await expect(apiDownload('/test.pdf', 'test.pdf')).rejects.toThrow(ApiError);
  });

  it('throws ApiError on download failure', async () => {
    tokenStore.setSession('token', 'refresh', {
      id: 1, name: 'T', email: 't@t.com', role: 'admin', is_active: true,
    });
    server.use(
      http.get('/api/test-download', () => new HttpResponse(null, { status: 404 }))
    );
    await expect(apiDownload('/test-download', 'test.pdf')).rejects.toMatchObject({
      status: 404,
    });
  });
});
