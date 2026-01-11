import "@typespec/http";

using TypeSpec.Http;

namespace WarframeMarket.Models;

/**
 * A single statistics data point for item trading activity.
 * Contains OHLC-style price data and technical indicators.
 */
model StatisticEntry {
  @doc("Unique identifier")
  id: string;

  @doc("Timestamp for this data point (hourly for 48hours, daily for 90days)")
  datetime: utcDateTime;

  @doc("Number of trades in this period")
  volume: int32;

  @doc("Lowest price in this period")
  min_price: int32;

  @doc("Highest price in this period")
  max_price: int32;

  @doc("First trade price in this period")
  open_price: int32;

  @doc("Last trade price in this period")
  closed_price: int32;

  @doc("Simple average price")
  avg_price: float64;

  @doc("Volume-weighted average price")
  wa_price: float64;

  @doc("Median price")
  median: float64;

  @doc("Moving average price")
  moving_avg: float64;

  @doc("Donchian channel top (highest high over lookback period)")
  donch_top: int32;

  @doc("Donchian channel bottom (lowest low over lookback period)")
  donch_bot: int32;
}

/**
 * Statistics grouped by timeframe.
 */
model TimeframedStatistics {
  @doc("Hourly data points for the last 48 hours")
  `48hours`: StatisticEntry[];

  @doc("Daily data points for the last 90 days")
  `90days`: StatisticEntry[];
}

/**
 * Complete item trading statistics.
 */
model ItemStatistics {
  @doc("Statistics from completed/closed trades")
  statistics_closed: TimeframedStatistics;

  @doc("Statistics from live/pending orders")
  statistics_live: TimeframedStatistics;
}
