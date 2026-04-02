# Architecture

## System Design

- Learnn adopts a **microservices architecture** with 15 independent services deployed on AWS.
- Each service owns its domain logic, data, and deployment lifecycle.
- Services communicate via REST APIs, GraphQL (Apollo Client), and event-driven webhooks.
- Architecture supports three client applications: web platform (desktop-first), mobile apps (iOS/Android), and browser extension.

## Microservices (15 Services)
[`.pair` context](../../../services/.pair/.pair.README.md)

1. **identity** - Authentication and authorization via Keycloak (OAuth 2.0/OIDC) → [`.pair` context](../../../services/identity/.pair/.pair.README.md)
2. **checkout** - Purchase flow and payment processing → [`.pair` context](../../../services/checkout/.pair/.pair.README.md)
3. **billing** - Subscription management (Stripe) → [`.pair` context](../../../services/billing/.pair/.pair.README.md)
4. **my** - User dashboard and personal data → [`.pair` context](../../../services/my/.pair/.pair.README.md)
5. **engagement** - User activity tracking and analytics → [`.pair` context](../../../services/engagement/.pair/.pair.README.md)
6. **webhooks** - External integrations and event handling → [`.pair` context](../../../services/webhooks/.pair/.pair.README.md)
7. **vod** - Video-on-demand streaming with DRM → [`.pair` context](../../../services/vod/.pair/.pair.README.md)
8. **assistant** - AI-powered learning assistant (Learnn AI) → [`.pair` context](../../../services/assistant/.pair/.pair.README.md)
9. **user-content** - User-generated content management → [`.pair` context](../../../services/user-content/.pair/.pair.README.md)
10. **quiz** - Assessments, certifications, and skill verification → [`.pair` context](../../../services/quiz/.pair/.pair.README.md)
11. **recommender** - Personalized recommendations (AWS Personalize) → [`.pair` context](../../../services/recommender/.pair/.pair.README.md)
12. **profile** - User profile management → [`.pair` context](../../../services/profile/.pair/.pair.README.md)
13. **expert** - Expert and instructor management → [`.pair` context](../../../services/expert/.pair/.pair.README.md)
14. **uptime** - System monitoring and health checks → [`.pair` context](../../../services/uptime/.pair/.pair.README.md)
15. **cms-v4** - Headless CMS (Strapi v4.12.4) for content management → [`.pair` context](../../../services/cms-v4/.pair/.pair.README.md)

## Client Applications

- **Web App**: React 17 + Vite, desktop-first responsive design → [`.pair` context](../../../apps/web/.pair/.pair.README.md)
- **Mobile Apps**: React Native 0.74.5, iOS and Android native apps with offline support → [`.pair` context](../../../apps/mobile/.pair/.pair.README.md)
- **Browser Extension**: Vite + React 18, Chrome/Firefox support → [`.pair` context](../../../apps/extension/.pair/.pair.README.md)
- **Docs Site**: VitePress internal documentation → [`.pair` context](../../../apps/docs/.pair/.pair.README.md)

## Shared Libraries

- `@learnn/sdk` - Shared business logic, GraphQL client (Apollo), domain models → [`.pair` context](../../../packages/sdk/.pair/.pair.README.md)
- `@learnn/analytics` - Analytics abstraction (PostHog, Mixpanel, Firebase) → [`.pair` context](../../../packages/analytics/.pair/.pair.README.md)
- `@learnn/utils-be` - Backend utilities and common functions → [`.pair` context](../../../packages/utils-be/.pair/.pair.README.md)
- `@learnn/cdk` - AWS CDK shared constructs for infrastructure
- `@learnn/designn` - Design system components, available on a separate repository (not in the current monorepo)

## Communication Patterns

### Client-to-Backend
- **REST APIs**: CRUD operations, synchronous requests
- **GraphQL**: Complex queries, real-time data fetching via Apollo Client 3.9.4
- **WebSockets**: Real-time updates (where applicable)

For implementation patterns (Lambda structure, fp-ts, TaskEither): → [`coding-patterns.md`](coding-patterns.md)
For infrastructure details (databases, service-to-service messaging, deployment, security, monitoring): → [`infrastructure.md`](infrastructure.md)

## Architecture Evolution

- Learnn evolved from a monolith to microservices architecture
- CMS migrated from Strapi v3 to v4 (current: cms-v4 service)
- Ongoing migration to serverless-first approach for new services
- Mobile apps support offline-first architecture with local cache (Apollo cache persist)

---

All architectural implementations must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
