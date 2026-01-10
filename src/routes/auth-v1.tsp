import "@typespec/http";
import "@typespec/openapi";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/users.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * V1 Authentication endpoints.
 * 
 * These endpoints are on the V1 API (`https://api.warframe.market/v1`).
 * The tokens obtained here can be used with V2 API endpoints.
 * 
 * **Note**: These endpoints will be deprecated when OAuth 2.0 is implemented.
 */
@tag("Authentication (V1)")
@route("/v1/auth")
namespace AuthV1 {
  /**
   * Sign in with username and password.
   * 
   * Authenticates a user and returns a JWT token in the response header.
   * 
   * ## Important Notes
   * 
   * - The `Authorization: JWT` header is required in the request
   * - On success, the JWT token is returned in the `Authorization` response header
   * - The token is prefixed with "JWT " - strip this prefix before using as Bearer token
   * - The `device_id` should be unique per device and reused across sessions
   * 
   * ## Example
   * 
   * Request:
   * ```
   * POST /v1/auth/signin
   * Content-Type: application/json
   * Authorization: JWT
   * 
   * {
   *   "auth_type": "header",
   *   "email": "user@example.com",
   *   "password": "password123",
   *   "device_id": "550e8400-e29b-41d4-a716-446655440000"
   * }
   * ```
   * 
   * Response Header:
   * ```
   * Authorization: JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   * ```
   * 
   * Use token with V2 API:
   * ```
   * Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   * ```
   */
  @summary("Sign in (V1)")
  @post
  @route("/signin")
  op signIn(
    @doc("Must be 'JWT' for header-based auth")
    @header Authorization: "JWT",
    @body body: SignInRequest
  ): {
    @statusCode statusCode: 200;
    @doc("JWT token prefixed with 'JWT '")
    @header Authorization: string;
    @body body: SignInResponse;
  } | BadRequestError | UnauthorizedError;
}

/**
 * Sign in request body.
 */
model SignInRequest {
  @doc("Authentication type - use 'header' to receive token in response header")
  auth_type: "header";

  @doc("User's email address or username")
  email: string;

  @doc("User's password")
  password: string;

  @doc("Unique device identifier (UUID recommended). Should be persisted and reused.")
  device_id: string;
}

/**
 * Sign in response body.
 */
model SignInResponse {
  @doc("Authenticated user information")
  user: UserShort;
}

/**
 * V1 API response wrapper.
 */
model V1ApiResponse<T> {
  @doc("Response payload")
  payload: T;
}
