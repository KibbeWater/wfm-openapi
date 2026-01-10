namespace WarframeMarket.Models;

/**
 * I18n content for riven weapons.
 */
model RivenI18nContent {
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
 * I18n wrapper for riven weapons.
 */
model RivenI18n {
  en: RivenI18nContent;
}

/**
 * Riven weapon model.
 */
@doc("Riven mod weapon with disposition and type information")
model Riven {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference path")
  gameRef: string;

  @doc("Weapon group for frontend categorization")
  group: string;

  @doc("Riven mod type (determines available attributes)")
  rivenType: RivenType;

  @doc("Riven disposition (affects stat ranges, 0.5-1.55)")
  disposition: float32;

  @doc("Required mastery rank")
  reqMasteryRank?: int32;

  @doc("Internationalized content")
  i18n: RivenI18n;
}

/**
 * I18n content for riven attributes.
 */
model RivenAttributeI18nContent {
  @doc("Localized attribute name")
  name: string;

  @doc("Path to attribute icon")
  icon: string;

  @doc("Path to attribute thumbnail")
  thumb: string;
}

/**
 * I18n wrapper for riven attributes.
 */
model RivenAttributeI18n {
  en: RivenAttributeI18nContent;
}

/**
 * Riven attribute (stat) model.
 */
@doc("Riven mod attribute/stat definition")
model RivenAttribute {
  @doc("Unique identifier")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Internal game reference")
  gameRef: string;

  @doc("Attribute group for categorization")
  group: string;

  @doc("Prefix used in riven names when positive")
  prefix: string;

  @doc("Suffix used in riven names when negative")
  suffix: string;

  @doc("Weapon types this attribute can appear on")
  exclusiveTo?: RivenType[];

  @doc("Whether a positive value is actually negative (e.g., recoil)")
  positiveIsNegative?: boolean;

  @doc("Whether this attribute can only be positive")
  positiveOnly?: boolean;

  @doc("Whether this attribute can only be negative")
  negativeOnly?: boolean;

  @doc("Unit of measurement (e.g., percent, flat)")
  unit?: string;

  @doc("Internationalized content")
  i18n: RivenAttributeI18n;
}
