import "@typespec/http";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/users.tsp";

using TypeSpec.Http;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * Authentication endpoints.
 * 
 * ## Current Authentication (V1 API)
 * 
 * Authentication is currently handled through the **V1 API** at a different base URL.
 * The token obtained from V1 can be used with V2 endpoints.
 * 
 * ### Authentication Flow
 * 
 * 1. **Sign in** via `POST https://api.warframe.market/v1/auth/signin`
 * 2. Extract the JWT token from the `Authorization` response header (prefixed with "JWT ")
 * 3. Use the token as `Bearer <token>` in the `Authorization` header for V2 API requests
 * 
 * ### Sign In Request (V1)
 * 
 * ```
 * POST https://api.warframe.market/v1/auth/signin
 * Content-Type: application/json
 * Authorization: JWT
 * 
 * {
 *   "auth_type": "header",
 *   "email": "your_username_or_email",
 *   "password": "your_password",
 *   "device_id": "unique_device_identifier"
 * }
 * ```
 * 
 * ### Sign In Response
 * 
 * On success, the JWT token is returned in the `Authorization` header:
 * ```
 * Authorization: JWT eyJhbGciOiJIUzI1NiIs...
 * ```
 * 
 * Strip the "JWT " prefix and use as Bearer token:
 * ```
 * Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
 * ```
 * 
 * ### Device ID
 * 
 * The `device_id` should be a unique identifier for the device/application instance.
 * It should be generated once and reused for subsequent logins from the same device.
 * A UUID v4 is commonly used.
 * 
 * ## Future: OAuth 2.0
 * 
 * OAuth 2.0 authentication is planned for future implementation. This will provide:
 * - Scoped access tokens
 * - Third-party application authorization
 * - Improved security with refresh token rotation
 * 
 * The V1 sign-in endpoint will eventually be deprecated in favor of OAuth 2.0.
 */
@tag("Authentication")
@route("/auth")
namespace Auth {
  /**
   * Refresh authentication token.
   * 
   * Obtains a new access token using the current token.
   * 
   * Requires authentication.
   */
  @summary("Refresh token")
  @post
  @route("/refresh")
  @useAuth(Http.BearerAuth)
  op refreshToken(): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<RefreshTokenResponse>;
  } | UnauthorizedError;

  /**
   * Sign out.
   * 
   * Invalidates the current authentication token.
   * 
   * Requires authentication.
   */
  @summary("Sign out")
  @post
  @route("/signout")
  @useAuth(Http.BearerAuth)
  op signOut(): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<null>;
  } | UnauthorizedError;
}

/**
 * Response for token refresh.
 */
model RefreshTokenResponse {
  @doc("New access token")
  accessToken: string;

  @doc("Token expiration time")
  expiresAt: utcDateTime;
}
