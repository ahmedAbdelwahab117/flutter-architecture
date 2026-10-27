import 'package:flutter/material.dart';
import 'package:nidaa_khafia/nidaa_khafia_app.dart';

import '../../../config/router/app_router_keys.dart';
 import '../constant/app_enums.dart';
import '../constant/storage_keys.dart';
import 'callback_token.dart';
import 'common_fun.dart';
import 'router_handler.dart';
import 'service_locator.dart';
import 'shared_preferance_utils.dart';

Future logOut({String? msg, bool isUseLogoutApi = false}) async {
  if (msg != null) {
    showToast(msg, state: ToastStates.error);
  }

  if (isUseLogoutApi) {
    // final String? refreshToken = await sl
    //     .get<HandleMultiCallLocal>()
    //     .getLocalData(keyType: LocalEnumKey.refreshToken);
    // final String? accessToken = await sl
    //     .get<HandleMultiCallLocal>()
    //     .getLocalData(keyType: LocalEnumKey.accessToken);
    // if (accessToken != null && accessToken.isNotEmpty) {
    //   await sl.get<ApiConsumer>().post(
    //     EndPoints.logout,
    //     body: {'refresh': refreshToken ?? ''},
    //   );
    // }
  }


  // Clear Secure Storage
  await sl.get<HandleMultiCallLocal>().clear();

  // Completely wipe all cached SharedPreferences except for the onboarding status
  final bool onboardingSeen = PreferenceUtils.getBool(
    StorageKeys.onboardingSeen,
  );
  await PreferenceUtils.clearAll();

  if (onboardingSeen) {
    await PreferenceUtils.setBool(StorageKeys.onboardingSeen, true);
  }

  final BuildContext? context = NidaaKhafiaApp.navigatorKey.currentContext;
  if (context != null && context.mounted) {
    RouterHandler.navigate(
      context,
      AppRouterKeys.login,
      routerType: RouterType.pushReplacementNamed,
    );
  }
}
