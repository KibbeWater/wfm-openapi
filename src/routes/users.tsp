import "@typespec/http";
import "../common/headers.tsp";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/users.tsp";

using TypeSpec.Http;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * Image upload form part.
 */
model ImageUpload {
  @doc("Image file to upload")
  file: HttpPart<bytes>;
}

/**
 * User profile endpoints.
 */
@tag("Users")
@route("/v2")
namespace Users {
  /**
   * Get current user's profile.
   * 
   * Returns the private profile of the authenticated user, including settings
   * and other private information.
   * 
   * Requires authentication.
   */
  @summary("Get my profile")
  @get
  @route("/me")
  @useAuth(Http.BearerAuth)
  op getMe(): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<UserPrivate>;
  } | UnauthorizedError;

  /**
   * Update current user's profile.
   * 
   * Updates profile settings for the authenticated user.
   * 
   * Requires authentication.
   */
  @summary("Update my profile")
  @patch
  @route("/me")
  @useAuth(Http.BearerAuth)
  op updateMe(
    @body body: UpdateUserRequest
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<UserPrivate>;
  } | BadRequestError | UnauthorizedError;

  /**
   * Upload avatar image.
   * 
   * Uploads a new avatar image for the authenticated user.
   * 
   * Requires authentication.
   */
  @summary("Upload avatar")
  @post
  @route("/me/avatar")
  @useAuth(Http.BearerAuth)
  op uploadAvatar(
    @multipartBody body: ImageUpload
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<UserPrivate>;
  } | BadRequestError | UnauthorizedError;

  /**
   * Upload background image.
   * 
   * Uploads a new profile background image for the authenticated user.
   * 
   * Requires authentication.
   */
  @summary("Upload background")
  @post
  @route("/me/background")
  @useAuth(Http.BearerAuth)
  op uploadBackground(
    @multipartBody body: ImageUpload
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<UserPrivate>;
  } | BadRequestError | UnauthorizedError;

  /**
   * Get public user profile.
   * 
   * Returns the public profile of a user by their slug.
   */
  @summary("Get user profile")
  @get
  @route("/user/{slug}")
  op getUser(
    @path slug: string
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<User>;
  } | NotFoundError;
}
