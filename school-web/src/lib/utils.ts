import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export async function downloadBlob(
  apiCall: Promise<unknown>,
  filename: string,
  onError?: (e: unknown) => void
) {
  try {
    const response = await apiCall;
    const blob = new Blob([response as BlobPart], { type: "application/pdf" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = filename;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  } catch (e) {
    onError?.(e);
  }
}

/**
 * An amount rounded to the cent, the scale the API stores.
 *
 * The raw result of float arithmetic is not a two-decimal number: 0.3 - 0.1
 * is 0.19999999999999998, and that is what JSON sends. The API refuses an
 * amount it cannot store rather than guessing which one was meant, so any
 * amount computed here is rounded before it is posted.
 */
export function roundToCents(amount: number): number {
  return Math.round(amount * 100) / 100
}
