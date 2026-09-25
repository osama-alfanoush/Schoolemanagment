import { describe, it, expect } from 'vitest';
import { roundToCents } from '@/lib/utils';

// What leaves the browser is JSON, and the API refuses any amount whose JSON
// carries more than two decimals. These assert on that text, not on equality.
const twoDecimals = /^-?\d+(\.\d{1,2})?$/;

describe('roundToCents', () => {
  it('turns float arithmetic noise back into the amount that was meant', () => {
    expect(0.3 - 0.1).not.toBe(0.2);
    expect(JSON.stringify(roundToCents(0.3 - 0.1))).toBe('0.2');
    expect(JSON.stringify(roundToCents(1000.1 - 0.2))).toBe('999.9');
  });

  it('never sends more than two decimals for an outstanding balance', () => {
    let noisy = 0;
    const refused: string[] = [];
    for (let amount = 0; amount <= 20000; amount += 37) {
      for (let paid = 0; paid <= amount; paid += 53) {
        const outstanding = amount / 100 - paid / 100;
        if (!twoDecimals.test(JSON.stringify(outstanding))) noisy++;
        const sent = JSON.stringify(roundToCents(outstanding));
        if (!twoDecimals.test(sent)) refused.push(sent);
      }
    }
    expect(refused).toEqual([]);
    // The sweep is only a test if the unrounded values were actually noisy.
    expect(noisy).toBeGreaterThan(1000);
  });

  it('leaves an amount that is already in cents alone', () => {
    expect(roundToCents(12.5)).toBe(12.5);
    expect(roundToCents(66.67)).toBe(66.67);
    expect(roundToCents(0)).toBe(0);
  });
});
