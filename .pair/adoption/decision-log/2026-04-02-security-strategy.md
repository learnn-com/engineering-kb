# Decision: Security Strategy — Full Project Assessment

## Date

2026-04-02

## Status

Active

## Category

Convention Adoption

## Context

The project (`my.learnn.com`, React Native mobile app, backend microservices on AWS Lambda/ECS) had no formal security posture documented. A security audit (2025-Q1) scored the webapp at 52/100 and WordPress at 12/100. Security controls were being applied inconsistently across packages. A structured adoption was needed to ensure consistent enforcement across web, mobile, and services, and to track open vulnerabilities explicitly.

## Decision

Adopt a multi-layer security strategy with:

1. **Global principles** (cross-cutting, defined in `adoption/tech/security.md`):
   - Defense in Depth across CDN, API Gateway, service, and data layers.
   - Zero secrets in code — all secrets via AWS Secrets Manager or env vars.
   - Least Privilege — each service/IAM role scoped to minimum required permissions.
   - Security by Design — adoption files consulted before implementing auth, data handling, or external integrations.

2. **WordPress-specific rules** (14 controls in `adoption/tech/security.md`):
   - `WP_DEBUG` disabled in production, XML-RPC disabled, SQL via `$wpdb->prepare()`, nonce for AJAX, ABSPATH guard, output escaping with `esc_*` helpers, `unserialize()` on remote data forbidden, secret rotation on exposure.

3. **Package-specific controls** (in each package's `.pair.security.md`):
   - `apps/web`: cookie auth server-side only, `target="_blank"` + `rel="noopener noreferrer"`, redirect allowlist, Markdown link protocol validation.
   - `apps/mobile`: `AsyncStorage` forbidden for tokens, `react-native-keychain` with `WHEN_UNLOCKED_THIS_DEVICE_ONLY`, `env.json` not committed, `Linking.openURL` hostname allowlist, console.log redaction before production.
   - `services`: JWT verification on every handler, explicit CORS allowlist, io-ts/Zod input validation, parameterized SQL/GraphQL, secrets from AWS Secrets Manager, PII redaction in logs, AI prompt injection prevention.

4. **Open vulnerabilities** tracked per package, not in global adoption:
   - Mobile P2: autologin token in URL query param (`?autologin=<token>`) — not planned for fix.
   - Mobile P2: Android Keychain not used (AsyncStorage fallback) — not planned for fix.

## Alternatives Considered

- **Single flat security document**: Not chosen — merges package-specific and global rules, making it harder to update and causing duplication as packages evolve.
- **Per-PR security review only**: Not chosen — no persistent baseline; gaps accumulate silently between reviews.

## Consequences

- Security adoption files must be read before implementing: auth flows, cookie handling, redirect logic, form inputs, database queries, external API integrations, infrastructure changes.
- All future package work must create/update the relevant `.pair.security.md` file when new controls are introduced or vulnerabilities are found.
- Open vulnerabilities in `apps/mobile` are tracked as accepted exceptions until explicitly resolved and removed.

## Adoption Impact

- `adoption/tech/security.md` — primary adoption file; written and active. Add reference to this ADL.
- `apps/web/.pair/.pair.security.md` — web-specific rules; written and active.
- `apps/mobile/.pair/.pair.security.md` — mobile-specific rules + exceptions; written and active.
- `services/.pair/.pair.security.md` — services-specific rules; written and active.
