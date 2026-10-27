import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoHelper {
  static int buildNumber = -1;
  static String version = '';

  static Future<void> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = int.tryParse(packageInfo.buildNumber) ?? -1;
  }
}
