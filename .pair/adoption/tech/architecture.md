# Architecture

## System Design

- Learnn adopts a **microservices architecture** with 15 independent services deployed on AWS.
- Each service owns its domain logic, data, and deployment lifecycle.
- Services communicate via REST APIs, GraphQL (Apollo Client), and event-driven webhooks.
- Architecture supports three client applications: web platform (desktop-first), mobile apps (iOS/Android), and browser extension.

## Microservices (15 Services)

1. **identity** - Authentication and authorization via Keycloak (OAuth 2.0/OIDC)
2. **checkout** - Purchase flow and payment processing
3. **billing** - Subscription management (Stripe)
4. **my** - User dashboard and personal data
5. **engagement** - User activity tracking and analytics
6. **webhooks** - External integrations and event handling
7. **vod** - Video-on-demand streaming with DRM
8. **assistant** - AI-powered learning assistant (Learnn AI)
9. **user-content** - User-generated content management
10. **quiz** - Assessments, certifications, and skill verification
11. **recommender** - Personalized recommendations (AWS Personalize)
12. **profile** - User profile management
13. **expert** - Expert and instructor management
14. **uptime** - System monitoring and health checks
15. **cms-v4** - Headless CMS (Strapi v4.12.4) for content management

## Client Applications

- **Web App**: React 17 + Vite, desktop-first responsive design
- **Mobile Apps**: React Native 0.74.5, iOS and Android native apps with offline support
- **Browser Extension**: Vite + React 18 + Tailwind CSS 4, Chrome/Firefox support

## Shared Libraries

- `@learnn/sdk` - Shared business logic, GraphQL client (Apollo), domain models
- `@learnn/analytics` - Analytics abstraction (PostHog, Mixpanel, Firebase)
- `@learnn/utils-be` - Backend utilities and common functions
- `@learnn/cdk` - AWS CDK shared constructs for infrastructure
- `@learnn/designn` - Design system components (used in extension)

## Data Architecture

- **PostgreSQL (RDS)**: Strapi CMS content, relational data
- **DynamoDB**: High-performance NoSQL for services requiring low latency
- **Amazon S3**: Video assets, course materials, user uploads
- **CloudFront CDN**: Content delivery and caching
- Each microservice owns its database (no shared databases between services)

## Communication Patterns

### Client-to-Backend
- **REST APIs**: CRUD operations, synchronous requests
- **GraphQL**: Complex queries, real-time data fetching via Apollo Client 3.9.4
- **WebSockets**: Real-time updates (where applicable)

### Service-to-Service
- **Synchronous HTTP**: Direct calls for immediate responses
- **Event-Driven**: Webhooks for asynchronous communication
- **Amazon SQS**: Asynchronous message queuing between services
- **Amazon Kinesis**: Real-time event streaming (engagement events, lesson events)
- **AWS Step Functions**: Orchestration of complex multi-service workflows

## Deployment Model

- **Serverless-First**: AWS Lambda for stateless compute (most services)
- **Container-Based**: ECS Fargate for stateful services (e.g., identity backend cluster)
- **Infrastructure as Code**: AWS CDK (TypeScript) for all infrastructure
- **Region**: eu-south-1 (Milan) for GDPR compliance and low latency to Italian users

## Security & Compliance

- **Authentication**: Keycloak (OAuth 2.0, OpenID Connect)
- **Authorization**: JWT tokens, role-based access control (RBAC)
- **Encryption**: At-rest (S3, RDS) and in-transit (TLS/HTTPS)
- **Secrets Management**: AWS Secrets Manager / Systems Manager Parameter Store
- **GDPR Compliance**: Data residency in EU region, user data control

## Scalability Strategy

- **Horizontal Scaling**: Lambda auto-scaling, ECS task auto-scaling
- **Caching**: CloudFront CDN, Apollo Client cache, DynamoDB caching
- **Database Scaling**: RDS read replicas, DynamoDB on-demand scaling
- **Failure Isolation**: Service independence limits blast radius of failures

## Monitoring & Observability

- **Error Tracking**: Sentry 9.30.0 (web, extension)
- **Analytics**: PostHog 1.180.1 (web, extension), Mixpanel (mobile), Firebase Analytics (mobile)
- **Crashlytics**: Firebase Crashlytics (mobile apps)
- **Metrics**: AWS CloudWatch for infrastructure and application metrics
- **Logging**: CloudWatch Logs, structured logging in Lambda functions

## Architecture Evolution

- Learnn evolved from a monolith to microservices architecture
- CMS migrated from Strapi v3 to v4 (current: cms-v4 service)
- Ongoing migration to serverless-first approach for new services
- Mobile apps support offline-first architecture with local cache (Apollo cache persist)

---

All architectural implementations must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
