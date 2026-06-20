import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, cleanup, waitFor } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { server } from './msw-handlers';
import { http, HttpResponse } from 'msw';
import TeacherDashboard from '@/pages/teacher/Dashboard';

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
      <TeacherDashboard />
    </QueryClientProvider>
  );
}

describe('TeacherDashboard', () => {
  beforeEach(() => {
    cleanup();
    vi.restoreAllMocks();
  });

  it('renders My Classes count from API', async () => {
    server.use(
      http.get('*/api/teacher/classes', () =>
        HttpResponse.json([
          { id: 1, name: 'Math 101' },
          { id: 2, name: 'Science 201' },
        ])
      )
    );

    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText('2')).toBeInTheDocument();
    });
    expect(getByText(/my classes/i)).toBeInTheDocument();
  });

  it('shows loading state while classes load', async () => {
    server.use(
      http.get('*/api/teacher/classes', () =>
        new Promise((resolve) => setTimeout(() => resolve(HttpResponse.json([])), 150))
      )
    );

    const { getByText } = renderDashboard();
    expect(getByText(/loading/i)).toBeInTheDocument();
  });

  it('renders Upcoming Classes section', async () => {
    const { getByText } = renderDashboard();

    await waitFor(() => {
      expect(getByText(/upcoming classes/i)).toBeInTheDocument();
    });
  });

  it('renders page heading', async () => {
    const { getByRole } = renderDashboard();

    await waitFor(() => {
      expect(getByRole('heading', { level: 1 })).toBeInTheDocument();
    });
  });
});
