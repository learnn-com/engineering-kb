# UX/UI

> App-specific UX/UI patterns live in the local `.pair` context of each app. This file covers shared/cross-platform guidelines only.

## App-Specific UX/UI

| App | Local context |
|-----|---------------|
| Web App | [`apps/web/.pair — ux-ui.md`](../../../apps/web/.pair/.pair.ux-ui.md) |
| Mobile Apps | [`apps/mobile/.pair — ux-ui.md`](../../../apps/mobile/.pair/.pair.ux-ui.md) |
| Browser Extension | [`apps/extension/.pair — ux-ui.md`](../../../apps/extension/.pair/.pair.ux-ui.md) |

## Design System

- **@learnn/designn** is adopted as the custom design system for shared components.
- `@learnn/designn` v0.2.42 is installed as an external npm module from a separate repository.
- Design system ensures visual consistency across web app and extension.
- Design system is maintained separately and versioned independently.

## Accessibility

- Basic accessibility practices are followed (semantic HTML, alt text for images).
- Keyboard navigation is supported in web app and extension.
- Color contrast meets WCAG 2.1 AA standards for readability.
- WCAG 2.1 AAA compliance is a long-term goal.

## Content Management

- Content is managed via **Strapi v4** headless CMS.
- Content editors use Strapi admin panel for course creation, updates, and publishing.
- Content is delivered via GraphQL queries (Apollo Client) and REST APIs.
- Rich text content is rendered using Markdown with custom renderers.

## Internationalization (i18n)

- Application is primarily in **Italian** (target audience: Italian market).
- Multi-language support is not currently adopted.

## User Feedback & Interaction

- User-friendly error messages are displayed for all failure scenarios.
- Error boundaries catch React errors and display fallback UI.
- **Sentry** captures errors for developer investigation.
- Skeleton loaders are used during data fetching.
- Optimistic UI updates improve perceived performance.

## Analytics & User Tracking

- **PostHog** tracks user interactions and feature usage (web, extension).
- **Mixpanel** and **Firebase Analytics** track mobile app behaviour.
- User consent is obtained before tracking (GDPR compliance).

## Performance Optimization

- **Code splitting** reduces initial bundle size (Vite for web, Metro for mobile).
- **Lazy loading** defers non-critical components and images.
- **Caching strategies** minimise network requests (Apollo Client, CloudFront CDN).

## Design Workflow

- Design system components (`@learnn/designn`) are versioned and released independently.
- Visual regression testing is performed via **Cypress** (web app, `apps/web/cypress/`).
- E2E functional testing is performed via **Playwright** (`packages/e2e`).

---

All user interface implementations must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
