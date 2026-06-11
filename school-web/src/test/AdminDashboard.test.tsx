import { describe, it, expect, vi } from 'vitest';
import { render, cleanup, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { server } from './msw-handlers';
import { http, HttpResponse } from 'msw';
import AdminDashboard from '@/pages/admin/Dashboard';
import { useAuth } from '@/lib/auth';

vi.mock('@/lib/auth', () => ({
  useAuth: vi.fn(),
}));

function makeClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

function renderDashboard(authUser?: any) {
  (useAuth as ReturnType<typeof vi.fn>).mockReturnValue({
    user: authUser ?? { id: 1, name: 'Admin', email: 'admin@test.com', role: 'admin', is_active: true },
    loading: false,
    login: vi.fn(),
    logout: vi.fn(),
    refreshUser: vi.fn(),
  });

  return render(
    <QueryClientProvider client={makeClient()}>
      <AdminDashboard />
    </QueryClientProvider>
  );
}

describe('AdminDashboard', () => {
  beforeEach(() => {
    cleanup();
    vi.restoreAllMocks();
  });

  it('renders KPI cards with data from API', async () => {
    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText('120')).toBeInTheDocument();
    });
    expect(getByText('Total Students')).toBeInTheDocument();
    expect(getByText('Total Teachers')).toBeInTheDocument();
    expect(getByText('Classes')).toBeInTheDocument();
  });

  it('shows loading state before data arrives', async () => {
    server.use(
      http.get('/api/admin/dashboard/kpis', () =>
        new Promise((resolve) =>
          setTimeout(
            () => resolve(HttpResponse.json({ students: 120, teachers: 15, staff: 8, classes: 10 })),
            150
          )
        )
      )
    );

    const { getByText } = renderDashboard();

    expect(getByText(/loading/i)).toBeInTheDocument();

    await waitFor(() => {
      expect(getByText('120')).toBeInTheDocument();
    });
  });

  it('renders fallback zeros when API fails (no error UI, graceful degradation)', async () => {
    server.use(
      http.get('/api/admin/dashboard/kpis', () =>
        HttpResponse.json({ message: 'Server error' }, { status: 500 })
      )
    );

    const { getAllByText } = renderDashboard();

    await waitFor(() => {
      const zeros = getAllByText('0');
      expect(zeros.length).toBeGreaterThan(0);
    });
  });

  it('renders correct labels for students, teachers, classes', async () => {
    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText('Total Students')).toBeInTheDocument();
      expect(getByText('Total Teachers')).toBeInTheDocument();
      expect(getByText('Classes')).toBeInTheDocument();
    });
  });
});