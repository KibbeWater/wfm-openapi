import "@typespec/http";
import "@typespec/openapi";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/statistics.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * V1 Item endpoints.
 * 
 * These endpoints are on the V1 API (`https://api.warframe.market/v1`).
 */
@tag("Items (V1)")
@route("/v1/items")
namespace ItemsV1 {
  /**
   * Get trading statistics for an item.
   * 
   * Returns historical price and volume statistics for the specified item,
   * including both completed trades and live order data.
   * 
   * ## Data Timeframes
   * 
   * - **48hours**: Hourly data points for the last 48 hours
   * - **90days**: Daily data points for the last 90 days
   * 
   * ## Statistics Types
   * 
   * - **statistics_closed**: Data from completed trades
   * - **statistics_live**: Data from live/pending orders
   * 
   * ## Price Indicators
   * 
   * Each data point includes OHLC-style pricing (open, high, low, close),
   * various averages (simple, weighted, moving), and Donchian channel bounds.
   */
  @summary("Get item statistics")
  @get
  @route("/{slug}/statistics")
  op getItemStatistics(
    @doc("Item URL slug (e.g., 'sicarus_prime_receiver')")
    @path slug: string
  ): {
    @statusCode statusCode: 200;
    @body body: V1ApiResponse<ItemStatistics>;
  } | NotFoundError;
}
