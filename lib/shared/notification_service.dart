// import 'dart:convert';
// import 'dart:io';
//
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// import 'constants.dart';
//
//
//
// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
// class NotificationService {
//   static cancelTrackingLocationNotification() async {
//     await flutterLocalNotificationsPlugin
//         .cancel(-1); // ID of the notification to cancel
//   }
//
//
//
//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//     const AndroidInitializationSettings("@mipmap/launcher_icon");
//
//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//
//         requestSoundPermission: true
//         // onDidReceiveLocalNotification:
//         //     (int id, String? title, String? body, String? payload) async {
//         //   final notificationData = jsonDecode(payload??'');
//         //   debugPrint(
//         //       '--------------------- onDidReceiveLocalNotification: this function fires when the user clicks on a notification when the app is in foreground  $notificationData-----------------------');
//         //
//         // }
//         );
//
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//
//     await listenToFirebaseMessages(flutterLocalNotificationsPlugin);
//   }
//
//   Future<void> listenToFirebaseMessages(flutterLocalNotificationsPlugin) async {
//     // listen to firebase messaging and then fire local notification when the app is in foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       // await showNotification(message, flutterLocalNotificationsPlugin);
//
//       // RemoteNotification? notification = message.notification;
//       // AndroidNotification? androidNotification = message.notification?.android;
//       // AppleNotification? appleNotification = message.notification?.apple;
//       // // If `onMessage` is triggered with a notification, construct our own
//       // // local notification to show to users using the created channel.
//       // if (notification != null && (androidNotification != null|| appleNotification!=null)) {
//       //   NotificationService()
//       //       .showLocalNotification(message,flutterLocalNotificationsPlugin);
//       //
//       // }
//     });
//   }
//
//   // ownerRideNotification({required String notificationType})async{
//   //   if(notificationType == Constants.newTripNotification || notificationType == Constants.newTripNotification){}
//   //
//   // }
//
//
//   void onDidReceiveNotificationResponse(NotificationResponse response) async {
//     // this function fires when the user clicks on a notification when the app is in foreground
//     // use this function to handle clicks when the app is in foreground and the user clicks on the notification
//     debugPrint(
//         '--------------------- onDidReceiveNotificationResponse: this function fires when the user clicks on a notification when the app is in foreground -----------------------');
//
//     final notificationType = jsonDecode(response.payload!)['type'];
//     if(notificationType==''){
//
//     }
//     // navigate with navigator key instead
//
//   }
//
//
//
//   Future<void> showLocalNotification(RemoteMessage message,
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       message.notification?.body ?? '',
//       contentTitle: message.notification?.title,
//       htmlFormatBigText: true,
//       htmlFormatContentTitle: true,
//     );
//
//     // setup Android local notification details
//     String channelId = Constants.notificationChannelId;
//     String channelName = Constants.notificationChannelName;
//
//     await flutterLocalNotificationsPlugin.show(
//
//       0,
//       message.notification!.title,
//       // show when notification is minimized
//       message.notification!.body ?? '',
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channelId,
//           channelName,
//           importance: Importance.high,
//           // show when notification is expanded
//           styleInformation: bigTextStyleInformation,
//           priority: Priority.high,
//           playSound: true,
//         ),
//       ),
//       payload: jsonEncode(message.data),
//
//
//     );
//   }
//
//   Future<void> requestFCMPermissions() async {
//     FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//     NotificationSettings notificationSettings =
//     await firebaseMessaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         announcement: false,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false);
//     if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.authorized) {
//       debugPrint(
//           '---------------- requestFCMPermissions: user granted auth ------------------');
//     } else if (notificationSettings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       debugPrint(
//           '---------------- requestFCMPermissions: user grant provisional permission ----------------');
//     } else {
//       debugPrint(
//           '---------------- requestFCMPermissions: user did not grant permission ----------------');
//     }
//   }
//
// // handle notification in foreground
//   void handleNotificationInForeground() {
//     // only works if app in foreground
//     // this function works automatically when the app is in foreground and receives a notification
//     // so don't handle foreground notification clicks here
//     // use onDidReceiveNotificationResponse() instead
//     FirebaseMessaging.onMessage.listen((message) {
//       debugPrint(
//           '----------------- handleNotificationInForeground: notification title: ${message.notification?.title} notification body: ${message.notification?.body} -----------------');
//       showLocalNotification(message, flutterLocalNotificationsPlugin);
//     });
//   }
//
// // handle notification in background
//
//   Future<void> handleNotificationInBackground() async {
//     FirebaseMessaging.onMessageOpenedApp.listen((message)async {
//       debugPrint(
//           '------------- handleNotificationInBackground: ${message.data} -------------');
//
//     });
//   }
//
// // handle notification in terminated
//   void handleNotificationInTerminated() async{
//     // only works when app is terminated (first start)
//     // this function calls when the user clicks on a notification when the app is terminated
//     // this function doesn't fire automatically when the app receives a notification
//     // it requires the user to click on the notification to fire this function, so handle terminated notification clicks here
//     FirebaseMessaging.instance.getInitialMessage().then((message) async{
//       if (message != null) {
//         debugPrint('------------- handleNotificationInTerminated ${message.data}------------');
//
//       }
//     });
//   }
//
//   //  _navigateToTheRightScreen({
//   //   required String notificationType,
//   //     Map<String,dynamic>? json,
//   // }) async{
//   //   // navigate with navigator key instead
//   //    if(notificationType == Constants.newMessageNotification && json != null){
//   //       RoomResponse roomResponse = RoomResponse.fromNotification(json: json);
//   //        GoRouter.of(AppRouter.parentNavigatorKey.currentContext!).pushNamed(RoutesManager.chatWithInstructorScreen,extra: roomResponse);
//   //    }/*else if(notificationType == Constants.gradeAddedNotification){
//   //       // GoRouter.of(AppRouter.parentNavigatorKey.currentContext!).pushNamed(RoutesManager.gradeScreen);
//   //    } else if(){
//   //
//   //    } else if(){
//   //
//   //    }*/
//   // }
//
//   static Future<String> fcmToken() async {
//     // Get the token each time the application loads
//     String? token =Platform.isIOS ? await FirebaseMessaging.instance.getAPNSToken(): await FirebaseMessaging.instance.getToken();
//     print('fcm token $token');
//     return token ?? "";
//     // Save the initial token to the database
//     // await saveTokenToDatabase(token!);
//
//     // Any time the token refreshes, store this in the database too.
//     // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
//   }
//
//   static String deviceType() {
//     if (Platform.isIOS) {
//       return "ios";
//     } else if (Platform.isAndroid) {
//       return "android";
//     } else {
//       return "";
//     }
//   }
// }
