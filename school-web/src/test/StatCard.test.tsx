import { describe, it, expect } from 'vitest';
import { render } from '@testing-library/react';
import StatCard from '@/components/ui/StatCard';
import { Users } from 'lucide-react';

describe('StatCard', () => {
  it('renders title and value', () => {
    const { getByText } = render(
      <StatCard title="Total Students" value={150} icon={<Users />} gradient="purple" />
    );
    expect(getByText('Total Students')).toBeInTheDocument();
    expect(getByText('150')).toBeInTheDocument();
  });

  it('renders subtitle when provided', () => {
    const { getByText } = render(
      <StatCard
        title="Revenue"
        value={5000}
        subtitle="This month"
        icon={<Users />}
        gradient="mint"
      />
    );
    expect(getByText('This month')).toBeInTheDocument();
  });

  it('renders trend badge when provided', () => {
    const { getByText } = render(
      <StatCard
        title="Enrolled"
        value={100}
        trend={{ value: 12, label: 'vs last month', up: true }}
        icon={<Users />}
        gradient="sky"
      />
    );
    expect(getByText('12%')).toBeInTheDocument();
    expect(getByText('vs last month')).toBeInTheDocument();
  });

  it('renders icon element', () => {
    const { container } = render(
      <StatCard title="Teachers" value={25} icon={<Users data-testid="users-icon" />} gradient="pink" />
    );
    expect(container.querySelector('[data-testid="users-icon"]')).toBeInTheDocument();
  });

  it('renders numeric string values', () => {
    const { getByText } = render(
      <StatCard title="Count" value="250" icon={<Users />} gradient="purple" />
    );
    expect(getByText('250')).toBeInTheDocument();
  });
});