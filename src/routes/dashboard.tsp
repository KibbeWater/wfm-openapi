import "@typespec/http";
import "../common/headers.tsp";
import "../common/responses.tsp";
import "../models/users.tsp";

using TypeSpec.Http;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * Dashboard endpoints.
 */
@tag("Dashboard")
@route("/v2")
namespace Dashboard {
  /**
   * Get dashboard showcase.
   * 
   * Returns featured items for the mobile app home screen dashboard.
   */
  @summary("Get dashboard showcase")
  @get
  @route("/dashboard/showcase")
  op getDashboardShowcase(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<DashboardShowcase>;
  };
}
