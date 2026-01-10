namespace WarframeMarket.Models;

/**
 * Supported gaming platforms.
 */
enum Platform {
  pc,
  ps4,
  xbox,
  @doc("Nintendo Switch") `switch`,
  mobile,
}

/**
 * Supported languages for translations.
 */
enum Language {
  @doc("English") en,
  @doc("Korean") ko,
  @doc("Russian") ru,
  @doc("German") de,
  @doc("French") fr,
  @doc("Portuguese") pt,
  @doc("Simplified Chinese") `zh-hans`,
  @doc("Traditional Chinese") `zh-hant`,
  @doc("Spanish") es,
  @doc("Italian") it,
  @doc("Polish") pl,
  @doc("Ukrainian") uk,
}

/**
 * User online status.
 */
enum Status {
  @doc("User is offline") offline,
  @doc("User is online on the website") online,
  @doc("User is online and in-game") ingame,
  @doc("User appears offline but is connected") invisible,
}

/**
 * User activity type.
 */
enum ActivityType {
  UNKNOWN,
  IDLE,
  ON_MISSION,
  IN_DOJO,
  IN_ORBITER,
  IN_RELAY,
}

/**
 * User role on the site.
 */
enum Role {
  user,
  moderator,
  admin,
}

/**
 * Subscription tier.
 */
enum Tier {
  none,
  bronze,
  silver,
  gold,
  diamond,
}

/**
 * OAuth access scopes.
 */
enum Scope {
  me,
  profile,
  settings,
  contracts,
  ledger,
  reviews,
  status,
  activity,
  realTime,
  all,
}

/**
 * Order type - buy or sell.
 */
enum OrderType {
  @doc("User wants to buy") buy,
  @doc("User wants to sell") sell,
}

/**
 * Riven weapon type.
 */
enum RivenType {
  kitgun,
  melee,
  pistol,
  rifle,
  shotgun,
  zaw,
}

/**
 * Item rarity.
 */
enum Rarity {
  common,
  uncommon,
  rare,
  legendary,
}

/**
 * Element type for ephemeras.
 */
enum Element {
  impact,
  heat,
  cold,
  electricity,
  toxin,
  magnetic,
  radiation,
}

/**
 * Achievement type.
 */
enum AchievementType {
  patreon,
  github,
  custom,
}

/**
 * UI theme preference.
 */
enum Theme {
  light,
  dark,
  system,
}
