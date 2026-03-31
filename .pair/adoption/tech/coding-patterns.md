# Coding Patterns

## Lambda Function Structure

Each Lambda function follows this standard file structure:

```
services/{service-name}/src/handlers/{lambdaName}/
├── config.ts         # Environment variables validation (io-ts)
├── handler.ts        # Dependency wiring and service initialization
├── handlerFactory.ts # Pure business logic with dependencies as parameters
└── index.ts          # Entry point (re-exports handler)
```

### Separation of Concerns

- **config.ts**: Validates environment variables with io-ts, fails fast if missing.
- **handlerFactory.ts**: Pure function, receives dependencies as parameters, returns `Task<APIGatewayProxyResult>`.
- **handler.ts**: Wires config and real service instances into handlerFactory.
- **index.ts**: `export { default as handler } from './handler'`

### config.ts Pattern

```typescript
import * as t from 'io-ts'
import { isLeft } from 'fp-ts/Either'

const MyLambdaEnvVariables = t.type({
  REQUIRED_VAR: t.string,
  ANOTHER_VAR: t.string,
})

export type MyLambdaEnvVariables = t.TypeOf<typeof MyLambdaEnvVariables>

export const fromEnvironment = (): MyLambdaEnvVariables => {
  const decodedEnvs = MyLambdaEnvVariables.decode(process.env)
  if (isLeft(decodedEnvs)) {
    console.error('Invalid environment variables:', JSON.stringify(decodedEnvs))
    return process.exit(1)
  }
  return decodedEnvs.right
}
```

### handler.ts Pattern

```typescript
import { fromEnvironment } from './config'
import handlerFactory from './handlerFactory'
import { taskHandlerToPromise } from '@learnn/utils-be/src/utils/http'
import { serviceA } from '../../services/serviceA'

const config = fromEnvironment()
const serviceAInstance = serviceA(config.REQUIRED_VAR)
const handler = handlerFactory(serviceAInstance)

export default taskHandlerToPromise(handler)
```

### handlerFactory.ts Pattern

```typescript
import * as TE from 'fp-ts/TaskEither'
import * as T from 'fp-ts/Task'
import { pipe } from 'fp-ts/function'
import { createCorsResponse as createResponseTask } from '@learnn/utils-be/src/utils/http'

const handlerFactory = (
  getUser: GetUser,
  updateUser: UpdateUser
) => (event: APIGatewayProxyEvent): T.Task<APIGatewayProxyResult> => {
  return pipe(
    event.userId,
    getUser,
    TE.chainW(user => updateUser(user, event.updates)),
    TE.fold(
      error => {
        switch (error.code) {
          case 'ValidationError':
            return createResponseTask(event.headers.origin)(400, { code: error.code, message: error.message })
          case 'NotFoundError':
            return createResponseTask(event.headers.origin)(404, { code: error.code, message: 'Not found' })
          default:
            return createResponseTask(event.headers.origin)(500, { code: 'UnknownError', message: 'An unknown error occurred' })
        }
      },
      result => createResponseTask(event.headers.origin)(200, result)
    )
  )
}
```

## fp-ts Patterns

### Core Principles

- **Pure Functions**: No side effects, deterministic outputs.
- **Immutability**: Never mutate data structures.
- **Composition**: Build complex operations by composing smaller functions with `pipe`.
- **Type Safety**: Use io-ts for runtime validation.
- **Error Handling**: Use `TaskEither` for async operations that can fail.

### Data Flow with `pipe`

```typescript
import { pipe } from 'fp-ts/function'

return pipe(
  initialValue,
  operationA,
  operationB,
  operationC
)
```

### TaskEither Operations

| Operation | Purpose | When to Use |
|-----------|---------|-------------|
| `TE.map` | Transform success value | When transformation can't fail |
| `TE.chainW` | Transform and possibly fail | When next operation may fail |
| `TE.fold` | Handle both success and error | At end of pipe to convert from TaskEither |

### Multiple Parameters with `tuple` / `tupled`

