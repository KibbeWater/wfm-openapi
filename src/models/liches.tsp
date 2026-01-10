namespace WarframeMarket.Models;

/**
 * I18n content for lich weapons.
 */
model LichWeaponI18nContent {
  @doc("Localized weapon name")
  name: string;

  @doc("Link to the Warframe wiki page")
  wikiLink?: string;

  @doc("Path to weapon icon")
  icon: string;

  @doc("Path to weapon thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for lich weapons.
 */
model LichWeaponI18n {
  en: LichWeaponI18nContent;
}

/**
 * Kuva Lich weapon model.
 */
@doc("Kuva Lich weapon")
model LichWeapon {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference path")
  gameRef: string;

  @doc("Required mastery rank")
  reqMasteryRank?: int32;

  @doc("Internationalized content")
  i18n: LichWeaponI18n;
}

/**
 * I18n content for lich ephemeras.
 */
model LichEphemeraI18nContent {
  @doc("Localized ephemera name")
  name: string;

  @doc("Path to ephemera icon")
  icon: string;

  @doc("Path to ephemera thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for lich ephemeras.
 */
model LichEphemeraI18n {
  en: LichEphemeraI18nContent;
}

/**
 * Kuva Lich ephemera model.
 */
@doc("Kuva Lich ephemera cosmetic")
model LichEphemera {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference path")
  gameRef: string;

  @doc("Path to animation preview (webp)")
  animation?: string;

  @doc("Associated element")
  element?: string;

  @doc("Internationalized content")
  i18n: LichEphemeraI18n;
}

/**
 * I18n content for lich quirks.
 */
model LichQuirkI18nContent {
  @doc("Localized quirk name")
  name: string;

  @doc("Localized quirk description")
  description?: string;
}

/**
 * I18n wrapper for lich quirks.
 */
model LichQuirkI18n {
  en: LichQuirkI18nContent;
}

/**
 * Kuva Lich quirk/personality model.
 */
@doc("Kuva Lich personality quirk")
model LichQuirk {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Quirk group for categorization")
  group?: string;

  @doc("Internationalized content")
  i18n: LichQuirkI18n;
}
