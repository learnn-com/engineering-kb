# Tech Stack

## Core Languages

- **TypeScript** is adopted for all application logic (backend services, web app, extension).
  - TypeScript v4.x for backend services (v4.9.5)
  - TypeScript v5.x for web app and extension (v5.0.4, v5.8.2)
- **JavaScript** is adopted for React Native mobile apps (with TypeScript types).
- **Bash** is adopted for scripting, deployment automation, and CI/CD pipelines.

## Runtime & Platform

- **Node.js** v20.18.1 is adopted for all backend services and build processes.
- **React Native** v0.74.5 is adopted for iOS and Android mobile apps.
- **AWS Lambda** is adopted for serverless compute in backend microservices.
- **ECS Fargate** is adopted for containerized stateful services (identity backend cluster).

## Monorepo & Package Management

- **pnpm** v9.14.4 is adopted for workspace and dependency management.
- **Turborepo** v2.4.1 is adopted for monorepo task orchestration and caching.
- **Yarn** v3.6.4 is adopted exclusively for mobile app workspace (React Native compatibility).
- Use `pnpm` from repository root for all workspaces except `apps/mobile`.
- Use `turbo` for cross-workspace tasks (e.g. `turbo build`, `turbo test`, `turbo lint`).

## Frontend Frameworks & Libraries

### Web App
> See also: [`apps/web/.pair`](../../../apps/web/.pair/.pair.README.md) for web-specific patterns and structure.

- **React** v17.0.1 is adopted for web application.
- **Vite** v6.x is adopted as build tool and dev server.
- **React Router DOM** v5.2.0 is adopted for client-side routing.
- **Apollo Client** v3.9.4 is adopted for GraphQL client with cache management.
- **React Query** v3.39.1 is adopted for REST API data fetching and caching.
- **Formik** v2.2.0 + **Yup** are adopted for form management and validation.
- **react-player** v2.7.0 is adopted for video playback (web).
- **Orama** (@orama/core v1.2.16) is adopted for client-side search.
- **flowise-embed-react** v3.0.5 is adopted for embedded AI chat (Learnn AI).
- **FontAwesome** (@fortawesome/react-fontawesome v0.2.0) is adopted for icons.
- **react-helmet-async** v1.0.9 is adopted for SEO meta tag management.

### Mobile Apps
> See also: [`apps/mobile/.pair`](../../../apps/mobile/.pair/.pair.README.md) for mobile-specific patterns and structure.

- **React Native** v0.74.5 is adopted for cross-platform mobile development.
- **React Navigation** v6.x is adopted for navigation (Stack + Bottom Tabs).
- **React Native Reanimated** v3.15.3 is adopted for animations.
- **React Native Video** v6.16.1 is adopted for video playback with DRM support.

### Browser Extension
> See also: [`apps/extension/.pair`](../../../apps/extension/.pair/.pair.README.md) for extension-specific patterns and structure.

- **Vite** v6.1.0 is adopted for extension build and bundling.
- **@crxjs/vite-plugin** v2.0.0-beta.32 is adopted for Chrome extension development.
- **React** v18.2.0 is adopted for extension UI.

## Backend Frameworks & APIs

- **Strapi** v4.12.4 is adopted as headless CMS framework.
- **GraphQL** is adopted for complex client queries via Apollo Server.
- **REST APIs** are adopted for CRUD operations in microservices.
- **AWS SDK** is adopted for all AWS service integrations.
- **AWS CDK** (TypeScript) is adopted for infrastructure as code.

## Databases & Storage

- **PostgreSQL** v8.11.2 (via `pg` driver) is adopted for Strapi CMS and relational data.
- **DynamoDB** is adopted for high-performance NoSQL storage in microservices.
- **Amazon S3** is adopted for object storage (videos, assets, user uploads).
- **Apollo Client Cache** is adopted for client-side caching (web, mobile).
- **apollo3-cache-persist** v0.14.1 is adopted for offline-first mobile architecture.

## Authentication & Authorization

