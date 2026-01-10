import "@typespec/http";
import "@typespec/openapi";
import "../common/headers.tsp";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/orders.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * Order management endpoints.
 * Handle browsing, creating, updating, and deleting trade orders.
 */
@tag("Orders")
@route("/v2")
namespace Orders {
  /**
   * Get recent orders.
   * 
   * Returns the most recent orders (max 500) from the last 4 hours, sorted by creation time.
   * Results are cached with a 1-minute refresh interval.
   * 
   * Content depends on Platform and Crossplay headers.
   */
  @summary("Get recent orders")
  @get
  @route("/orders/recent")
  op getRecentOrders(...PlatformHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<OrderWithUser[]>;
  };

  /**
   * Get orders for an item.
   * 
   * Returns all orders for a specific item from users who were online in the last 7 days.
   * 
   * Content depends on Platform and Crossplay headers.
   */
  @summary("Get orders for item")
  @get
  @route("/orders/item/{slug}")
  op getOrdersForItem(
    @path slug: string,
    ...PlatformHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<OrderWithUser[]>;
  } | NotFoundError;

  /**
   * Get top orders for an item.
   * 
   * Returns the top 5 buy and top 5 sell orders for a specific item, exclusively from
   * online users. Orders are sorted by price.
   * 
   * Content depends on Platform and Crossplay headers.
   */
  @summary("Get top orders for item")
  @get
  @route("/orders/item/{slug}/top")
  op getTopOrdersForItem(
    @path slug: string,
    @query rank?: int32,
    @query rankLt?: int32,
    @query charges?: int32,
    @query chargesLt?: int32,
    @query amberStars?: int32,
    @query amberStarsLt?: int32,
    @query cyanStars?: int32,
    @query cyanStarsLt?: int32,
    @query subtype?: string,
    ...PlatformHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<TopOrders>;
  } | NotFoundError;

  /**
   * Get orders for a user by slug.
   * 
   * Returns all public orders from a specific user.
   */
  @summary("Get orders for user")
  @get
  @route("/orders/user/{slug}")
  op getOrdersForUser(
    @path slug: string
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Order[]>;
  } | NotFoundError;

  /**
   * Get current user's orders.
   * 
   * Returns all orders for the authenticated user.
   * 
   * Requires authentication.
   */
  @summary("Get my orders")
  @get
  @route("/orders/my")
  @useAuth(Http.BearerAuth)
  op getMyOrders(): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Order[]>;
  } | UnauthorizedError;

  /**
   * Get order by ID.
   * 
   * Returns details for a specific order.
   */
  @summary("Get order by ID")
  @get
  @route("/order/{id}")
  op getOrder(
    @path id: string
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<OrderWithUser>;
  } | NotFoundError;

  /**
   * Create a new order.
   * 
   * Creates a new buy or sell order for an item.
   * 
   * Requires authentication.
   */
  @summary("Create order")
  @post
  @route("/order")
  @useAuth(Http.BearerAuth)
  op createOrder(
    @body body: CreateOrderRequest
  ): {
    @statusCode statusCode: 201;
    @body body: SuccessResponse<Order>;
  } | BadRequestError | UnauthorizedError;

  /**
   * Update an order.
   * 
   * Updates an existing order's properties.
   * 
   * Requires authentication.
   */
  @summary("Update order")
  @patch
  @route("/order/{id}")
  @useAuth(Http.BearerAuth)
  op updateOrder(
    @path id: string,
    @body body: UpdateOrderRequest
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Order>;
  } | BadRequestError | UnauthorizedError | NotFoundError | ForbiddenError;

  /**
   * Delete an order.
   * 
   * Deletes an existing order.
   * 
   * Requires authentication.
   */
  @summary("Delete order")
  @delete
  @route("/order/{id}")
  @useAuth(Http.BearerAuth)
  op deleteOrder(
    @path id: string
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Order>;
  } | UnauthorizedError | NotFoundError | ForbiddenError;

  /**
   * Close an order (partial or full).
   * 
   * Closes a portion or all of an existing order. If you close a quantity of 8 from
   * an order with quantity 20, the remaining quantity will be 12. Closing the entire
   * remaining quantity removes the order.
   * 
   * Requires authentication.
   */
  @summary("Close order")
  @post
  @route("/order/{id}/close")
  @useAuth(Http.BearerAuth)
  op closeOrder(
    @path id: string,
    @body body: CloseOrderRequest
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Transaction>;
  } | BadRequestError | UnauthorizedError | NotFoundError | ForbiddenError;

  /**
   * Update a group of orders.
   * 
   * Updates visibility or other properties for all orders in a group.
   * Available groups: 'all', 'ungrouped'.
   * 
   * Requires authentication.
   */
  @summary("Update order group")
  @patch
  @route("/orders/group/{id}")
  @useAuth(Http.BearerAuth)
  op updateOrderGroup(
    @doc("Group ID: 'all' or 'ungrouped'")
    @path id: string,
    @body body: UpdateOrderGroupRequest
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<UpdateOrderGroupResponse>;
  } | BadRequestError | UnauthorizedError;
}
