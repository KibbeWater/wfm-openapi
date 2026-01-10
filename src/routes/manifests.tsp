import "@typespec/http";
import "../common/headers.tsp";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/items.tsp";
import "../models/rivens.tsp";
import "../models/liches.tsp";
import "../models/sisters.tsp";
import "../models/world.tsp";
import "../models/users.tsp";

using TypeSpec.Http;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * Manifest and static data endpoints.
 * These endpoints provide access to game item data, weapons, and other static resources.
 */
@tag("Manifests")
@route("/v2")
namespace Manifests {
  /**
   * Get current resource versions.
   * 
   * Returns version numbers for all server resources. Client applications can check
   * this endpoint periodically to detect when data has been updated and needs to be
   * re-downloaded.
   */
  @summary("Get resource versions")
  @get
  @route("/versions")
  op getVersions(): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Versions>;
  };

  /**
   * Get all tradable items.
   * 
   * Returns a list of all tradable items in shortened format, suitable for building
   * a local item cache.
   */
  @summary("Get all tradable items")
  @get
  @route("/items")
  op getItems(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<ItemShort[]>;
  };

  /**
   * Get item details.
   * 
   * Returns full details for a specific item.
   */
  @summary("Get item by slug")
  @get
  @route("/item/{slug}")
  op getItem(
    @path slug: string,
    ...TranslatableHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Item>;
  } | NotFoundError;

  /**
   * Get item set.
   * 
   * Returns all items in a set. If the item is not part of a set, returns an array
   * containing only that item.
   */
  @summary("Get item set")
  @get
  @route("/item/{slug}/set")
  op getItemSet(
    @path slug: string,
    ...TranslatableHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<ItemSet>;
  } | NotFoundError;

  /**
   * Get all riven weapons.
   * 
   * Returns a list of all weapons that can have riven mods.
   */
  @summary("Get all riven weapons")
  @get
  @route("/riven/weapons")
  op getRivenWeapons(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Riven[]>;
  };

  /**
   * Get riven weapon details.
   */
  @summary("Get riven weapon by slug")
  @get
  @route("/riven/weapon/{slug}")
  op getRivenWeapon(
    @path slug: string,
    ...TranslatableHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Riven>;
  } | NotFoundError;

  /**
   * Get all riven attributes.
   * 
   * Returns all possible attributes/stats that can appear on riven mods.
   */
  @summary("Get all riven attributes")
  @get
  @route("/riven/attributes")
  op getRivenAttributes(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<RivenAttribute[]>;
  };

  /**
   * Get all Kuva Lich weapons.
   */
  @summary("Get all lich weapons")
  @get
  @route("/lich/weapons")
  op getLichWeapons(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<LichWeapon[]>;
  };

  /**
   * Get Kuva Lich weapon details.
   */
  @summary("Get lich weapon by slug")
  @get
  @route("/lich/weapon/{slug}")
  op getLichWeapon(
    @path slug: string,
    ...TranslatableHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<LichWeapon>;
  } | NotFoundError;

  /**
   * Get all Kuva Lich ephemeras.
   */
  @summary("Get all lich ephemeras")
  @get
  @route("/lich/ephemeras")
  op getLichEphemeras(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<LichEphemera[]>;
  };

  /**
   * Get all Kuva Lich quirks.
   */
  @summary("Get all lich quirks")
  @get
  @route("/lich/quirks")
  op getLichQuirks(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<LichQuirk[]>;
  };

  /**
   * Get all Sister of Parvos weapons.
   */
  @summary("Get all sister weapons")
  @get
  @route("/sister/weapons")
  op getSisterWeapons(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<SisterWeapon[]>;
  };

  /**
   * Get Sister of Parvos weapon details.
   */
  @summary("Get sister weapon by slug")
  @get
  @route("/sister/weapon/{slug}")
  op getSisterWeapon(
    @path slug: string,
    ...TranslatableHeaders
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<SisterWeapon>;
  } | NotFoundError;

  /**
   * Get all Sister of Parvos ephemeras.
   */
  @summary("Get all sister ephemeras")
  @get
  @route("/sister/ephemeras")
  op getSisterEphemeras(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<SisterEphemera[]>;
  };

  /**
   * Get all Sister of Parvos quirks.
   */
  @summary("Get all sister quirks")
  @get
  @route("/sister/quirks")
  op getSisterQuirks(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<SisterQuirk[]>;
  };

  /**
   * Get all locations.
   * 
   * Returns all in-game locations known to warframe.market.
   */
  @summary("Get all locations")
  @get
  @route("/locations")
  op getLocations(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Location[]>;
  };

  /**
   * Get all NPCs.
   * 
   * Returns all NPCs known to warframe.market.
   */
  @summary("Get all NPCs")
  @get
  @route("/npcs")
  op getNpcs(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Npc[]>;
  };

  /**
   * Get all missions.
   * 
   * Returns all mission types known to warframe.market.
   */
  @summary("Get all missions")
  @get
  @route("/missions")
  op getMissions(...TranslatableHeaders): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Mission[]>;
  };
}
