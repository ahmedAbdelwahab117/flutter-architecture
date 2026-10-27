import 'package:flutter/material.dart';
import 'package:nidaa_khafia/nidaa_khafia_app.dart';

import 'core/services/package_info_helper.dart';
// import 'core/utils/functions/crashlytics_collector.dart';
// import 'core/utils/functions/notification_services.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/shared_preferance_utils.dart';
import 'core/utils/functions/translation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // CrashlyticsCollector().setup();
  // await RemoteConfigHelper.initialize();
  await PackageInfoHelper.initialize();
  debugPrint(
    '🚀 Current Version: ${PackageInfoHelper.version}+${PackageInfoHelper.buildNumber}',
  );
  // debugPrint(
  //   '📦 Minimum Version from Firebase: ${RemoteConfigHelper.getMinimumVersion()}',
  // );

  await Future.wait([
    PreferenceUtils.init(),
    initScreenUtils(),
    initLocalization(),
    intiService(),
  ]);
  // await NotificationServices.initialize();
  runApp(localization(const NidaaKhafiaApp()));
}
