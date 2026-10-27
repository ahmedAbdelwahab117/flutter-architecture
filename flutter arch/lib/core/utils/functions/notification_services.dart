// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../constant/app_enums.dart';
// import '../post_fcm/model/post_fcm_request.dart';
// import '../post_fcm/post_fcm.dart';
// import 'callback_token.dart';
// import 'notification_deep_link.dart';
// import 'service_locator.dart';
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   if (kDebugMode) {
//     print('Handling a background message: ${message.messageId}');
//   }
// }
//
// class NotificationServices {
//   static const String _androidNotificationIcon = '@drawable/ic_notification';
//   static const String _androidNotificationLargeIcon =
//       '@drawable/ic_notification_large';
//   static const Color _androidNotificationColor = Color(0xFF0B5138);
//
//   static final FirebaseMessaging _firebaseMessaging =
//       FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(_androidNotificationIcon);
//     const DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings();
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: initializationSettingsDarwin,
//         );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (response) {
//         if (kDebugMode) {
//           print('Notification clicked with id: ${response.id}');
//         }
//         if (response.payload != null) {
//           final Map<String, dynamic> data = json.decode(response.payload!);
//           _handleNotificationClick(data);
//         }
//       },
//     );
//
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'high_importance_channel',
//       'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.high,
//     );
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);
//
//     await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (kDebugMode) {
//         print('Got a message whilst in the foreground!');
//         print('Message data: ${message.data}');
//       }
//       _showForegroundNotification(message);
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       _handleNotificationClick(message.data);
//     });
//
//     final RemoteMessage? initialMessage =
//         await FirebaseMessaging.instance.getInitialMessage();
//     if (initialMessage != null) {
//       _handleNotificationClick(initialMessage.data);
//     }
//
//     _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
//       registerDevice(fcmToken: fcmToken);
//     });
//
//     await registerDeviceIfLoggedIn();
//   }
//
//   static Future<bool> requestPermissionAndRegister() async {
//     final granted = await _requestNotificationPermission();
//     if (granted) {
//       await registerDevice();
//     }
//     return granted;
//   }
//
//   static Future<void> registerDeviceIfLoggedIn() async {
//     if (!await _isLoggedIn()) return;
//     if (!await _hasNotificationPermission()) return;
//     await registerDevice();
//   }
//
//   static Future<bool> _requestNotificationPermission() async {
//     if (Platform.isAndroid) {
//       final status = await Permission.notification.request();
//       if (kDebugMode) {
//         print('Android notification permission: $status');
//       }
//       return status.isGranted;
//     }
//
//     final settings = await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (kDebugMode) {
//       print('iOS notification permission: ${settings.authorizationStatus}');
//     }
//
//     return settings.authorizationStatus == AuthorizationStatus.authorized ||
//         settings.authorizationStatus == AuthorizationStatus.provisional;
//   }
//
//   static Future<bool> _hasNotificationPermission() async {
//     if (Platform.isAndroid) {
//       return Permission.notification.isGranted;
//     }
//
//     final settings = await _firebaseMessaging.getNotificationSettings();
//     return settings.authorizationStatus == AuthorizationStatus.authorized ||
//         settings.authorizationStatus == AuthorizationStatus.provisional;
//   }
//
//   static Future<void> registerDevice({String? fcmToken}) async {
//     if (!await _isLoggedIn()) return;
//
//     try {
//       final token = fcmToken ?? await _firebaseMessaging.getToken();
//       if (token == null || token.isEmpty) return;
//
//       if (kDebugMode) {
//         print('FCM Token: $token');
//       }
//
//       final model = PostFcmRequestModel(fcmToken: token);
//       await postFcmMethod(model: model);
//     } catch (e) {
//       if (kDebugMode) {
//         print('Failed to register FCM token: $e');
//       }
//     }
//   }
//
//   static Future<bool> _isLoggedIn() async {
//     final accessToken = await sl<HandleMultiCallLocal>().getLocalData(
//       keyType: LocalEnumKey.accessToken,
//     );
//     return accessToken != null && accessToken.isNotEmpty;
//   }
//
//   static void _showForegroundNotification(RemoteMessage message) {
//     final notification = message.notification;
//     if (notification != null) {
//       showLocalNotification(
//         title: notification.title ?? 'إشعار جديد',
//         body: notification.body ?? '',
//         data: message.data,
//       );
//       return;
//     }
//
//     if (message.data.isNotEmpty) {
//       showLocalNotification(
//         title: message.data['title']?.toString() ?? 'إشعار جديد',
//         body: message.data['body']?.toString() ??
//             message.data['message']?.toString() ??
//             '',
//         data: message.data,
//       );
//     }
//   }
//
//   static void showLocalNotification({
//     required String title,
//     required String body,
//     required Map<String, dynamic> data,
//   }) {
//     flutterLocalNotificationsPlugin.show(
//        DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       payload: json.encode(data),
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           channelDescription:
//               'This channel is used for important notifications.',
//           importance: Importance.high,
//           priority: Priority.high,
//           icon: _androidNotificationIcon,
//           color: _androidNotificationColor,
//           largeIcon:  DrawableResourceAndroidBitmap(
//             _androidNotificationLargeIcon,
//           ),
//         ),
//         iOS:  DarwinNotificationDetails(),
//       ),
//     );
//   }
//
//   static void _handleNotificationClick(Map<String, dynamic> data) {
//     // Resolves the record the backend linked in the payload and opens its
//     // screen; falls back to the notifications list when there is nothing to
//     // open. Safe before runApp() too — the payload is buffered until the
//     // splash screen calls NotificationDeepLink.consumePending().
//     NotificationDeepLink.open(data, fromPush: true);
//   }
// }
