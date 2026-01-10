namespace WarframeMarket.Models;

/**
 * I18n content for locations.
 */
model LocationI18nContent {
  @doc("Node name (e.g., Amarna)")
  nodeName: string;

  @doc("System name (e.g., Sedna)")
  systemName: string;

  @doc("Path to location icon")
  icon: string;

  @doc("Path to location thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for locations.
 */
model LocationI18n {
  en: LocationI18nContent;
}

/**
 * Game location/node model.
 */
@doc("In-game location/mission node")
model Location {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference")
  gameRef: string;

  @doc("Controlling faction")
  faction?: string;

  @doc("Minimum enemy level")
  minLevel?: int32;

  @doc("Maximum enemy level")
  maxLevel?: int32;

  @doc("Internationalized content")
  i18n: LocationI18n;
}

/**
 * I18n content for NPCs.
 */
model NpcI18nContent {
  @doc("Localized NPC name")
  name: string;

  @doc("Path to NPC icon")
  icon: string;

  @doc("Path to NPC thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for NPCs.
 */
model NpcI18n {
  en: NpcI18nContent;
}

/**
 * NPC model.
 */
@doc("Non-player character")
model Npc {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference")
  gameRef: string;

  @doc("Internationalized content")
  i18n: NpcI18n;
}

/**
 * I18n content for missions.
 */
model MissionI18nContent {
  @doc("Localized mission name")
  name: string;

  @doc("Path to mission icon")
  icon: string;

  @doc("Path to mission thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for missions.
 */
model MissionI18n {
  en: MissionI18nContent;
}

/**
 * Mission type model.
 */
@doc("Mission type definition")
model Mission {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference")
  gameRef: string;

  @doc("Internationalized content")
  i18n: MissionI18n;
}
