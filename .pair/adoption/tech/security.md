# Security Adoption

> Based on security audit (2025-Q1). Scores: Webapp 52/100, WordPress 12/100.
> Guidelines reference: [`.pair/knowledge/guidelines/quality-assurance/security/`](../../knowledge/guidelines/quality-assurance/security/README.md)

## Security Principles

- **Defense in Depth** is adopted: multiple layers of controls across CDN, API gateway, service, and data layers.
- **Zero secrets in code** is adopted: all secrets must be stored in AWS Secrets Manager or injected as environment variables at runtime; hardcoded credentials are strictly forbidden.
- **Least Privilege** is adopted: each service and IAM role has only the permissions required for its function.
- **Security by Design** is adopted: security adoption files must be consulted before implementing authentication, authorization, data handling, or external integrations.

## WordPress-Specific

- **`WP_DEBUG` is disabled in production**: `WP_DEBUG = false`, `WP_DEBUG_LOG = false`.
- **`debug.log` must not be web-accessible**: blocked via `.htaccess` and removed from `wp-content/`.
- **XML-RPC is disabled**: `add_filter('xmlrpc_enabled', '__return_false')`.
- **WordPress core, Yoast SEO, and Elementor** must be kept at versions without known CVEs; updates required within 30 days of a critical CVE disclosure.
- **REST API user enumeration** must be blocked: `/wp/v2/users` must return 403 for unauthenticated requests.
- **`esc_html()`, `esc_attr()`, `esc_url()`, `esc_js()`** are adopted for all output in WordPress templates; direct `echo` of API/CMS data is forbidden.
- **PHP execution in `wp-content/uploads/`** must be blocked via `.htaccess`.
- **Staging/test pages** must not be deployed to production environments.
- **Parameterized queries (`$wpdb->prepare()`)** are adopted for all WordPress database access; string concatenation in SQL is forbidden.
- **WordPress nonce** is adopted for all AJAX endpoints (`wp_verify_nonce()` / `check_ajax_referer()`).
- **`ABSPATH` guard** is adopted in all PHP files: `if (!defined('ABSPATH')) exit;` as the first statement.
- **`unserialize()` on remote data is forbidden**: use `json_decode()` for all external API responses.
- **WordPress secrets** must be stored in `wp-config.php` as env-injected constants, not hardcoded values.
- **Secret rotation** is required whenever a secret is found in source code; follow [incident-response.md](../../knowledge/guidelines/quality-assurance/security/incident-response.md).

## Security Review Process

- Decision record: [`adoption/decision-log/*`](../decision-log/)
- Security adoption files must be read when implementing: authentication flows, cookie handling, redirect logic, form inputs, database queries, external API integrations, or infrastructure changes.
- App-specific security context: [`apps/web/.pair/.pair.security.md`](../../../apps/web/.pair/.pair.security.md)
- Mobile app security context: [`apps/mobile/.pair/.pair.security.md`](../../../apps/mobile/.pair/.pair.security.md)
- Services security context: [`services/.pair/.pair.security.md`](../../../services/.pair/.pair.security.md)
- Full guidelines: [`.pair/knowledge/guidelines/quality-assurance/security/README.md`](../../knowledge/guidelines/quality-assurance/security/README.md)
