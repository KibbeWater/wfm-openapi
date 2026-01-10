import "@typespec/http";

using TypeSpec.Http;

namespace WarframeMarket.Common;

/**
 * Standard API response wrapper.
 * All responses from the API are wrapped in this structure.
 */
@doc("Standard API response wrapper")
model ApiResponse<T> {
  @doc("SemVer compatible version of the API server")
  apiVersion: string;

  @doc("Response data if request was successful, null otherwise")
  data: T | null;

  @doc("Error details if request failed, null otherwise")
  error: ApiError | null;
}

/**
 * API error structure.
 */
@doc("API error details")
model ApiError {
  @doc("General request-level errors")
  request?: string[];

  @doc("Input-level validation errors keyed by field name")
  inputs?: Record<string>;
}

/**
 * Successful response with data.
 */
model SuccessResponse<T> {
  apiVersion: string;
  data: T;
  error: null;
}

/**
 * Error response.
 */
model ErrorResponse {
  apiVersion: string;
  data: null;
  error: ApiError;
}
