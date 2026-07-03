import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { server } from './msw-handlers';
import { http, HttpResponse } from 'msw';
import HrDashboard from '@/pages/hr/Dashboard';

function makeClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

function renderDashboard() {
  return render(
    <QueryClientProvider client={makeClient()}>
      <HrDashboard />
    </QueryClientProvider>
  );
}

describe('HrDashboard', () => {
  beforeEach(() => {
    cleanup();
    vi.restoreAllMocks();
  });

  it('renders Total Staff and Pending Leave KPI cards', async () => {
    server.use(
      http.get('/api/hr/staff', () =>
        HttpResponse.json({ data: [{ id: 1 }, { id: 2 }, { id: 3 }], meta: { total: 3 } })
      ),
      http.get('/api/hr/leave-requests', () => HttpResponse.json([{ id: 1 }, { id: 2 }]))
    );

    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText('3')).toBeInTheDocument();
      expect(getByText('2')).toBeInTheDocument();
    });
    expect(getByText(/total staff/i)).toBeInTheDocument();
    expect(getByText(/pending leave/i)).toBeInTheDocument();
  });

  it('shows loading state', () => {
    server.use(
      http.get('/api/hr/staff', () =>
        new Promise((resolve) => setTimeout(() => resolve(HttpResponse.json({ data: [], meta: { total: 0 } })), 150))
      ),
      http.get('/api/hr/leave-requests', () => new Promise(() => {}))
    );

    const { getByText } = renderDashboard();
    expect(getByText(/loading/i)).toBeInTheDocument();
  });

  it('renders page heading', async () => {
    const { getByRole } = renderDashboard();

    await waitFor(() => {
      expect(getByRole('heading', { level: 1 })).toBeInTheDocument();
    });
  });

  it('renders zeros when no data', async () => {
    server.use(
      http.get('/api/hr/staff', () => HttpResponse.json({ data: [], meta: { total: 0 } })),
      http.get('/api/hr/leave-requests', () => HttpResponse.json([]))
    );

    const { getAllByText } = renderDashboard();

    await waitFor(() => {
      const zeros = getAllByText('0');
      expect(zeros.length).toBeGreaterThan(0);
    });
  });
});
