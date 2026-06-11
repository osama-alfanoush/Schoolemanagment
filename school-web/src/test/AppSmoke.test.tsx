import { describe, it, expect, beforeEach } from 'vitest';
import { render } from '@testing-library/react';
import App from '@/App';

describe('App', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('renders without crashing', () => {
    const { container } = render(<App />);
    expect(container.querySelector('[role="alert"]')).not.toBeInTheDocument();
  });
});