- **Keycloak** v24.0.3 (via `keycloak-js`) is adopted for authentication (OAuth 2.0 / OIDC).
- **JWT** (`jsonwebtoken` v9.0.1, `jose` v6.0.7) is adopted for token management.
- **AWS Cognito** may be used for additional identity workflows (check services for usage).

## Payment & Billing

- **Stripe** is adopted for payment processing.
- **Fatture in Cloud** (`@fattureincloud/fattureincloud-ts-sdk` v2.0.7) is adopted for Italian invoicing.

## Testing

### Backend Services
- **Jest** v29.x is adopted for unit and integration testing.
- **jest-extended** v1.2.0 is adopted for additional matchers.
- **ts-jest** v29.0.3 is adopted for TypeScript test execution.

### Web App
- **Jest** v29.x is adopted for unit testing.
- **Cypress** v13.13.1 is adopted for visual regression testing (via `apps/web/cypress/`).
- **@frsource/cypress-plugin-visual-regression-diff** v3.3.10 is adopted for visual regression diffing.
- **@testing-library/react** v9.5.0 is adopted for component testing.

### E2E (Cross-App)
- **Playwright** v1.48.0 is adopted for E2E functional testing (`packages/e2e`).

### Mobile Apps
- **Jest** v29.6.3 is adopted for unit testing.
- Manual QA is performed for E2E testing on physical devices.

## Styling & Design

### Web App
- **CSS Modules** are adopted as primary component styling approach.
- **SASS/SCSS** (node-sass v8.0.0) is adopted for stylesheet preprocessing.
- **Bootstrap** v4.5.3 + **React Bootstrap** v1.6.7 are present for legacy components (not for new development).
- **@learnn/designn** (custom design system) is adopted for shared components.

### Mobile Apps
- Native styling via React Native StyleSheet.
- **react-native-linear-gradient** v2.6.2 is adopted for gradients.

### Browser Extension
- **Tailwind CSS** v4.1.2 is adopted for utility-first styling.
- **@tailwindcss/vite** v4.0.17 is adopted for Vite integration.
- **@learnn/designn** v0.2.42 is adopted for design system components.

## State Management

- **Apollo Client** v3.9.4 is adopted for GraphQL state (cache-first).
- **React Query** v3.39.1 is adopted for REST API state management.
- **RxJS** v7.8.0 is adopted for reactive programming patterns in SDK.

## Functional Programming

- **fp-ts** v2.16.9 is adopted for functional programming utilities (Either, Option, Task).
- **io-ts** v2.2.16 is adopted for runtime type validation.
- **io-ts-types** v0.5.16 is adopted for additional io-ts codecs.

## Monitoring & Analytics

- **Sentry** v9.30.0 is adopted for error tracking (web app, extension).
- **PostHog** v1.180.1 (web), v1.261.0 (extension) is adopted for product analytics.
- **Google Analytics** (react-ga v3.3.1) is adopted for web analytics.
- **Google Tag Manager** (react-gtm-consent-module v1.0.1) is adopted for consent-based tag management (web).
- **Mixpanel** v3.0.6 is adopted for mobile app analytics (React Native).
- **Firebase Analytics** v18.7.1 is adopted for mobile app analytics (React Native).
- **Firebase Crashlytics** v18.7.1 is adopted for mobile crash reporting.

## Push Notifications & Messaging

- **OneSignal** v4.5.3 is adopted for push notifications (mobile apps).
- **Amazon SES** is adopted for transactional email (via Strapi provider).

## Video & Media

- **AWS MediaConvert / Elemental** (assumed) is adopted for video processing.
- **React Native Video** v6.16.1 is adopted for mobile video playback.
- **DRM** is implemented for video content protection (vod service).

## AI & Machine Learning

- **AWS Personalize** is adopted for content recommendations (recommender service).
- **Custom AI Assistant** (Learnn AI) is implemented in assistant service.
- **Flowise** is adopted as AI orchestration layer for chat flows and embeddings.

## CRM & Marketing Integrations

