// import 'dart:async';
// import 'dart:io';
// import 'dart:ui';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// class CrashlyticsCollector {
//   static bool _isFontLoadingError(Object error, [StackTrace? stack]) {
//     final msg = error.toString().toLowerCase();
//     return msg.contains('google_fonts') ||
//         msg.contains('fonts.gstatic') ||
//         msg.contains('unable to load font') ||
//         msg.contains('failed to load font');
//   }
//
//   void setup() {
//     FlutterError.onError = (details) async {
//       if (_isFontLoadingError(details.exception)) return; // skip font errors
//       await _setCrashlyticsCustomKeys();
//       unawaited(FirebaseCrashlytics.instance.recordFlutterError(details));
//     };
//
//     PlatformDispatcher.instance.onError = (error, stack) {
//       if (_isFontLoadingError(error, stack)) return true; // skip font errors
//       _setCrashlyticsCustomKeys().then((_) {
//         FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//       });
//       return true;
//     };
//
//     ErrorWidget.builder = (details) {
//       FirebaseCrashlytics.instance.recordError(
//         details.exception,
//         details.stack,
//         fatal: true,
//       );
//       return ErrorWidget(details.exception);
//     };
//   }
//
//   Future<void> _setCrashlyticsCustomKeys() async {
//     final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
//     unawaited(FirebaseCrashlytics.instance.setCustomKey('error_time', now));
//
//     try {
//       final info = await PackageInfo.fromPlatform();
//       unawaited(
//           FirebaseCrashlytics.instance.setCustomKey('app_name', info.appName));
//       unawaited(FirebaseCrashlytics.instance.setCustomKey(
//         'package_name',
//         info.packageName,
//       ));
//       unawaited(
//           FirebaseCrashlytics.instance.setCustomKey('version', info.version));
//       unawaited(FirebaseCrashlytics.instance.setCustomKey(
//         'build_number',
//         info.buildNumber,
//       ));
//     } catch (_) {}
//
//     final deviceInfo = DeviceInfoPlugin();
//     try {
//       if (Platform.isAndroid) {
//         final androidInfo = await deviceInfo.androidInfo;
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'device_model',
//           androidInfo.model,
//         ));
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'device_brand',
//           androidInfo.brand,
//         ));
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'android_version',
//           androidInfo.version.release,
//         ));
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'android_sdk',
//           androidInfo.version.sdkInt,
//         ));
//       } else if (Platform.isIOS) {
//         final iosInfo = await deviceInfo.iosInfo;
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'device_model',
//           iosInfo.utsname.machine,
//         ));
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'ios_version',
//           iosInfo.systemVersion,
//         ));
//         unawaited(FirebaseCrashlytics.instance
//             .setCustomKey('device_name', iosInfo.name));
//         unawaited(FirebaseCrashlytics.instance.setCustomKey(
//           'system_name',
//           iosInfo.systemName,
//         ));
//       }
//     } catch (_) {}
//   }
//
//   Future<void> logApiError({
//     required String url,
//     String? method,
//     int? statusCode,
//     String? requestBody,
//     String? responseBody,
//     dynamic error,
//   }) async {
//     await _setCrashlyticsCustomKeys();
//
//     unawaited(FirebaseCrashlytics.instance.setCustomKey('api_url', url));
//     if (method != null) {
//       unawaited(
//           FirebaseCrashlytics.instance.setCustomKey('api_method', method));
//     }
//     if (statusCode != null) {
//       unawaited(
//           FirebaseCrashlytics.instance.setCustomKey('status_code', statusCode));
//     }
//     if (requestBody != null) {
//       unawaited(FirebaseCrashlytics.instance
//           .setCustomKey('request_body', requestBody));
//     }
//     if (responseBody != null) {
//       unawaited(FirebaseCrashlytics.instance
//           .setCustomKey('response_body', responseBody));
//     }
//
//     unawaited(FirebaseCrashlytics.instance.recordError(
//       error ?? 'Unknown API error',
//       null,
//       reason: 'API call failed: $method $url',
//       fatal: false,
//     ));
//   }
// }
// /*
// How Use It
//  CrashlyticsCollector().setup(); in main
//  In Interceptor Error
//    await CrashlyticsCollector().logApiError(
//             url: e.requestOptions.uri.toString(),
//             method: e.requestOptions.method,
//             statusCode: e.response?.statusCode,
//             requestBody: e.requestOptions.data?.toString(),
//             responseBody: e.response?.data?.toString(),
//             error: e,
//           );
//  */
