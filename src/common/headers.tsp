import "@typespec/http";

using TypeSpec.Http;

namespace WarframeMarket.Common;

/**
 * Language header for requesting additional translations.
 * Supported: ko, ru, de, fr, pt, zh-hans, zh-hant, es, it, pl, uk, en
 */
model LanguageHeader {
  @doc("Request translations in addition to English. Supported: ko, ru, de, fr, pt, zh-hans, zh-hant, es, it, pl, uk, en")
  @header("Language")
  language?: string = "en";
}

/**
 * Platform header for filtering content by gaming platform.
 */
model PlatformHeader {
  @doc("Gaming platform. Supported: pc, ps4, xbox, switch, mobile")
  @header("Platform")
  platform?: string = "pc";
}

/**
 * Crossplay header for including/excluding cross-play orders.
 */
model CrossplayHeader {
  @doc("Include cross-play orders from other platforms")
  @header("Crossplay")
  crossplay?: boolean = true;
}

/**
 * Combined headers for platform-dependent endpoints.
 */
model PlatformHeaders {
  ...PlatformHeader;
  ...CrossplayHeader;
}

/**
 * Combined headers for translatable endpoints.
 */
model TranslatableHeaders {
  ...LanguageHeader;
}

/**
 * All global headers combined.
 */
model GlobalHeaders {
  ...LanguageHeader;
  ...PlatformHeader;
  ...CrossplayHeader;
}