- **ActiveCampaign** v1.2.5 is adopted for CRM and email marketing automation.
- **First Promoter** is adopted for referral and ambassador program management.

## Linting & Formatting

- **ESLint** is adopted for linting:
  - `@learnn/eslint-config` (workspace shared config)
  - `@typescript-eslint/parser` v5.x-v6.x
  - `eslint` v8.19.0+
- **Prettier** v2.x-v3.x is adopted for code formatting:
  - `@learnn/nn-config-prettier` (workspace shared config)
- Configuration must be used via workspace packages (not installed directly in apps).

## Git Hooks

- **Husky** v9.1.7 is adopted for Git hooks.
- **lint-staged** v15.2.2 is adopted for pre-commit linting.
- Pre-commit: `prettier:fix` runs automatically.
- Pre-push: `turbo build` + `turbo test` (excluding e2e) runs automatically.

## Build & Bundling

### Backend Services
- **TypeScript Compiler** (`tsc`) is adopted for transpilation.
- **esbuild** v0.24.0 is adopted for fast bundling in some services.
- AWS CDK handles Lambda bundling automatically.

### Web App
- **Vite** is adopted for build and dev server.

### Mobile Apps
- **Metro** v0.74.87 is adopted as React Native bundler.
- **@rnx-kit/metro-config** v1.3.3 is adopted for enhanced Metro configuration.

### Browser Extension
- **Vite** v6.1.0 + **@crxjs/vite-plugin** v2.0.0-beta.32 is adopted for extension bundling.

## Infrastructure as Code

- **AWS CDK** (TypeScript) is adopted for all infrastructure definitions.
- **aws-cdk-lib** v2.171.1 is adopted as CDK library version.
- All services use CDK for deployment (Lambda, ECS, RDS, S3, CloudFront, etc.).

## Shared Packages (Internal)

- `@learnn/sdk` - Shared SDK (GraphQL client, business logic, Apollo setup) → [`.pair` context](../../../packages/sdk/.pair/.pair.README.md)
- `@learnn/analytics` - Analytics wrapper (PostHog, Mixpanel, Firebase) → [`.pair` context](../../../packages/analytics/.pair/.pair.README.md)
- `@learnn/utils-be` - Backend utilities and common functions.
- `@learnn/cdk` - AWS CDK shared constructs and patterns.
- `@learnn/designn` - Design system components (web + extension).
- `@learnn/eslint-config` - Shared ESLint configuration.
- `@learnn/nn-config-prettier` - Shared Prettier configuration.
- `@learnn/nn-config-ts` - Shared TypeScript configuration.
- `@learnn/e2e` - End-to-end tests (Playwright).

## Additional Libraries

### Notable Dependencies
- **axios** v1.6.7 is adopted for HTTP requests (mobile, extension).
- **moment** v2.29.4 is adopted for date manipulation (legacy, consider migrating to date-fns).
- **lodash** v4.17.21 is adopted for utility functions.
- **uuid** v11.1.0 is adopted for UUID generation.
- **yargs** v17.7.2 is adopted for CLI argument parsing (backend scripts).

### Mobile-Specific
- **@react-native-firebase/app** v18.7.1 is adopted for Firebase integration.
- **react-native-keychain** v10.0.0 is adopted for secure storage.
- **react-native-fs** v2.20.0 is adopted for file system access.
- **react-native-gesture-handler** v2.19.0 is adopted for gesture handling.

### Web-Specific
- **react-device-detect** v2.2.3 is adopted for device detection.
- **html-entities** v2.4.0 is adopted for HTML entity encoding/decoding.

---

**Important Configuration Notes:**

- Prettier and ESLint must be used via workspace packages (`@learnn/nn-config-prettier`, `@learnn/eslint-config`).
- Do **not** install Prettier or ESLint directly in workspace apps; follow workspace tool configurations.
- Mobile workspace uses Yarn v3.6.4 due to React Native tooling requirements; all other workspaces use pnpm.

All technology choices must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
