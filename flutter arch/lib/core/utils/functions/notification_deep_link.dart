// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:nidaa_khafia/nidaa_khafia_app.dart';
//
// import '../../../config/router/app_router_keys.dart';
//  import '../../../modules/pages/activities/model/activity_model.dart';
// import '../../../modules/pages/events/model/event_model.dart';
// import '../../../modules/pages/facilities/model/facility_model.dart';
// import '../../../modules/pages/news/model/news_model.dart';
// import '../../../modules/pages/reels/model/reel_model.dart';
// import '../../connection/concept/end_points.dart';
// import '../../connection/interfaces/api_consumer.dart';
// import 'router_handler.dart';
// import 'service_locator.dart';
//
// /// The screen a notification should land the user on.
// enum NotificationTarget {
//   marketplaceOrder,
//   news,
//   event,
//   activity,
//   facility,
//   reel,
//   membershipRequest,
//   membershipRenewal,
//   payment,
//   dependent,
//   notifications,
// }
//
// /// Turns the payload the backend attaches to a notification into an actual
// /// screen: it works out *what* the notification is about and *which* record it
// /// points at, loads that record, then pushes its detail route.
// ///
// /// Both halves are looked up across the aliases the backend may use rather than
// /// one hard-coded key, so a rename on the API side degrades to the list screen
// /// instead of a dead tap.
// class NotificationDeepLink {
//   NotificationDeepLink._();
//
//   /// Payload received before the navigator existed (see [open]).
//   static Map<String, dynamic>? _pending;
//
//   /// Fields that may carry the object type, most specific first.
//   static const List<String> _typeKeys = [
//     'related_object_type',
//     'object_type',
//     'target_type',
//     'content_type',
//     'model',
//     'notification_type',
//     'type',
//     'screen',
//     'route',
//   ];
//
//   /// Fields that may carry the linked record's id, most specific first.
//   /// Deliberately excludes a bare `id`, which on a list row is the
//   /// notification's own id — see [resolveId].
//   static const List<String> _idKeys = [
//     'related_object_id',
//     'object_id',
//     'target_id',
//     'data_id',
//     'entity_id',
//     'record_id',
//     'reference_id',
//     'item_id',
//   ];
//
//   /// Tokens that already read as singular despite the trailing `s`.
//   static const Set<String> _alreadySingular = {'news', 'status'};
//
//   /// Handles a tap on a notification, from a push or from the in-app list.
//   ///
//   /// Set [fromPush] for FCM payloads, where every key belongs to the data blob
//   /// the backend attached and a bare `id` therefore names the linked record.
//   static Future<void> open(
//     Map<String, dynamic>? data, {
//     bool fromPush = false,
//   }) async {
//     final payload = data ?? const <String, dynamic>{};
//
//     if (NidaaKhafiaApp.navigatorKey.currentContext == null) {
//       // Cold start: main() initialises notifications before runApp(), so a tap
//       // that launched the app arrives with no navigator. Hold it until the
//       // splash screen hands over via consumePending().
//       _pending = {...payload, _pushFlag: fromPush};
//       return;
//     }
//
//     await _navigate(payload, fromPush: fromPush);
//   }
//
//   /// Opens the notification that launched the app, if there was one.
//   /// Called once the app has settled on its first real screen.
//   static Future<void> consumePending() async {
//     final payload = _pending;
//     if (payload == null) return;
//     _pending = null;
//
//     final fromPush = payload[_pushFlag] == true;
//     await _navigate({...payload}..remove(_pushFlag), fromPush: fromPush);
//   }
//
//   static const String _pushFlag = '__from_push';
//
//   static Future<void> _navigate(
//     Map<String, dynamic> data, {
//     required bool fromPush,
//   }) async {
//     final target = resolveTarget(data);
//     final id = resolveId(data, fromPush: fromPush);
//
//     debugPrint(
//       'Notification tapped -> target: $target, id: "$id", data: $data',
//     );
//
//     switch (target) {
//       case NotificationTarget.marketplaceOrder:
//         // §10: `{type: marketplace_order, id, status}` opens the order, which
//         // loads itself fresh.
//         _push(
//           id.isEmpty ? AppRouterKeys.orders : AppRouterKeys.orderDetail,
//           extra: int.tryParse(id),
//         );
//
//       case NotificationTarget.news:
//         final news = await _fetchOne(EndPoints.news, id, NewsModel.fromJson);
//         _push(
//           news != null ? AppRouterKeys.newsDetail : AppRouterKeys.news,
//           extra: news,
//         );
//
//       case NotificationTarget.event:
//         final event = await _fetchOne(
//           EndPoints.events,
//           id,
//           EventModel.fromJson,
//         );
//         _push(
//           event != null ? AppRouterKeys.eventDetail : AppRouterKeys.events,
//           extra: event,
//         );
//
//       case NotificationTarget.activity:
//         final activity = await _fetchOne(
//           EndPoints.activities,
//           id,
//           ActivityModel.fromJson,
//         );
//         _push(
//           activity != null
//               ? AppRouterKeys.activityDetail
//               : AppRouterKeys.activities,
//           extra: activity,
//         );
//
//       case NotificationTarget.facility:
//         final facility = await _fetchOne(
//           EndPoints.facilities,
//           id,
//           FacilityModel.fromJson,
//         );
//         _push(
//           facility != null
//               ? AppRouterKeys.facilityDetail
//               : AppRouterKeys.facilities,
//           extra: facility,
//         );
//
//       case NotificationTarget.reel:
//         // The reels route opens on the given reel, or on the shuffled feed
//         // when we could not load it.
//         final reel = await _fetchOne(EndPoints.reels, id, ReelModel.fromJson);
//         _push(AppRouterKeys.reels, extra: reel);
//
//       case NotificationTarget.membershipRequest:
//         _push(AppRouterKeys.membershipRequests);
//
//       case NotificationTarget.membershipRenewal:
//         _push(AppRouterKeys.membershipRenewal);
//
//       case NotificationTarget.payment:
//         _push(AppRouterKeys.payments);
//
//       case NotificationTarget.dependent:
//         _push(AppRouterKeys.dependents);
//
//       case NotificationTarget.notifications:
//         _push(AppRouterKeys.notifications);
//     }
//   }
//
//   /// Works out which screen [data] is about by collecting every word the
//   /// payload uses to describe itself and matching known subjects against it.
//   static NotificationTarget resolveTarget(Map<String, dynamic> data) {
//     final tokens = <String>{};
//
//     for (final key in _typeKeys) {
//       final value = data[key];
//       if (value != null) tokens.addAll(_tokenize(value.toString()));
//     }
//
//     // A payload may name the subject through the key itself, e.g. `news_id`.
//     for (final key in data.keys) {
//       final lower = key.toLowerCase();
//       if (lower.endsWith('_id')) {
//         tokens.addAll(_tokenize(lower.substring(0, lower.length - 3)));
//       }
//     }
//
//     // Marketplace first: its payload also carries `status` and may mention
//     // payment.
//     if (tokens.contains('marketplace')) {
//       return NotificationTarget.marketplaceOrder;
//     }
//
//     // Renewal before membership: "membership_renewal" mentions both.
//     if (tokens.contains('news')) return NotificationTarget.news;
//     if (tokens.contains('event')) return NotificationTarget.event;
//     if (tokens.contains('activity')) return NotificationTarget.activity;
//     if (tokens.contains('facility')) return NotificationTarget.facility;
//     if (tokens.contains('reel')) return NotificationTarget.reel;
//     if (tokens.contains('dependent')) return NotificationTarget.dependent;
//     if (tokens.contains('renewal')) return NotificationTarget.membershipRenewal;
//     if (tokens.contains('invoice') ||
//         tokens.contains('payment') ||
//         tokens.contains('billing')) {
//       return NotificationTarget.payment;
//     }
//     if (tokens.contains('membership') || tokens.contains('request')) {
//       return NotificationTarget.membershipRequest;
//     }
//
//     return NotificationTarget.notifications;
//   }
//
//   /// The id of the record the notification points at, or `''` when the payload
//   /// carries none.
//   static String resolveId(Map<String, dynamic> data, {bool fromPush = false}) {
//     for (final key in _idKeys) {
//       final id = _cleanId(data[key]);
//       if (id.isNotEmpty) return id;
//     }
//
//     for (final entry in data.entries) {
//       final lower = entry.key.toLowerCase();
//       if (!lower.endsWith('_id') || lower == 'notification_id') continue;
//       final id = _cleanId(entry.value);
//       if (id.isNotEmpty) return id;
//     }
//
//     // On a push every key belongs to the attached data blob, so a bare `id`
//     // is the linked record. On a list row it is the notification's own id.
//     if (fromPush) return _cleanId(data['id']);
//
//     return '';
//   }
//
//   static String _cleanId(Object? value) {
//     final id = value?.toString().trim() ?? '';
//     if (id.isEmpty || id == 'null' || id == '0') return '';
//     return id;
//   }
//
//   /// Lowercased, singular words of [raw], splitting on separators and camelCase
//   /// so `MEMBERSHIP_REQUEST_STATUS_CHANGED`, `content.news` and `NewsModel` all
//   /// yield usable tokens.
//   static Iterable<String> _tokenize(String raw) {
//     final spaced = raw.replaceAllMapped(
//       RegExp(r'([a-z0-9])([A-Z])'),
//       (match) => '${match[1]}_${match[2]}',
//     );
//
//     return spaced
//         .toLowerCase()
//         .split(RegExp(r'[^a-z0-9]+'))
//         .where((token) => token.isNotEmpty)
//         .map(_singular);
//   }
//
//   static String _singular(String token) {
//     if (_alreadySingular.contains(token)) return token;
//     if (token.endsWith('ies')) {
//       return '${token.substring(0, token.length - 3)}y';
//     }
//     if (token.endsWith('s') && !token.endsWith('ss')) {
//       return token.substring(0, token.length - 1);
//     }
//     return token;
//   }
//
//   static Future<T?> _fetchOne<T>(
//     String collectionPath,
//     String id,
//     T Function(Map<String, dynamic>) fromJson,
//   ) async {
//     if (id.isEmpty) return null;
//
//     final response = await sl<ApiConsumer>().get('$collectionPath$id/');
//
//     return response.fold<T?>(
//       (failure) {
//         debugPrint(
//           'Notification deep link: $collectionPath$id/ failed -> $failure',
//         );
//         return null;
//       },
//       (success) {
//         final body = success.response;
//         if (body is Map<String, dynamic>) {
//           try {
//             return fromJson(body);
//           } catch (e) {
//             debugPrint(
//               'Notification deep link: could not parse $collectionPath$id/ -> $e',
//             );
//           }
//         }
//         return null;
//       },
//     );
//   }
//
//   static void _push(String route, {Object? extra}) {
//     final context = GwcsApp.navigatorKey.currentContext;
//     if (context == null || !context.mounted) return;
//     RouterHandler.navigate(context, route, extra: extra);
//   }
// }
