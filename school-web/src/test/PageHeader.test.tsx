import { describe, it, expect, vi } from 'vitest';
import { render } from '@testing-library/react';
import PageHeader from '@/components/ui/PageHeader';

describe('PageHeader', () => {
  it('renders page title', () => {
    const { getByText } = render(<PageHeader title="Students" />);
    expect(getByText('Students')).toBeInTheDocument();
  });

  it('renders subtitle when provided', () => {
    const { getByText } = render(<PageHeader title="Dashboard" subtitle="Overview of your school" />);
    expect(getByText('Overview of your school')).toBeInTheDocument();
  });

  it('renders icon when provided', () => {
    const { getByText } = render(<PageHeader title="Teachers" icon="👩‍🏫" />);
    expect(getByText('👩‍🏫')).toBeInTheDocument();
  });

  it('renders breadcrumbs when provided', () => {
    const breadcrumbs = [
      { label: 'Home', href: '/' },
      { label: 'Students', href: '/students' },
      { label: 'Grade A' },
    ];
    const { getByText } = render(<PageHeader title="Grade A" breadcrumbs={breadcrumbs} />);
    expect(getByText('Home')).toBeInTheDocument();
    expect(getByText('Students')).toBeInTheDocument();
    expect(getByText('Grade A', { selector: '.text-xs' })).toBeInTheDocument();
  });

  it('renders action buttons when provided', () => {
    const { container } = render(
      <PageHeader
        title="Users"
        actions={<button data-testid="add-btn">Add User</button>}
      />
    );
    expect(container.querySelector('[data-testid="add-btn"]')).toBeInTheDocument();
  });
});