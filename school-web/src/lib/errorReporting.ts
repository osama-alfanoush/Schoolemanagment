/**
 * Frontend error reporting.
 *
 * Deliberately provider-agnostic and off by default, mirroring the backend:
 * there is no error-reporting account yet, and committing a DSN or leaving a
 * dead integration would both be worse than a small amount of glue. Pointing
 * this at Sentry later is a URL and nothing else.
 *
 * Every event carries the same three fields the backend attaches, so a browser
 * error and the API error it caused can be joined:
 *
 *   environment  which deployment this came from
 *   release      the exact commit
 *   requestId    the correlation id the API echoed on the failing response
 *
 * What it must never carry: a pupil's name, an email address, a token, a
 * cookie or anything from a form field. The browser has all of those to hand,
 * which is exactly why the payload is built from an allow-list rather than by
 * serialising whatever is available.
 */

const ENDPOINT: string = import.meta.env.VITE_ERROR_REPORTING_DSN || "";
const ENABLED: boolean =
  String(import.meta.env.VITE_ERROR_REPORTING_ENABLED || "") === "true" &&
  ENDPOINT !== "";

const ENVIRONMENT: string = import.meta.env.VITE_APP_ENV || "unknown";
const RELEASE: string = import.meta.env.VITE_APP_RELEASE || "unknown";

/** Patterns that identify a credential wherever it appears in free text. */
const SENSITIVE_PATTERNS: RegExp[] = [
  /\b[A-Za-z0-9_-]*sk_(?:live|test)_[A-Za-z0-9]{8,}/g,
  /\bwhsec_[A-Za-z0-9]{8,}/g,
  /\bBearer\s+[A-Za-z0-9._~+/-]{10,}=*/gi,
  /\b\d{1,4}\|[A-Za-z0-9]{32,}\b/g,
  /\bey[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}/g,
  /\b(?:\d[ -]*?){13,19}\b/g,
  /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}/g,
];

export function scrub(text: string): string {
  return SENSITIVE_PATTERNS.reduce(
    (acc, pattern) => acc.replace(pattern, "[REDACTED]"),
    text,
  );
}

/**
 * A URL keeps its path — that is what makes a report useful — and loses its
 * query string entirely, because the query is where identifiers and tokens end
 * up and no frontend query parameter is worth the risk.
 */
export function scrubUrl(raw: string): string {
  try {
    const url = new URL(raw, window.location.origin);
    return `${url.origin}${url.pathname}`;
  } catch {
    return "[unparseable-url]";
  }
}

export interface ErrorEvent {
  environment: string;
  release: string;
  timestamp: string;
  level: "error";
  exception: { type: string; value: string; stack?: string };
  request: { url: string; requestId?: string };
}

export function buildEvent(error: unknown, requestId?: string): ErrorEvent {
  const err = error instanceof Error ? error : new Error(String(error));

  return {
    environment: ENVIRONMENT,
    release: RELEASE,
    timestamp: new Date().toISOString(),
    level: "error",
    exception: {
      type: err.name,
      value: scrub(err.message),
      // A stack trace can embed a URL with a query string, so it is scrubbed
      // and truncated rather than sent whole.
      stack: err.stack ? scrub(err.stack).slice(0, 4000) : undefined,
    },
    request: {
      url: scrubUrl(window.location.href),
      requestId,
    },
  };
}

/**
 * Report an error. Never throws and never blocks: a failure here must not
 * become a second, louder failure in front of the user.
 */
export function reportError(error: unknown, requestId?: string): void {
  const event = buildEvent(error, requestId);

  if (!ENABLED) {
    // No provider configured. Keep it in the console so it is still visible
    // during development and in a browser session someone is watching.
    if (import.meta.env.DEV) {
      console.error("[error-event]", event);
    }
    return;
  }

  try {
    const body = JSON.stringify(event);

    // sendBeacon survives the page being closed, which is exactly when the
    // interesting errors happen. Falls back to a non-blocking fetch.
    if (typeof navigator !== "undefined" && navigator.sendBeacon) {
      navigator.sendBeacon(ENDPOINT, body);
      return;
    }

    void fetch(ENDPOINT, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body,
      keepalive: true,
      // Never attach cookies to a third-party collector.
      credentials: "omit",
    }).catch(() => undefined);
  } catch {
    // Reporting is best effort by definition.
  }
}

/**
 * Install global handlers. Call once at application start.
 */
export function installErrorReporting(): void {
  if (typeof window === "undefined") return;

  window.addEventListener("error", (event) => {
    reportError(event.error ?? event.message);
  });

  window.addEventListener("unhandledrejection", (event) => {
    reportError(event.reason);
  });
}
