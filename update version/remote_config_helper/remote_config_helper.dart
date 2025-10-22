import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../constants.dart';

class RemoteConfigHelper {
  static final remoteConfig = FirebaseRemoteConfig.instance;

   // initialize remote config
   static Future<void> initialize() async {
     final remoteConfig = FirebaseRemoteConfig.instance;

     // Set configuration
     await remoteConfig.setConfigSettings(
       RemoteConfigSettings(
         fetchTimeout: const Duration(minutes: 1),
         minimumFetchInterval: const Duration(hours: 1),


       ),
     );

     // These will be used before the values are fetched from Firebase Remote Config.
     await remoteConfig.setDefaults(const {
       Constants.requiredMinimumAppBuild: 1,
       Constants.recommendedMinimumAppBuild: 1,
        'base_url': 'https://hb-backend.sass.cyparta.com/',
        'address': 'hb-backend.sass.cyparta.com',
     });

     // Fetch the values from Firebase Remote Config
     await remoteConfig.fetchAndActivate();

     // Optional: listen for and activate changes to the Firebase Remote Config values
     remoteConfig.onConfigUpdated.listen((event) async {
       await remoteConfig.activate();
     });
   }
   static   String getBaseUrl() {
     final url = remoteConfig.getString('base_url');
     print('🔗 Base URL from Remote Config: $url');
     return url;
   }

 static  String getAddressUrl() {
     final url = remoteConfig.getString('address');
     print('🔗 adress URL from Remote Config: $url');
     return url;
   }
   // Helper methods to simplify using the values in other parts of the code
   int getRequiredMinimumAppBuild() =>
       remoteConfig.getInt(Constants.requiredMinimumAppBuild);

   int getRecommendedMinimumAppBuild() =>
       remoteConfig.getInt(Constants.recommendedMinimumAppBuild);
}