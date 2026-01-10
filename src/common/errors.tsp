import "@typespec/http";

using TypeSpec.Http;

namespace WarframeMarket.Common;

/**
 * 400 Bad Request - Invalid input or validation error.
 */
@error
model BadRequestError {
  @statusCode statusCode: 400;
  @body body: ErrorResponse;
}

/**
 * 401 Unauthorized - Authentication required or token invalid.
 */
@error
model UnauthorizedError {
  @statusCode statusCode: 401;
  @body body: ErrorResponse;
}

/**
 * 403 Forbidden - Insufficient permissions.
 */
@error
model ForbiddenError {
  @statusCode statusCode: 403;
  @body body: ErrorResponse;
}

/**
 * 404 Not Found - Resource does not exist.
 */
@error
model NotFoundError {
  @statusCode statusCode: 404;
  @body body: ErrorResponse;
}

/**
 * 429 Too Many Requests - Rate limit exceeded.
 */
@error
model RateLimitError {
  @statusCode statusCode: 429;
  @body body: ErrorResponse;
}

/**
 * 509 Bandwidth Limit Exceeded - Too many concurrent connections.
 */
@error
model BandwidthLimitError {
  @statusCode statusCode: 509;
  @body body: ErrorResponse;
}

/**
 * 500 Internal Server Error - Unhandled server error.
 */
@error
model InternalServerError {
  @statusCode statusCode: 500;
}
