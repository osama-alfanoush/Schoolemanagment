import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { server } from './msw-handlers';
import { http, HttpResponse } from 'msw';
import StudentDashboard from '@/pages/student/Dashboard';

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
      <StudentDashboard />
    </QueryClientProvider>
  );
}

describe('StudentDashboard', () => {
  beforeEach(() => {
    cleanup();
    vi.restoreAllMocks();
  });

  it('renders pending assignments card with data', async () => {
    server.use(
      http.get('/api/student/dashboard', () =>
        HttpResponse.json({ pending_assignments: 5, upcoming_events: 2 })
      )
    );

    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText('5')).toBeInTheDocument();
    });
    expect(getByText('Pending Assignments')).toBeInTheDocument();
  });

  it('shows loading state', async () => {
    server.use(
      http.get('/api/student/dashboard', () =>
        new Promise((resolve) => setTimeout(() => resolve(HttpResponse.json({ pending_assignments: 3 })), 150))
      )
    );

    const { getByText } = renderDashboard();
    expect(getByText(/loading/i)).toBeInTheDocument();

    await waitFor(() => {
      expect(getByText('3')).toBeInTheDocument();
    });
  });

  it('renders fallback zero when no data', async () => {
    server.use(
      http.get('/api/student/dashboard', () =>
        HttpResponse.json({ pending_assignments: 0, upcoming_events: 0 })
      )
    );

    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText('0')).toBeInTheDocument();
    });
  });

  it('renders heading text', async () => {
    const { getByRole } = renderDashboard();

    await waitFor(() => {
      expect(getByRole('heading', { level: 1 })).toBeInTheDocument();
    });
  });
});