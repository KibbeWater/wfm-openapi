import "@typespec/http";
import "../common/responses.tsp";
import "../common/errors.tsp";
import "../models/users.tsp";

using TypeSpec.Http;
using WarframeMarket.Common;
using WarframeMarket.Models;

namespace WarframeMarket;

/**
 * Achievement endpoints.
 */
@tag("Achievements")
@route("/v2")
namespace Achievements {
  /**
   * Get all achievements.
   * 
   * Returns a list of all available achievements.
   */
  @summary("Get all achievements")
  @get
  @route("/achievements")
  op getAchievements(): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Achievement[]>;
  };

  /**
   * Get user's achievements.
   * 
   * Returns all achievements for a specific user, including their progress.
   */
  @summary("Get user achievements")
  @get
  @route("/achievements/user/{slug}")
  op getUserAchievements(
    @path slug: string
  ): {
    @statusCode statusCode: 200;
    @body body: SuccessResponse<Achievement[]>;
  } | NotFoundError;
}
