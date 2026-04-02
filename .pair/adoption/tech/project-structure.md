# Project Structure

## Monorepo Layout

```
learnn/
├── apps/                         # Client applications (deployable)
│   ├── web/                      # Web platform (React 17 + Vite) → [.pair](../../../apps/web/.pair/.pair.README.md)
│   │   ├── app/                  # Frontend source (pnpm workspace: apps/web/app)
│   │   │   └── src/
│   │   │       ├── screens/      # Page-level components (route targets)
│   │   │       ├── components/   # Reusable UI components
│   │   │       ├── controllers/  # Business logic controllers
│   │   │       ├── layouts/      # Page layout wrappers
│   │   │       ├── core/         # Core app configuration and providers
│   │   │       ├── data/         # Static data and constants
│   │   │       ├── analytics/    # Analytics integration
│   │   │       ├── styles/       # Global styles (SASS/CSS Modules)
│   │   │       ├── types/        # TypeScript type definitions
│   │   │       └── utils/        # Utility functions
│   │   ├── lib/                  # CDK stack (infrastructure as code)
│   │   ├── cypress/              # E2E tests (Cypress)
│   │   └── pipeline.yml          # Azure Pipelines CI/CD
│   ├── mobile/                   # Mobile apps (React Native 0.74.5, Yarn workspace) → [.pair](../../../apps/mobile/.pair/.pair.README.md)
│   │   ├── screens/              # Screen components
│   │   ├── components/           # Reusable components
│   │   ├── controllers/          # Business logic
│   │   ├── contexts/             # React Context providers
│   │   ├── hooks/                # Custom hooks
│   │   ├── navigators/           # React Navigation config
│   │   ├── styles/               # Shared styles
│   │   ├── types/                # TypeScript types
│   │   └── utils/                # Utilities
│   ├── extension/                # Browser extension (Vite + React 18 + Tailwind) → [.pair](../../../apps/extension/.pair/.pair.README.md)
│   │   └── src/
│   │       ├── pages/            # Extension pages (popup, sidepanel, options)
│   │       ├── components/       # Reusable components
│   │       ├── context/          # React Context providers
│   │       ├── services/         # Extension services and API calls
│   │       ├── types/            # TypeScript types
│   │       └── utils/            # Utilities
│   └── docs/                     # Documentation site (VitePress) → [.pair](../../../apps/docs/.pair/.pair.README.md)
│
├── services/                     # Backend microservices (AWS Lambda + CDK) → [.pair](../../../services/.pair/.pair.README.md)
│   ├── identity/                 # Auth & authorization (Keycloak) → [.pair](../../../services/identity/.pair/.pair.README.md)
│   ├── checkout/                 # Payment processing → [.pair](../../../services/checkout/.pair/.pair.README.md)
│   ├── billing/                  # Subscription management (Stripe) → [.pair](../../../services/billing/.pair/.pair.README.md)
│   ├── my/                       # User dashboard & personal data → [.pair](../../../services/my/.pair/.pair.README.md)
│   ├── engagement/               # Activity tracking & analytics → [.pair](../../../services/engagement/.pair/.pair.README.md)
│   ├── webhooks/                 # External integrations & event handling → [.pair](../../../services/webhooks/.pair/.pair.README.md)
│   ├── vod/                      # Video-on-demand & DRM → [.pair](../../../services/vod/.pair/.pair.README.md)
│   ├── assistant/                # AI assistant (Learnn AI) → [.pair](../../../services/assistant/.pair/.pair.README.md)
│   ├── user-content/             # User-generated content → [.pair](../../../services/user-content/.pair/.pair.README.md)
│   ├── quiz/                     # Assessments & certifications → [.pair](../../../services/quiz/.pair/.pair.README.md)
│   ├── recommender/              # Recommendations (AWS Personalize) → [.pair](../../../services/recommender/.pair/.pair.README.md)
│   ├── profile/                  # User profile management → [.pair](../../../services/profile/.pair/.pair.README.md)
│   ├── expert/                   # Instructor management → [.pair](../../../services/expert/.pair/.pair.README.md)
│   ├── uptime/                   # Health monitoring → [.pair](../../../services/uptime/.pair/.pair.README.md)
│   ├── cms-v4/                   # Headless CMS (Strapi v4.12.4) → [.pair](../../../services/cms-v4/.pair/.pair.README.md)
│   ├── community/                # Community features
│   ├── search/                   # Search functionality → [.pair](../../../services/search/.pair/.pair.README.md)
│   ├── growth/                   # Growth & analytics backend
│   └── cms/                      # Legacy CMS (Strapi v3, deprecated)
│
├── packages/                     # Shared internal libraries → [.pair](../../../packages/.pair/.pair.README.md)
│   ├── sdk/                      # @learnn/sdk - GraphQL client, business logic, Apollo → [.pair](../../../packages/sdk/.pair/.pair.README.md)
│   ├── analytics/                # @learnn/analytics - PostHog, Mixpanel, Firebase → [.pair](../../../packages/analytics/.pair/.pair.README.md)
│   ├── utils-be/                 # @learnn/utils-be - Backend utilities, AWS SDK clients → [.pair](../../../packages/utils-be/.pair/.pair.README.md)
│   ├── cdk/                      # @learnn/cdk - AWS CDK shared constructs
│   ├── eslint-config/            # @learnn/eslint-config - Shared ESLint rules
│   └── e2e/                      # @learnn/e2e - End-to-end tests (Playwright)
│
├── infra/                        # Shared infrastructure stacks (CDK)
│   ├── vpc/                      # VPC networking configuration
│   ├── agent/                    # CI/CD agent pool setup
│   └── turborepo/                # Turbo remote cache infrastructure
│
└── tools/                        # Utility scripts & migration tools
    ├── first-promoter-*/         # Referral program management
    ├── clean-fatture-in-cloud*/  # Invoice cleanup
    ├── migrate-*/                # Data migration scripts
    └── ...                       # 40+ one-off utility scripts
```

## Service Internal Structure (Standard Pattern)

```
services/<service-name>/
├── src/
│   ├── handlers/                 # Lambda handler functions (entry points)
│   ├── services/                 # Business logic layer
│   └── layers/
│       └── common/nodejs/        # Shared Lambda layer (dependencies)
│           └── package.json      # Layer-specific dependencies
├── __tests__/                    # Unit and integration tests (Jest)
├── lib/                          # CDK stack definition (infrastructure)
├── bin/                          # CDK app entry point
├── pipeline.yml                  # Azure Pipelines CI/CD config
├── config.yaml                   # Service configuration
├── cdk.json                      # CDK configuration
├── jest.config.js                # Test configuration
├── tsconfig.json                 # TypeScript configuration
└── package.json                  # Service dependencies
```

## Workspace Configuration

- **Root**: pnpm v9.14.4 + Turborepo v2.4.1
- **pnpm workspaces**: `apps/web`, `apps/web/app`, `apps/extension`, `apps/docs`, `infra/*`, `packages/*`, `services/*`, selected `tools/*`
- **Exception**: `apps/mobile` uses Yarn v3.6.4 (React Native compatibility), not managed by pnpm
- **External package**: `@learnn/designn` (design system) is published as npm module from a separate repository, not in this monorepo

---

All project structure decisions must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
