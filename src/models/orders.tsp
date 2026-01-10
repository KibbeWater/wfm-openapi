import "./users.tsp";

namespace WarframeMarket.Models;

/**
 * Base order model without user information.
 * Used when the owner is already known (e.g., user profile, own orders).
 */
@doc("Trading order")
model Order {
  @doc("Unique order identifier")
  id: string;

  @doc("Order type: buy or sell")
  type: OrderType;

  @doc("Price in platinum")
  platinum: int32;

  @doc("Available quantity")
  quantity: int32;

  @doc("Minimum quantity per trade")
  perTrade?: int32;

  @doc("Mod rank (for rankable items)")
  rank?: int32;

  @doc("Remaining charges (for consumable items)")
  charges?: int32;

  @doc("Item subtype (e.g., blueprint, crafted)")
  subtype?: string;

  @doc("Installed amber stars (for Ayatan sculptures)")
  amberStars?: int32;

  @doc("Installed cyan stars (for Ayatan sculptures)")
  cyanStars?: int32;

  @doc("Whether the order is visible to other users")
  visible: boolean;

  @doc("When the order was created")
  createdAt: utcDateTime;

  @doc("When the order was last updated")
  updatedAt: utcDateTime;

  @doc("ID of the item being traded")
  itemId: string;

  @doc("Order group (default: 'all')")
  group?: string;
}

/**
 * Order with embedded user information.
 * Used in most order listings.
 */
@doc("Trading order with seller/buyer information")
model OrderWithUser {
  ...Order;

  @doc("Order owner information")
  user: UserShort;
}

/**
 * Transaction item details.
 */
model TransactionItem {
  @doc("Item ID")
  id: string;

  @doc("Item rank at time of transaction")
  rank?: int32;

  @doc("Charges at time of transaction")
  charges?: int32;

  @doc("Subtype at time of transaction")
  subtype?: string;

  @doc("Cyan stars at time of transaction")
  cyanStars?: int32;

  @doc("Amber stars at time of transaction")
  amberStars?: int32;
}

/**
 * Completed or partially completed order transaction.
 */
@doc("Record of a completed or partial order closure")
model Transaction {
  @doc("Transaction identifier")
  id: string;

  @doc("Transaction type: buy or sell")
  type: OrderType;

  @doc("Original order ID")
  originId: string;

  @doc("Platinum amount")
  platinum: int32;

  @doc("Quantity closed in this transaction")
  quantity: int32;

  @doc("When the transaction was created")
  createdAt: utcDateTime;

  @doc("When the transaction was last updated")
  updatedAt: utcDateTime;

  @doc("Item details at time of transaction")
  item: TransactionItem;

  @doc("User involved in the transaction (may not be present in all contexts)")
  user?: UserShort;
}

/**
 * Top orders response structure.
 */
model TopOrders {
  @doc("Top buy orders (highest prices, from online users)")
  buy: OrderWithUser[];

  @doc("Top sell orders (lowest prices, from online users)")
  sell: OrderWithUser[];
}

/**
 * Request body for creating an order.
 */
model CreateOrderRequest {
  @doc("ID of the item to create an order for")
  itemId: string;

  @doc("Order type: buy or sell")
  type: OrderType;

  @doc("Price in platinum (minimum: 1)")
  @minValue(1)
  platinum: int32;

  @doc("Quantity available (minimum: 1)")
  @minValue(1)
  quantity: int32;

  @doc("Whether the order should be visible")
  visible?: boolean = true;

  @doc("Minimum quantity per trade")
  @minValue(1)
  perTrade?: int32;

  @doc("Mod rank")
  @minValue(0)
  rank?: int32;

  @doc("Remaining charges")
  @minValue(0)
  charges?: int32;

  @doc("Item subtype")
  subtype?: string;

  @doc("Installed amber stars")
  @minValue(0)
  amberStars?: int32;

  @doc("Installed cyan stars")
  @minValue(0)
  cyanStars?: int32;
}

/**
 * Request body for updating an order.
 */
model UpdateOrderRequest {
  @doc("New price in platinum")
  @minValue(1)
  platinum?: int32;

  @doc("New quantity")
  @minValue(1)
  quantity?: int32;

  @doc("New minimum per trade")
  @minValue(1)
  perTrade?: int32;

  @doc("New mod rank")
  @minValue(0)
  rank?: int32;

  @doc("New charges count")
  @minValue(0)
  charges?: int32;

  @doc("New amber stars count")
  @minValue(0)
  amberStars?: int32;

  @doc("New cyan stars count")
  @minValue(0)
  cyanStars?: int32;

  @doc("New subtype")
  subtype?: string;

  @doc("New visibility state")
  visible?: boolean;
}

/**
 * Request body for closing an order.
 */
model CloseOrderRequest {
  @doc("Quantity to close (subtract from order)")
  @minValue(1)
  quantity: int32;
}

/**
 * Request body for updating a group of orders.
 */
model UpdateOrderGroupRequest {
  @doc("New visibility state for all orders in group")
  visible?: boolean;

  @doc("Target only specific order type")
  type?: OrderType;
}

/**
 * Response for group update operation.
 */
model UpdateOrderGroupResponse {
  @doc("Number of orders updated")
  updated: int32;
}
