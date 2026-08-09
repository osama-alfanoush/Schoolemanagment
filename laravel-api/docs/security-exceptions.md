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

