import React from 'react';
import { render, RenderOptions } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Router } from 'wouter';
import { memoryLocation } from 'wouter/memory-location';
import { ThemeProvider } from '@/lib/ThemeContext';

function createTestQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

interface ProviderOptions extends Omit<RenderOptions, 'wrapper'> {
  /** Initial route for the in-memory router (e.g. '/login'). */
  initialRoute?: string;
}

function renderWithProviders(ui: React.ReactElement, options?: ProviderOptions) {
  const { initialRoute = '/', ...renderOptions } = options ?? {};
  const { hook } = memoryLocation({ path: initialRoute });

  function AllProviders({ children }: { children: React.ReactNode }) {
    return (
      <QueryClientProvider client={createTestQueryClient()}>
        <ThemeProvider>
          <Router hook={hook}>{children}</Router>
        </ThemeProvider>
      </QueryClientProvider>
    );
  }

  return render(ui, { wrapper: AllProviders, ...renderOptions });
}

export { renderWithProviders, createTestQueryClient };