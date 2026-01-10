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
 * Note: Sign-in and sign-up endpoints are first-party only and not documented here.
 */
@tag("Authentication")
@route("/auth")
namespace Auth {
  /**
   * Refresh authentication token.
   * 
   * Obtains a new access token using a refresh token.
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
