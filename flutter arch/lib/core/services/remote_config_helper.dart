// import 'dart:io';
//
// import 'package:firebase_remote_config/firebase_remote_config.dart';
//
// import '../connection/concept/end_points.dart';
// import '../utils/constant/app_store_links.dart';
// import '../utils/functions/print_state.dart';
//
// class RemoteConfigHelper {
//   static final remoteConfig = FirebaseRemoteConfig.instance;
//
//   // Parameter names as they are spelled in the Firebase console.
//   static const String keyBaseUrl = 'base_url';
//   static const String keyPaymentsEnabled = 'payments_enabled';
//   static const String keyMarketplacePaymentsEnabled =
//       'marketplace_payments_enabled';
//
//   /// Anything below this version cannot be used at all - the splash screen
//   /// blocks on a dialog that only offers "update now".
//   static const String keyMinimumVersion = 'minimum_version';
//
//   /// The newest version in the stores. Anything below it gets a dismissible
//   /// "an update is available" prompt, once per released version.
//   static const String keyLatestVersion = 'latest_version';
//
//   /// Store links, so a moved listing does not need an app release to fix.
//   /// Empty means "use the link compiled into the app".
//   static const String keyUpdateUrlAndroid = 'update_url_android';
//   static const String keyUpdateUrlIos = 'update_url_ios';
//
//   /// Optional copy overrides for the update dialogs. Empty means "use the
//   /// app's own translated text".
//   static const String keyUpdateTitle = 'update_title';
//   static const String keyUpdateMessage = 'update_message';
//
//   static Future<void> initialize() async {
//     await remoteConfig.setConfigSettings(
//       RemoteConfigSettings(
//         // Startup waits on the first fetch, so keep the ceiling low: a dead
//         // network must not hold the splash screen for a minute.
//         fetchTimeout: const Duration(seconds: 10),
//         minimumFetchInterval: const Duration(hours: 1),
//       ),
//     );
//
//     await remoteConfig.setDefaults({
//       keyBaseUrl: EndPoints.baseUrl,
//       // Kill switch for every payment flow. Defaults to off so a failed or
//       // slow fetch leaves payments closed rather than open; flip
//       // `payments_enabled` to true in the Firebase console to reopen them.
//       keyPaymentsEnabled: false,
//       // Marketplace orders pay through Fawry on server-built payloads and
//       // have their own switch, open by default.
//       keyMarketplacePaymentsEnabled: true,
//       // Defaults that gate nothing: an app that never reaches Firebase must
//       // keep working rather than lock itself out behind an update wall.
//       keyMinimumVersion: '0.0.0+0',
//       keyLatestVersion: '0.0.0+0',
//       keyUpdateUrlAndroid: '',
//       keyUpdateUrlIos: '',
//       keyUpdateTitle: '',
//       keyUpdateMessage: '',
//     });
//
//     await refresh();
//
//     printState('💳 Payments enabled: ${paymentsEnabled()}');
//
//     remoteConfig.onConfigUpdated.listen((event) async {
//       await remoteConfig.activate();
//     });
//   }
//
//   /// Fetches and activates the latest values, returning whether the call went
//   /// through. Firebase throttles to [minimumFetchInterval], so calling this
//   /// again on the splash screen is cheap; it mainly gives the fetch a second
//   /// chance when the one during startup timed out.
//   ///
//   /// Never throws - a failed refresh just leaves the previous (or default)
//   /// values in place.
//   static Future<bool> refresh() async {
//     try {
//       await remoteConfig.fetchAndActivate();
//       return true;
//     } catch (e) {
//       printState('⚠️ Remote Config refresh failed: $e');
//       return false;
//     }
//   }
//
//   static String getBaseUrl() {
//     final url = remoteConfig.getString(keyBaseUrl);
//     printState('🔗 Base URL from Remote Config: $url');
//     return url;
//   }
//
//   static String getMinimumVersion() =>
//       remoteConfig.getString(keyMinimumVersion);
//
//   static String getLatestVersion() => remoteConfig.getString(keyLatestVersion);
//
//   /// The store link for the running platform, falling back to the compiled-in
//   /// one when the console leaves the override empty.
//   static String getStoreUrl() {
//     final override = Platform.isAndroid
//         ? remoteConfig.getString(keyUpdateUrlAndroid)
//         : remoteConfig.getString(keyUpdateUrlIos);
//     if (override.trim().isNotEmpty) return override.trim();
//     return Platform.isAndroid ? AppStoreLinks.android : AppStoreLinks.ios;
//   }
//
//   /// Empty when the console sets no override; the caller then uses its own
//   /// translated copy.
//   static String getUpdateTitle() =>
//       remoteConfig.getString(keyUpdateTitle).trim();
//
//   static String getUpdateMessage() =>
//       remoteConfig.getString(keyUpdateMessage).trim();
//
//   /// Whether the app may start a payment. See `payments_enabled` above.
//   /// Read on every payment-button build, so it stays quiet — the value is
//   /// logged once in [initialize].
//   static bool paymentsEnabled() => remoteConfig.getBool(keyPaymentsEnabled);
//
//   /// Store orders (MOBILE_MARKETPLACE_API.md §7) — independent of
//   /// `payments_enabled`, which covers the membership payments.
//   static bool marketplacePaymentsEnabled() =>
//       remoteConfig.getBool(keyMarketplacePaymentsEnabled);
// }
