import React from 'react';
import { render, RenderOptions } from '@testing-library/react';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

function createTestQueryClient() {
  return new QueryClient({
    defaultOptions: {
      queries: { retry: false, gcTime: 0, staleTime: 0 },
      mutations: { retry: false },
    },
  });
}

function AllProviders({ children }: { children: React.ReactNode }) {
  return React.createElement(
    QueryClientProvider,
    { client: createTestQueryClient() },
    children
  );
}

function renderWithProviders(
  ui: React.ReactElement,
  options?: Omit<RenderOptions, 'wrapper'>
) {
  return render(ui, {
    wrapper: (props: { children: React.ReactNode }) =>
      React.createElement(AllProviders, null, props.children),
    ...options,
  });
}

export { renderWithProviders, createTestQueryClient };