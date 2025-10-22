// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// class RemoteUpdateChecker {
//   static Future<void> checkForUpdate(BuildContext context) async {
//     final remoteConfig = FirebaseRemoteConfig.instance;
//
//     await remoteConfig.setConfigSettings(RemoteConfigSettings(
//       fetchTimeout: const Duration(seconds: 10),
//       minimumFetchInterval: const Duration(hours: 1),
//     ));
//
//     await remoteConfig.fetchAndActivate();
//
//     final latestVersion = remoteConfig.getString('latest_version');
//     final forceUpdate = remoteConfig.getBool('force_update');
//     final updateUrl = remoteConfig.getString('update_url');
//     final updateMessage = remoteConfig.getString('update_message');
//
//     final packageInfo = await PackageInfo.fromPlatform();
//     final currentVersion = packageInfo.version;
//
//     bool needsUpdate = _isVersionLower(currentVersion, latestVersion);
//
//     if (needsUpdate) {
//       _showUpdateDialog(context, updateMessage, updateUrl, forceUpdate);
//     }
//   }
//
//   static bool _isVersionLower(String current, String latest) {
//     // إزالة أي شيء بعد علامة + أو - (زي 1.0.0+1 أو 1.0.0-beta)
//     current = current.split(RegExp(r'[\+\-]')).first;
//     latest = latest.split(RegExp(r'[\+\-]')).first;
//
//     // تقسيم الإصدار إلى أجزاء رقمية فقط
//     List<int> currentParts = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
//     List<int> latestParts = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
//
//     for (int i = 0; i < latestParts.length; i++) {
//       if (i >= currentParts.length || currentParts[i] < latestParts[i]) return true;
//       if (currentParts[i] > latestParts[i]) return false;
//     }
//     return false;
//   }
//
//
//
//   static void _showUpdateDialog(
//       BuildContext context, String message, String url, bool forceUpdate) {
//     showDialog(
//       context: context,
//       barrierDismissible: !forceUpdate,
//       builder: (context) => AlertDialog(
//         title: const Text("تحديث جديد متاح 🔄"),
//         content: Text(message, textDirection: TextDirection.rtl),
//         actions: [
//           if (!forceUpdate)
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("لاحقًا"),
//             ),
//           ElevatedButton(
//             onPressed: () async {
//               final uri = Uri.parse(url);
//               if (await canLaunchUrl(uri)) {
//                 await launchUrl(uri, mode: LaunchMode.externalApplication);
//               }
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
//             child: const Text("تحديث الآن"),
//           ),
//         ],
//       ),
//     );
//   }
// }
