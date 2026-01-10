namespace WarframeMarket.Models;

/**
 * Internationalized content for items.
 */
model ItemI18nContent {
  @doc("Localized item name")
  name: string;

  @doc("Path to item icon (relative to static assets base URL)")
  icon: string;

  @doc("Path to item thumbnail")
  thumb: string;

  @doc("Path to sub-icon (e.g., blueprint indicator)")
  subIcon?: string;
}

/**
 * Extended i18n content with description and wiki link.
 */
model ItemI18nContentFull {
  ...ItemI18nContent;

  @doc("Localized item description")
  description?: string;

  @doc("Link to the Warframe wiki page")
  wikiLink?: string;
}

/**
 * I18n wrapper containing translations.
 * Always contains 'en', may contain additional language based on Language header.
 */
model ItemI18n {
  @doc("English translation (always present)")
  en: ItemI18nContent;
}

/**
 * Full i18n wrapper with descriptions.
 */
model ItemI18nFull {
  @doc("English translation (always present)")
  en: ItemI18nContentFull;
}

/**
 * Shortened item model used for item listings.
 */
@doc("Trimmed item model for building local item lists")
model ItemShort {
  @doc("Unique item identifier")
  id: string;

  @doc("URL-friendly item identifier")
  slug: string;

  @doc("Internal game reference path")
  gameRef: string;

  @doc("Item categorization tags")
  tags: string[];

  @doc("Internationalized content")
  i18n: ItemI18n;

  @doc("Maximum mod rank (if applicable)")
  maxRank?: int32;

  @doc("Maximum charges (e.g., for parazon mods)")
  maxCharges?: int32;

  @doc("Whether the item is vaulted")
  vaulted?: boolean;

  @doc("Ducat value when sold to Baro Ki'Teer")
  ducats?: int32;

  @doc("Maximum amber stars (for Ayatan sculptures)")
  amberStars?: int32;

  @doc("Maximum cyan stars (for Ayatan sculptures)")
  cyanStars?: int32;

  @doc("Base endo value")
  baseEndo?: int32;

  @doc("Endo multiplier per rank")
  endoMultiplier?: float32;

  @doc("Available subtypes (e.g., blueprint, crafted)")
  subtypes?: string[];
}

/**
 * Full item model with all details.
 */
@doc("Complete item model with all available fields")
model Item {
  @doc("Unique item identifier")
  id: string;

  @doc("URL-friendly item identifier")
  slug: string;

  @doc("Internal game reference path")
  gameRef: string;

  @doc("Whether the item can be traded")
  tradable: boolean;

  @doc("Item categorization tags")
  tags: string[];

  @doc("Internationalized content with descriptions")
  i18n: ItemI18nFull;

  @doc("Item rarity")
  rarity?: Rarity;

  @doc("Maximum mod rank")
  maxRank?: int32;

  @doc("Maximum charges")
  maxCharges?: int32;

  @doc("Whether multiple items can be traded at once")
  bulkTradable?: boolean;

  @doc("Available subtypes")
  subtypes?: string[];

  @doc("Maximum amber stars")
  maxAmberStars?: int32;

  @doc("Maximum cyan stars")
  maxCyanStars?: int32;

  @doc("Base endo value")
  baseEndo?: int32;

  @doc("Endo multiplier per rank")
  endoMultiplier?: float32;

  @doc("Ducat value")
  ducats?: int32;

  @doc("Required mastery rank to trade")
  reqMasteryRank?: int32;

  @doc("Whether the item is vaulted")
  vaulted?: boolean;

  @doc("Trading tax in credits")
  tradingTax?: int32;

  @doc("Whether this item is the root of a set")
  setRoot?: boolean;

  @doc("Item IDs that are part of this set")
  setParts?: string[];

  @doc("Quantity of this item in its set")
  quantityInSet?: int32;
}

/**
 * Response for item set endpoint.
 */
model ItemSet {
  @doc("ID of the requested item")
  id: string;

  @doc("All items in the set (or just the single item if not part of a set)")
  items: Item[];
}
