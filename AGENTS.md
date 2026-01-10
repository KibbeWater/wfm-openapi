# Agent Guidelines for wfm-openapi

This document provides guidelines for AI coding agents working in this repository.

## Project Overview

This is a TypeSpec-based project that generates OpenAPI 3.1 and AsyncAPI 3.0 specifications for the warframe.market API. The output is served as static documentation using Scalar.

## Build Commands

```bash
# Install dependencies
npm install

# Full build (OpenAPI + AsyncAPI + static files)
npm run build

# Build only the OpenAPI spec from TypeSpec
npm run build:openapi

# Watch mode for development (auto-rebuilds on changes)
npm run watch

# Serve documentation locally at http://localhost:3000
npm run serve

# Clean build artifacts
npm run clean
```

There are no tests or linting configured for this project. Validation is done by the TypeSpec compiler during build.

## Project Structure

```
src/
├── main.tsp              # Entry point - imports all modules, defines service metadata
├── common/               # Shared definitions
│   ├── headers.tsp       # Global HTTP headers (Language, Platform, Crossplay)
│   ├── responses.tsp     # Response wrapper models (ApiResponse, SuccessResponse)
│   └── errors.tsp        # HTTP error models (BadRequestError, NotFoundError, etc.)
├── models/               # Data models (schemas)
│   ├── enums.tsp         # All enumerations (Platform, Status, OrderType, etc.)
│   ├── items.tsp         # Item, ItemShort, ItemI18n models
│   ├── orders.tsp        # Order, OrderWithUser, Transaction models
│   ├── users.tsp         # User, UserShort, UserPrivate, Achievement models
│   └── [domain].tsp      # Domain-specific models (rivens, liches, sisters, world)
└── routes/               # API endpoint definitions
    ├── manifests.tsp     # /v2/items, /v2/riven/*, /v2/lich/*, etc.
    ├── orders.tsp        # /v2/orders/*, /v2/order/*
    ├── users.tsp         # /v2/me, /v2/user/*
    ├── auth.tsp          # /auth/* (V2 endpoints)
    ├── auth-v1.tsp       # /v1/auth/* (V1 signin)
    └── [domain].tsp      # Other route groups

asyncapi/
└── websockets.yaml       # AsyncAPI 3.0 spec (manually maintained YAML)

static/
└── index.html            # Scalar UI wrapper

dist/                     # Build output (gitignored)
├── openapi.json          # Generated OpenAPI spec
├── asyncapi.yaml         # Copied AsyncAPI spec
└── index.html            # Copied Scalar UI
```

## TypeSpec Code Style

### File Organization

1. **Imports first**: External packages, then relative imports
2. **Using statements**: After imports
3. **Namespace declaration**: After using statements
4. **Content**: Models, then operations

```typespec
import "@typespec/http";
import "../common/headers.tsp";
import "../models/items.tsp";

using TypeSpec.Http;
using WarframeMarket.Common;

namespace WarframeMarket;

// Models and operations here
```

### Namespaces

- Main namespace: `WarframeMarket`
- Models: `WarframeMarket.Models`
- Common utilities: `WarframeMarket.Common`
- Route groups: Nested under `WarframeMarket` (e.g., `namespace Orders { }`)

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Models | PascalCase | `OrderWithUser`, `ItemShort` |
| Enums | PascalCase | `Platform`, `OrderType` |
| Enum values | camelCase or SCREAMING_SNAKE | `pc`, `ON_MISSION` |
| Operations | camelCase, verb prefix | `getItems`, `createOrder`, `updateMe` |
| Properties | camelCase | `itemId`, `createdAt`, `ingameName` |
| Path params | camelCase | `{slug}`, `{id}` |

### Documentation

- Use JSDoc-style `/** */` comments for all public models and operations
- Use `@doc()` decorator for property-level documentation
- Use `@summary()` for operation summaries (appears in OpenAPI)
- Include parameter descriptions for path/query params

```typespec
/**
 * Get item details.
 * 
 * Returns full details for a specific item.
 */
@summary("Get item by slug")
@get
@route("/item/{slug}")
op getItem(
  @path slug: string,
  ...TranslatableHeaders
): { ... };
```

### Models

- Use generic wrapper models for consistency: `SuccessResponse<T>`
- Define I18n models as nested structures: `ItemI18n`, `ItemI18nContent`
- Use `?` for optional properties
- Use `@doc()` for property descriptions

```typespec
model Item {
  @doc("Unique item identifier")
  id: string;

  @doc("Maximum mod rank (if applicable)")
  maxRank?: int32;
}
```

### Operations (Routes)

- Group related endpoints in nested namespaces with `@tag()` and `@route()`
- Use spread operator for common headers: `...TranslatableHeaders`
- Define response inline with status code and body
- Use union types for error responses: `} | NotFoundError | BadRequestError`

```typespec
@tag("Orders")
@route("/v2")
namespace Orders {
  @summary("Get order by ID")
  @get
  @route("/order/{id}")
  op getOrder(@path id: string): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<OrderWithUser>;
  } | NotFoundError;
}
```

### Authentication

- Use `@useAuth(Http.BearerAuth)` for protected endpoints
- Document auth requirements in operation JSDoc

### Enums

- Group related enums in `models/enums.tsp`
- Use `@doc()` on enum values when the meaning isn't obvious
- Use backticks for reserved words: `` `switch` ``, `` `zh-hans` ``

## AsyncAPI (websockets.yaml)

- Manually maintained YAML file
- Follow AsyncAPI 3.0 specification
- Use `$ref` for schema reuse within the file
- Keep message schemas in `components/schemas`
- Document message direction (send/receive) in operations

## Common Patterns

### Adding a New Endpoint

1. Identify the route group (or create new file in `src/routes/`)
2. Add operation with decorators: `@summary`, `@get/@post/@patch/@delete`, `@route`
3. Define request parameters (path, query, body)
4. Define response with `SuccessResponse<T>` wrapper
5. Add error responses as union types
6. Run `npm run build` to verify

### Adding a New Model

1. Add to appropriate file in `src/models/`
2. Include JSDoc description
3. Add `@doc()` to properties
4. Import in route files that need it
5. Run `npm run build` to verify

### Common Errors

- **"Is a model expression type, but is being used as a value"**: Use `#{}` for object literals in decorators
- **"Cannot apply @header decorator to Model"**: Put `@header` on properties, not models
- **"ambiguous-symbol"**: Use fully qualified name like `Http.BearerAuth`

## Version Matching

The package version (`0.21.2`) should match the warframe.market API version being documented.
