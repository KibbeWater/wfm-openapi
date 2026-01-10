# wfm-openapi

Third-party OpenAPI and AsyncAPI documentation for the [warframe.market](https://warframe.market) API.

This project provides machine-readable API specifications generated from TypeSpec, served with a modern documentation UI via Scalar.

## Features

- **OpenAPI 3.1** specification for the REST API (~35 endpoints)
- **AsyncAPI 3.0** specification for the WebSocket API (~20 message types)
- **Scalar UI** for interactive documentation
- **TypeSpec** source for maintainable, type-safe API definitions
- **GitHub Pages** deployment via Actions

## Live Documentation

View the documentation at: https://kibbewater.github.io/wfm-openapi/

## API Coverage

### REST API (V2)

| Category | Endpoints |
|----------|-----------|
| Manifests | Items, Rivens, Liches, Sisters, Locations, NPCs, Missions |
| Orders | Recent, by item, by user, CRUD operations |
| Users | Profile, avatar, background |
| Authentication | V1 signin, refresh, signout |
| Achievements | List all, by user |
| Dashboard | Showcase |

### WebSocket API

| Category | Messages |
|----------|----------|
| Reports | Online count |
| Authentication | Sign in/out, status updates, ban/warn events |
| Order Subscriptions | Subscribe/unsubscribe to items, profiles, new orders |
| Order Events | New, patched, removed, closed |

## Development

### Prerequisites

- Node.js 20+
- npm

### Setup

```bash
# Clone the repository
git clone https://github.com/KibbeWater/wfm-openapi.git
cd wfm-openapi

# Install dependencies
npm install
```

### Build

```bash
# Full build (OpenAPI + AsyncAPI + static files)
npm run build

# Build only OpenAPI spec
npm run build:openapi

# Watch mode for development
npm run watch
```

### Preview

```bash
# Serve the documentation locally
npm run serve
# Open http://localhost:3000
```

## Project Structure

```
wfm-openapi/
├── src/
│   ├── main.tsp              # TypeSpec entry point
│   ├── common/               # Shared definitions
│   │   ├── headers.tsp       # Global headers (Language, Platform, Crossplay)
│   │   ├── responses.tsp     # Response wrapper models
│   │   └── errors.tsp        # Error response models
│   ├── models/               # Data models
│   │   ├── enums.tsp         # Enumerations
│   │   ├── items.tsp         # Item, ItemShort
│   │   ├── orders.tsp        # Order, OrderWithUser, Transaction
│   │   ├── users.tsp         # User, UserShort, UserPrivate
│   │   └── ...               # Rivens, Liches, Sisters, World
│   └── routes/               # API endpoints
│       ├── manifests.tsp     # /v2/items, /v2/riven/*, etc.
│       ├── orders.tsp        # /v2/orders/*, /v2/order/*
│       ├── users.tsp         # /v2/me, /v2/user/*
│       ├── auth.tsp          # /auth/* (V2)
│       ├── auth-v1.tsp       # /v1/auth/* (V1 signin)
│       └── ...
├── asyncapi/
│   └── websockets.yaml       # AsyncAPI spec for WebSocket API
├── static/
│   └── index.html            # Scalar UI
├── dist/                     # Build output (gitignored)
│   ├── openapi.json
│   ├── asyncapi.yaml
│   └── index.html
├── tspconfig.yaml            # TypeSpec configuration
└── package.json
```

## Authentication

The warframe.market API currently uses JWT authentication via the V1 API:

1. **Sign in** via `POST https://api.warframe.market/v1/auth/signin`
2. Extract the JWT from the `Authorization` response header (strip "JWT " prefix)
3. Use as `Bearer <token>` for V2 API requests

See the [Authentication (V1)](https://kibbewater.github.io/wfm-openapi/#tag/authentication-v1) section in the docs for details.

> **Note**: OAuth 2.0 is planned for future implementation.

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

When contributing:

1. Make changes to the TypeSpec files in `src/`
2. Run `npm run build` to verify the changes compile
3. Test locally with `npm run serve`
4. Submit a PR with a clear description of changes

## Related Projects

- [wf-market](https://github.com/KibbeWater/wf-market) - Rust client library for warframe.market
- [Official Notion Docs](https://42bytes.notion.site/WFM-Api-v2-Documentation-5d987e4aa2f74b55a80db1a09932459d) - Official API documentation

## License

MIT
