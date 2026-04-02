# Infrastructure

## Cloud Provider

- **AWS (Amazon Web Services)** is adopted as the primary cloud provider.
- **Region**: eu-south-1 (Milan, Italy) is adopted for GDPR compliance and low latency to Italian users.
- Infrastructure is defined and managed via **AWS CDK** (TypeScript).

## Infrastructure as Code (IaC)

- **AWS CDK** (aws-cdk-lib v2.171.1) is adopted for all infrastructure definitions.
- Each microservice owns its CDK stack and deployment configuration.
- Shared CDK constructs are maintained in `@learnn/cdk` workspace package.
- CDK stacks are synthesized to CloudFormation templates before deployment.

## Compute

### Serverless (Primary)
- **AWS Lambda** is adopted for stateless compute in most microservices.
- Lambda functions are bundled automatically by AWS CDK.
- Layer pattern is used for shared dependencies (e.g., `src/layers/common/nodejs/`).

### Container-Based (Stateful Services)
- **ECS Fargate** is adopted for containerized stateful services.
- Identity service runs on ECS Fargate cluster (`learnn-staging-identity-app-cluster`).
- Auto-scaling policies are configured per service based on CPU/memory metrics.

## Databases & Storage

### Relational Database
- **Amazon RDS PostgreSQL** is adopted for Strapi CMS and relational data.
- Database version: PostgreSQL 8.11.2 (via `pg` npm driver).
- Automated backups and point-in-time recovery are enabled.

### NoSQL Database
- **Amazon DynamoDB** is adopted for high-performance key-value and document storage.
- On-demand billing mode is used for variable workloads.
- Each microservice owns its DynamoDB tables.

### Object Storage
- **Amazon S3** is adopted for video assets, course materials, and user uploads.
- S3 versioning is enabled for critical buckets.
- Lifecycle policies archive old content to S3 Glacier for cost optimization.

### CDN & Caching
- **Amazon CloudFront** is adopted for content delivery and edge caching.
- CloudFront distributions serve S3 content with low latency globally.
- Cache invalidation is automated via deployment pipelines.

## Orchestration & Workflow

- **AWS Step Functions** is adopted for multi-service workflow orchestration.
- Step Functions coordinate complex workflows (e.g., video processing pipelines).

## Authentication & Identity

- **Keycloak** is deployed on ECS Fargate for OAuth 2.0 / OpenID Connect authentication.
- JWT tokens are issued and validated by Keycloak.
- AWS Secrets Manager stores Keycloak admin credentials.

## API Management

- **AWS API Gateway** is adopted for REST API endpoints (where applicable).
- API Gateway handles request validation, rate limiting, and CORS.
- Lambda functions are integrated behind API Gateway.

## Secrets Management

- **AWS Secrets Manager** is adopted for sensitive credentials (database passwords, API keys).
- **AWS Systems Manager Parameter Store** is used for non-sensitive configuration values.
- Secrets are injected into Lambda/ECS tasks at runtime via environment variables.

## Monitoring & Observability

### Metrics & Logs
- **AWS CloudWatch** is adopted for infrastructure and application metrics.
- **CloudWatch Logs** aggregates logs from Lambda functions and ECS tasks.
- Log retention policies are configured per service (7-30 days).

### Error Tracking
- **Sentry** v9.30.0 is adopted for application error tracking (web app, extension).
- Sentry integrates with CloudWatch for correlated error analysis.

### Analytics & Telemetry
- **PostHog** v1.180.1 is adopted for product analytics (web, extension).
- **Mixpanel** and **Firebase Analytics** are adopted for mobile app telemetry.
- **AWS CloudWatch Dashboards** visualize infrastructure health and performance.

### Uptime Monitoring
- **Uptime service** (custom microservice) monitors service health and availability.
- Health check endpoints are exposed by each microservice.

## CI/CD Pipeline

### Platform
- **Azure DevOps** (Azure Pipelines) is adopted for continuous integration and deployment.
- Self-hosted agent: `learnn-agent-v2` runs on `learnn-agent-pool`.

### Pipeline Stages
1. **Build**: `turbo build` compiles all workspaces with caching.
2. **Test**: `turbo test:unit` runs unit tests (concurrency=1, excluding e2e).
3. **CDK Synth**: Synthesizes CloudFormation templates for each service.
4. **CDK Diff**: Generates infrastructure change previews.
5. **CDK Deploy**: Deploys changes to AWS (approval may be required for production).

### Deployment Triggers
- **Automatic**: Push to `Development` branch triggers staging deployment.
- **Manual**: Merge to `master` branch triggers production deployment (with approval).
- **Individual Pipelines**: Each service has its own pipeline in Azure DevOps.

## Environments

### Staging
- **Branch**: `Development`
- **AWS Stage**: `staging`
- **Purpose**: Pre-production testing and validation.
- **Deployment**: Automatic on every push to `Development` branch.

### Production
- **Branch**: `master`
- **AWS Stage**: `production`
- **Purpose**: Live production environment serving end users.
- **Deployment**: Manual merge from `Development` to `master`, or cherry-pick specific PRs.

## Deployment Strategy

### Per-Service Deployment
- Each microservice is deployed independently via its CDK stack.
- Services are deployed in sequence to manage dependencies.
- Deployment order (from Azure Pipelines):
  1. identity
  2. web app
  3. cms-v4 (Strapi)
  4. quiz
  5. assistant
  6. checkout
  7. my
  8. engagement
  9. webhooks
  10. billing
  11. vod
  12. recommender
  13. profile
  14. expert
  15. user-content

### Rollback Strategy
- CloudFormation stack rollback is enabled for failed deployments.
- Previous Lambda versions are retained for quick rollback via alias updates.
- Database migrations are versioned and reversible where possible.

## Security & Compliance

### Network Security
- **VPC** is configured with public and private subnets.
- Lambda functions and ECS tasks run in private subnets with NAT Gateway for outbound access.
- Security groups enforce least-privilege access between services.

### Encryption
- **At-Rest**: S3 buckets and RDS databases use AWS KMS encryption.
- **In-Transit**: All services use TLS/HTTPS (enforced via CloudFront and API Gateway).

### IAM & Access Control
- **IAM Roles** are scoped per service with least-privilege policies.
- Lambda execution roles grant access only to required AWS resources.
- **MFA** is enforced for AWS Console access.

### GDPR Compliance
- All user data is stored in eu-south-1 region (Italy).
- Data retention policies are configured per GDPR requirements.
- User data deletion workflows are implemented in compliance with GDPR.

## App-Specific Deployment

Deployment details for individual client apps live in their local `.pair` contexts:

- **Mobile App** (iOS/Android): [`apps/mobile/.pair — ux-ui.md`](../../../apps/mobile/.pair/.pair.ux-ui.md)
- **Browser Extension** (Chrome/Firefox): [`apps/extension/.pair — ux-ui.md`](../../../apps/extension/.pair/.pair.ux-ui.md)

---

All deployment and infrastructure implementations must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
