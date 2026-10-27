// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../components/image_item.dart';
// import '../../services/package_info_helper.dart';
// import '../../services/remote_config_helper.dart';
// import '../constant/app_colors.dart';
// import '../constant/app_enums.dart';
// import '../constant/app_images.dart';
// import '../constant/app_strings.dart';
// import '../constant/storage_keys.dart';
// import 'responsive.dart';
// import 'shared_preferance_utils.dart';
//
// class AppVersionChecker {
//   const AppVersionChecker._();
//
//   /// Compares the running build against `minimum_version` and
//   /// `latest_version`. Reads already-activated Remote Config values, so call
//   /// [RemoteConfigHelper.refresh] first when freshness matters.
//   static AppUpdateStatus status() {
//     final current =
//         '${PackageInfoHelper.version}+${PackageInfoHelper.buildNumber}';
//     final minimum = RemoteConfigHelper.getMinimumVersion();
//     final latest = RemoteConfigHelper.getLatestVersion();
//
//     debugPrint('📦 Version: $current | minimum: $minimum | latest: $latest');
//
//     if (_isLower(current, minimum)) return AppUpdateStatus.forced;
//     if (_isLower(current, latest)) return AppUpdateStatus.optional;
//     return AppUpdateStatus.upToDate;
//   }
//
//   static Future<bool> isUpdateRequired() async =>
//       status() == AppUpdateStatus.forced;
//
//   /// Whether the user already said "later" to this exact `latest_version`.
//   static bool isOptionalUpdateDismissed() {
//     final dismissed = PreferenceUtils.getString(
//       StorageKeys.dismissedUpdateVersion,
//     );
//     return dismissed.isNotEmpty &&
//         dismissed == RemoteConfigHelper.getLatestVersion();
//   }
//
//   static Future<void> dismissOptionalUpdate() async {
//     await PreferenceUtils.setString(
//       StorageKeys.dismissedUpdateVersion,
//       RemoteConfigHelper.getLatestVersion(),
//     );
//   }
//
//   /// `major.minor.patch+build`, compared left to right. A missing part counts
//   /// as 0, so a console value of `1.2.0` (no build number) still compares
//   /// sensibly instead of silently disabling the gate.
//   static bool _isLower(String current, String other) {
//     final a = _parse(current);
//     final b = _parse(other);
//     for (var i = 0; i < a.length; i++) {
//       if (a[i] < b[i]) return true;
//       if (a[i] > b[i]) return false;
//     }
//     return false;
//   }
//
//   static List<int> _parse(String version) {
//     final parts = version.trim().split('+');
//     final numbers = parts.first
//         .split('.')
//         .map((part) => int.tryParse(part.trim()) ?? 0)
//         .toList();
//     while (numbers.length < 3) {
//       numbers.add(0);
//     }
//     final build = parts.length > 1 ? int.tryParse(parts[1].trim()) ?? 0 : 0;
//     return [...numbers.take(3), build];
//   }
//
//   /// Blocking: no dismiss, no back button, the only way out is the store.
//   static Future<void> showMustUpdateDialog(BuildContext context) =>
//       _showUpdateDialog(context, forced: true);
//
//   /// Dismissible: the user may continue into the app.
//   static Future<void> showOptionalUpdateDialog(BuildContext context) =>
//       _showUpdateDialog(context, forced: false);
//
//   static Future<void> _showUpdateDialog(
//     BuildContext context, {
//     required bool forced,
//   }) {
//     final remoteTitle = RemoteConfigHelper.getUpdateTitle();
//     final remoteMessage = RemoteConfigHelper.getUpdateMessage();
//
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (dialogContext) {
//         return PopScope(
//           canPop: !forced,
//           child: AlertDialog(
//             backgroundColor: Colors.transparent,
//             contentPadding: EdgeInsets.zero,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14.radius),
//             ),
//             content: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(14.radius),
//                 color: Colors.white,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20.width,
//                         vertical: 16.height,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryColor,
//                         borderRadius: BorderRadius.circular(16.radius),
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColors.primaryColor.withValues(
//                               alpha: 0.22,
//                             ),
//                             blurRadius: 14,
//                             spreadRadius: 1,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: ImageItem(
//                         AppImages.logosg,
//                         width: 120.width,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     SizedBox(height: 16.height),
//                     Text(
//                       remoteTitle.isNotEmpty
//                           ? remoteTitle
//                           : (forced
//                                 ? AppStrings.updateRequiredTitle
//                                 : AppStrings.updateAvailableTitle),
//                       style: TextStyle(
//                         color: AppColors.primaryColor,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 20.fontSize,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 12.height),
//                     Text(
//                       remoteMessage.isNotEmpty
//                           ? remoteMessage
//                           : (forced
//                                 ? AppStrings.updateRequiredMessage
//                                 : AppStrings.updateAvailableMessage),
//                       style: TextStyle(
//                         color: AppColors.bodyTextColor,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16.fontSize,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 20.height),
//                     ElevatedButton.icon(
//                       onPressed: _openStore,
//                       icon: const Icon(Icons.update, color: Colors.white),
//                       label: Text(
//                         AppStrings.updateNow,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17.fontSize,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                       ),
//                     ),
//                     if (!forced) ...[
//                       SizedBox(height: 4.height),
//                       TextButton(
//                         onPressed: () => Navigator.of(dialogContext).pop(),
//                         child: Text(
//                           AppStrings.updateLater,
//                           style: TextStyle(
//                             color: AppColors.bodyTextColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 15.fontSize,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static Future<void> _openStore() async {
//     final url = Uri.parse(RemoteConfigHelper.getStoreUrl());
//
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url, mode: LaunchMode.externalApplication);
//     } else {
//       debugPrint('❌ Could not launch $url');
//     }
//   }
// }
