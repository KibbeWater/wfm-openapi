namespace WarframeMarket.Models;

/**
 * User activity information.
 */
@doc("Current user activity in-game")
model Activity {
  @doc("Activity type")
  type: ActivityType;

  @doc("Activity details (e.g., mission name, max 64 chars)")
  details?: string;

  @doc("When the activity started")
  startedAt?: utcDateTime;
}

/**
 * Shortened user model for embedding in other responses.
 */
@doc("Brief user information")
model UserShort {
  @doc("Unique user identifier")
  id: string;

  @doc("In-game name")
  ingameName: string;

  @doc("Path to user avatar")
  avatar?: string;

  @doc("User reputation score")
  reputation: int32;

  @doc("Preferred locale")
  locale: string;

  @doc("Primary gaming platform")
  platform: Platform;

  @doc("Whether cross-play is enabled")
  crossplay: boolean;

  @doc("Current online status")
  status: Status;

  @doc("Current in-game activity")
  activity?: Activity;

  @doc("Last seen timestamp")
  lastSeen?: utcDateTime;
}

/**
 * Achievement display information.
 */
model AchievementDisplay {
  @doc("Achievement ID")
  id: string;

  @doc("Path to achievement icon")
  icon: string;

  @doc("Path to achievement thumbnail")
  thumb: string;

  @doc("Achievement type")
  type: AchievementType;

  @doc("Internationalized content")
  i18n: AchievementI18n;
}

/**
 * I18n content for achievements.
 */
model AchievementI18nContent {
  @doc("Achievement name")
  name: string;

  @doc("Achievement description")
  description: string;

  @doc("Path to achievement icon")
  icon?: string;

  @doc("Path to achievement thumbnail")
  thumb?: string;
}

/**
 * I18n wrapper for achievements.
 */
model AchievementI18n {
  en: AchievementI18nContent;
}

/**
 * Public user profile.
 */
@doc("Public user profile")
model User {
  @doc("Unique user identifier")
  id: string;

  @doc("In-game name")
  ingameName: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Path to user avatar")
  avatar?: string;

  @doc("Path to profile background")
  background?: string;

  @doc("Profile description (HTML allowed)")
  about?: string;

  @doc("User reputation score")
  reputation: int32;

  @doc("In-game mastery rank")
  masteryLevel?: int32;

  @doc("Primary gaming platform")
  platform: Platform;

  @doc("Whether cross-play is enabled")
  crossplay: boolean;

  @doc("Preferred locale")
  locale: string;

  @doc("Featured achievements on profile")
  achievementShowcase?: AchievementDisplay[];

  @doc("Current online status")
  status: Status;

  @doc("Current in-game activity")
  activity?: Activity;

  @doc("Last seen timestamp")
  lastSeen?: utcDateTime;

  @doc("Whether the user is banned")
  banned?: boolean;

  @doc("Ban expiration time")
  banUntil?: utcDateTime;

  @doc("Ban reason message")
  banMessage?: string;

  @doc("Whether the user has an active warning")
  warned?: boolean;

  @doc("Warning message")
  warnMessage?: string;
}

/**
 * Private user profile (only visible to the user themselves).
 */
@doc("Private user profile with settings")
model UserPrivate {
  ...User;

  @doc("User email address")
  email?: string;

  @doc("User role on the site")
  role: Role;

  @doc("Subscription tier")
  tier?: Tier;

  @doc("UI theme preference")
  theme?: Theme;

  @doc("Whether to sync locale across devices")
  syncLocale?: boolean;

  @doc("Whether to sync theme across devices")
  syncTheme?: boolean;

  @doc("Whether account is verified")
  verified?: boolean;

  @doc("OAuth scopes granted")
  scopes?: Scope[];
}

/**
 * Request body for updating user profile.
 */
model UpdateUserRequest {
  @doc("Profile description")
  about?: string;

  @doc("Primary platform")
  platform?: Platform;

  @doc("Cross-play enabled")
  crossplay?: boolean;

  @doc("Preferred locale")
  locale?: Language;

  @doc("UI theme")
  theme?: Theme;

  @doc("Sync locale across devices")
  syncLocale?: boolean;

  @doc("Sync theme across devices")
  syncTheme?: boolean;
}

/**
 * Achievement progress state.
 */
model AchievementState {
  @doc("Whether achievement is featured on profile")
  featured: boolean;

  @doc("Current progress toward goal")
  progress: int32;

  @doc("When the achievement was completed")
  completedAt?: utcDateTime;
}

/**
 * Full achievement model.
 */
@doc("Achievement definition with progress")
model Achievement {
  @doc("Achievement ID")
  id: string;

  @doc("URL-friendly identifier")
  slug: string;

  @doc("Achievement type")
  type: AchievementType;

  @doc("Goal to complete the achievement")
  goal?: int32;

  @doc("Internationalized content")
  i18n: AchievementI18n;

  @doc("User's progress state (only present for user-specific queries)")
  state?: AchievementState;
}

/**
 * Dashboard showcase item.
 */
model DashboardShowcaseItem {
  @doc("Item ID")
  item: string;

  @doc("Path to background image")
  background: string;

  @doc("Whether to display as a large card")
  bigCard: boolean;
}

/**
 * I18n content for dashboard showcase.
 */
model DashboardShowcaseI18nContent {
  @doc("Showcase title")
  title: string;

  @doc("Showcase description")
  description: string;
}

/**
 * I18n wrapper for dashboard showcase.
 */
model DashboardShowcaseI18n {
  en: DashboardShowcaseI18nContent;
}

/**
 * Dashboard showcase model (for mobile app home screen).
 */
@doc("Featured items showcase for dashboard")
model DashboardShowcase {
  @doc("Internationalized content")
  i18n: DashboardShowcaseI18n;

  @doc("Featured items")
  items: DashboardShowcaseItem[];
}

/**
 * Version information for resources.
 */
model Versions {
  @doc("App versions")
  apps: AppVersions;

  @doc("Collection versions (base64 encoded)")
  collections: CollectionVersions;

  @doc("When versions were last updated")
  updatedAt: utcDateTime;
}

/**
 * Mobile app version requirements.
 */
model AppVersions {
  @doc("Latest iOS version")
  ios: string;

  @doc("Latest Android version")
  android: string;

  @doc("Minimum supported iOS version")
  minIos: string;

  @doc("Minimum supported Android version")
  minAndroid: string;
}

/**
 * Collection version hashes for cache invalidation.
 */
model CollectionVersions {
  @doc("Items collection version")
  items: string;

  @doc("Rivens collection version")
  rivens: string;

  @doc("Liches collection version")
  liches: string;

  @doc("Sisters collection version")
  sisters: string;

  @doc("Missions collection version")
  missions: string;

  @doc("NPCs collection version")
  npcs: string;

  @doc("Locations collection version")
  locations: string;
}
