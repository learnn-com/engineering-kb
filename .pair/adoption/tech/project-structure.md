# Project Structure

## Monorepo Layout

```
learnn/
├── apps/                         # Client applications (deployable)
│   ├── web/                      # Web platform (React 17 + Vite)
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
│   ├── mobile/                   # Mobile apps (React Native 0.74.5, Yarn workspace)
│   │   ├── screens/              # Screen components
│   │   ├── components/           # Reusable components
│   │   ├── controllers/          # Business logic
│   │   ├── contexts/             # React Context providers
│   │   ├── hooks/                # Custom hooks
│   │   ├── navigators/           # React Navigation config
│   │   ├── styles/               # Shared styles
│   │   ├── types/                # TypeScript types
│   │   └── utils/                # Utilities
│   ├── extension/                # Browser extension (Vite + React 18 + Tailwind)
│   │   └── src/
│   │       ├── pages/            # Extension pages (popup, sidepanel, options)
│   │       ├── components/       # Reusable components
│   │       ├── context/          # React Context providers
│   │       ├── services/         # Extension services and API calls
│   │       ├── types/            # TypeScript types
│   │       └── utils/            # Utilities
│   └── docs/                     # Documentation site (VitePress)
│
├── services/                     # Backend microservices (AWS Lambda + CDK)
│   ├── identity/                 # Auth & authorization (Keycloak)
│   ├── checkout/                 # Payment processing
│   ├── billing/                  # Subscription management (Stripe)
│   ├── my/                       # User dashboard & personal data
│   ├── engagement/               # Activity tracking & analytics
│   ├── webhooks/                 # External integrations & event handling
│   ├── vod/                      # Video-on-demand & DRM
│   ├── assistant/                # AI assistant (Learnn AI)
│   ├── user-content/             # User-generated content
│   ├── quiz/                     # Assessments & certifications
│   ├── recommender/              # Recommendations (AWS Personalize)
│   ├── profile/                  # User profile management
│   ├── expert/                   # Instructor management
│   ├── uptime/                   # Health monitoring
│   ├── cms-v4/                   # Headless CMS (Strapi v4.12.4)
│   ├── community/                # Community features
│   ├── search/                   # Search functionality
│   ├── growth/                   # Growth & analytics backend
│   └── cms/                      # Legacy CMS (Strapi v3, deprecated)
│
├── packages/                     # Shared internal libraries
│   ├── sdk/                      # @learnn/sdk - GraphQL client, business logic, Apollo
│   ├── analytics/                # @learnn/analytics - PostHog, Mixpanel, Firebase
│   ├── utils-be/                 # @learnn/utils-be - Backend utilities, AWS SDK clients
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
