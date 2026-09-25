# Security Exceptions Register

## EX-2026-001: Expo 54 moderate build-tool advisories

- Status: Pending security-owner approval; production gate remains closed until approved or remediated.
- Opened: 2026-07-16
- Expires: 2026-08-15
- Owner role: Mobile platform owner
- Packages: transitive `postcss` and `uuid` through Expo configuration/build tooling
- Severity: Moderate; `npm audit --audit-level=high` passes.
- Runtime assessment: The vulnerable paths are used by local/CI build configuration and Xcode project tooling. The application does not accept untrusted CSS or UUID output buffers at runtime. This is an inference that must be confirmed by the security owner.
- Compensating controls: trusted CI inputs, protected release branches, no untrusted Expo config plugins, high/critical audit gate, generated artifacts scanned before release.
- Remediation: rehearse Expo 57 in a branch, upgrade the matching React Native/Expo package set, run native build and device regression suites, then remove this exception.
- Approval evidence: Not yet supplied.

## EX-2026-002: Demo stack database password flagged by the secret scan

- Status: Pending security-owner approval.
- Opened: 2026-09-25
- Expires: Not time-boxed. It is a false positive, not a deferred fix. Revisit if `docker-compose.demo.yml` ever carries a real credential.
- Owner role: Platform owner
- Finding: TruffleHog's Postgres detector matches the `DB_URL` connection string in `docker-compose.demo.yml` (introduced in `0c988b0`), whose password is the literal `demo-not-a-secret`. It reports it as unknown, not verified, because the database host only resolves inside the compose network. The string is deliberately not quoted here: quoting it would recreate the finding in this file.
- Assessment: The password is the local demo stack's throwaway value, named as not a secret. The demo `postgres` service publishes no ports, so the credential is only usable inside that compose network. The finding is in branch history, so changing the file would not clear it.
- Control: The one file is excluded through `.github/trufflehog-exclude-paths.txt`. Every other path, and every other detector, is still scanned.
- Residual risk: A real credential added to `docker-compose.demo.yml` later would not be caught. Moving the demo password to `${DEMO_DB_PASSWORD}`, the way `APP_KEY` already is, and then dropping this exclusion would close that.
- Approval evidence: Not yet supplied.

## EX-2026-003: A file hash in the old graphify cache flagged as a Sentry token

- Status: Pending security-owner approval.
- Opened: 2026-09-25
- Expires: Not time-boxed. It is a false positive in a generated directory that is no longer tracked.
- Owner role: Platform owner
- Finding: TruffleHog's SentryToken detector matches a 64-character hex value in `graphify-out/cache/stat-index.json` (commit `93dc123c`). The value is the SHA-256 of `laravel-api/config/sentry.php`, stored under a key containing the word "sentry", and that key is what trips the detector.
- Why it fails intermittently: the detector tries to verify the value against Sentry's API. A definitive "invalid" filters it out, but an error response counts as unknown, which fails the job. It passed on some runs of this branch and failed on others with no code change.
- Control: `graphify-out/` is excluded through `.github/trufflehog-exclude-paths.txt`. The directory is generated knowledge-graph output, gitignored and removed from the tree since `d0b3786`, so it exists only in history.
- Residual risk: a file force-added under `graphify-out/` would not be scanned.
- Approval evidence: Not yet supplied.

