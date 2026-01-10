namespace WarframeMarket.Models;

/**
 * I18n content for sister weapons.
 */
model SisterWeaponI18nContent {
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
 * I18n wrapper for sister weapons.
 */
model SisterWeaponI18n {
  en: SisterWeaponI18nContent;
}

/**
 * Sister of Parvos weapon model.
 */
@doc("Sister of Parvos (Tenet) weapon")
model SisterWeapon {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference path")
  gameRef: string;

  @doc("Required mastery rank")
  reqMasteryRank?: int32;

  @doc("Internationalized content")
  i18n: SisterWeaponI18n;
}

/**
 * I18n content for sister ephemeras.
 */
model SisterEphemeraI18nContent {
  @doc("Localized ephemera name")
  name: string;

  @doc("Path to ephemera icon")
  icon: string;

  @doc("Path to ephemera thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for sister ephemeras.
 */
model SisterEphemeraI18n {
  en: SisterEphemeraI18nContent;
}

/**
 * Sister of Parvos ephemera model.
 */
@doc("Sister of Parvos ephemera cosmetic")
model SisterEphemera {
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
  i18n: SisterEphemeraI18n;
}

/**
 * I18n content for sister quirks.
 */
model SisterQuirkI18nContent {
  @doc("Localized quirk name")
  name: string;

  @doc("Localized quirk description")
  description?: string;
}

/**
 * I18n wrapper for sister quirks.
 */
model SisterQuirkI18n {
  en: SisterQuirkI18nContent;
}

/**
 * Sister of Parvos quirk/personality model.
 */
@doc("Sister of Parvos personality quirk")
model SisterQuirk {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Quirk group for categorization")
  group?: string;

  @doc("Internationalized content")
  i18n: SisterQuirkI18n;
}
