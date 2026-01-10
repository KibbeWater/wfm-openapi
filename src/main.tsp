import "@typespec/http";
import "@typespec/openapi";
import "@typespec/openapi3";

import "./common/headers.tsp";
import "./common/responses.tsp";
import "./common/errors.tsp";

import "./models/enums.tsp";
import "./models/items.tsp";
import "./models/rivens.tsp";
import "./models/liches.tsp";
import "./models/sisters.tsp";
import "./models/world.tsp";
import "./models/orders.tsp";
import "./models/users.tsp";

import "./routes/manifests.tsp";
import "./routes/orders.tsp";
import "./routes/users.tsp";
import "./routes/auth.tsp";
import "./routes/auth-v1.tsp";
import "./routes/achievements.tsp";
import "./routes/dashboard.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

/**
 * Third-party OpenAPI documentation for the warframe.market API v2.
 * 
 * This is an unofficial documentation project. For the official documentation,
 * visit the [Notion page](https://42bytes.notion.site/WFM-Api-v2-Documentation-5d987e4aa2f74b55a80db1a09932459d).
 * 
 * ## Base URLs
 * 
 * - **V2 API**: `https://api.warframe.market/v2/`
 * - **V1 API** (auth only): `https://api.warframe.market/v1/`
 * - **Static Assets**: `https://warframe.market/static/assets/`
 * 
 * ## Authentication
 * 
 * Authentication is currently handled via the **V1 API**. To authenticate:
 * 
 * 1. Send a POST request to `/v1/auth/signin` with credentials
 * 2. Extract the JWT from the `Authorization` response header (strip "JWT " prefix)
 * 3. Use the token as `Bearer <token>` in subsequent V2 API requests
 * 
 * See the **Authentication (V1)** section for details.
 * 
 * **Note**: OAuth 2.0 is planned for future implementation.
 * 
 * ## Rate Limits
 * 
 * 3 requests per second. Exceeding this limit results in a `429` error.
 * 
 * ## Global Headers
 * 
 * Most endpoints accept the following headers:
 * 
 * - `Language`: Request additional translations (default: `en`)
 * - `Platform`: Filter by platform - `pc`, `ps4`, `xbox`, `switch`, `mobile` (default: `pc`)
 * - `Crossplay`: Include cross-play orders - `true` or `false` (default: `true`)
 */
@service(#{
  title: "warframe.market API",
})
@OpenAPI.info(#{
  version: "0.21.2",
})
@server("https://api.warframe.market", "Production API server")
namespace WarframeMarket;
