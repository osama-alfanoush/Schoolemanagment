import { describe, it, expect } from 'vitest';
import { render } from '@testing-library/react';
import NotFound from '@/pages/not-found';

describe('NotFound', () => {
  it('renders 404 page not found heading', () => {
    const { getByText } = render(<NotFound />);
    expect(getByText('404 Page Not Found')).toBeInTheDocument();
  });

  it('renders descriptive message', () => {
    const { getByText } = render(<NotFound />);
    expect(getByText(/Did you forget to add the page to the router?/i)).toBeInTheDocument();
  });

  it('renders AlertCircle icon', () => {
    const { container } = render(<NotFound />);
    const alertIcon = container.querySelector('svg');
    expect(alertIcon).toBeInTheDocument();
  });
});