```typescript
import { pipe, tuple, tupled } from 'fp-ts/function'

return pipe(
  tuple(param1, param2),
  tupled((p1, p2) => someFunction(p1, p2))
)
```

### Error Types

- Define explicit error types for each failure case.
- Use union types for function-level error definitions.
- Maintain specific error types throughout the pipeline.

```typescript
type ValidationError = Error<'ValidationError'>
type NotFoundError = Error<'NotFoundError'>
type ServiceError = Error<'ServiceError'>

type GetUserError = ValidationError | NotFoundError | ServiceError
```

### Response Handling

- Always use `createCorsResponse` (aliased as `createResponseTask`) from `@learnn/utils-be/src/utils/http`.
- Never construct response objects manually.

### Anti-patterns to Avoid

1. Mixing functional and imperative styles.
2. Nested try/catch — use `TE.chainW` instead.
3. Using `TE.tryCatch` everywhere — reserve for integration boundaries with non-FP code.
4. Discarding error types.
5. Nested `pipe` calls — flatten with `TE.chainW`.
6. Manual null/undefined checks — use Option combinators.
7. Manual response construction — use `createResponseTask`.

## utils-be Business Logic

### File Organization

```
packages/utils-be/src/api/[domain]/[feature]/[functionName].ts
```

### Function Implementation

- **Factory pattern**: Functions accept dependencies as parameters.
- **TaskEither return**: All async operations return `TE.TaskEither<Error, Result>`.
- **Explicit types**: Export error types, function types, options types, and response types.

```typescript
export type BusinessFunction = (
  param1: string,
  param2: Options,
) => TE.TaskEither<BusinessFunctionError, ResponseType>

export const businessFunction: (
  dependency1: Service1
) => BusinessFunction =
  (dependency1) => (param1, param2) => {
    return pipe(
      initialValue,
      operation1,
      TE.chainW(result => operation2(result)),
      TE.map(transformResult)
    )
  }
```

### Optional Index Files

```typescript
export type CheckoutApi = {
  createCheckoutSession: CreateCheckoutSession
}

export const checkoutApi: (client: Stripe) => CheckoutApi = client => ({
  createCheckoutSession: createCheckoutSession(client),
})
```

## Testing Patterns

### Test Directory Structure

```
packages/utils-be/__tests__/unit/api/[domain]/[feature]/[functionName].test.ts
```

### Basic Test Template

```typescript
import { functionName } from '../../../../../src/path/to/function'
import * as E from 'fp-ts/Either'

describe('Function name unit test', () => {
  beforeEach(() => {
    jest.resetModules()
    jest.clearAllMocks()
  })

  it('should handle successful case', async () => {
    const result = await functionName(dependencies)(params)()
    expect(result).toEqual(E.right(expectedValue))
  })

  it('should handle error case', async () => {
    const result = await functionName(dependencies)(params)()
    expect(result).toEqual(
      E.left({ code: 'ExpectedErrorCode', messages: ['Expected error message'] })
    )
  })
})
```

### Mocking Dependencies

- **External services** (Stripe, AWS): Mock with `jest.mock()`.
- **Internal dependencies**: Create mock implementations returning `TE.right()` or `TE.left()`.
- Always verify calls with `expect(mock).toHaveBeenCalledWith(...)`.

### Testing Best Practices

- Reset mocks in `beforeEach` with `jest.resetModules()` and `jest.clearAllMocks()`.
- Test complete return values, not just existence.
- Always test error paths and generic/unknown error handling.
- Each test verifies one specific behavior.

## Lambda Migration (Imperative to Functional)

When migrating existing Lambda functions to fp-ts:

1. Create new file structure (config.ts, handlerFactory.ts, handler.ts, index.ts).
2. Implement functional patterns in handlerFactory.ts.
3. Extract business logic to `packages/utils-be/src/api/[domain]/`.
4. Update CDK stack in `services/{service-name}/lib/{service-name}-stack.ts`.
5. Ensure env variable type in stack matches `config.ts` type exactly.
6. Test and validate before replacing original implementation.

---

All coding patterns must follow these adopted standards. For process and rationale, see [way-of-working.md](way-of-working.md).
