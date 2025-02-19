import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../service_locator/service_locator.dart';

class PrefsHelper {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool?> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sl<SharedPreferences>().setString(key, value);
    }
    if (value is int) return await sl<SharedPreferences>().setInt(key, value);
    if (value is bool) return await sl<SharedPreferences>().setBool(key, value);

    return await sl<SharedPreferences>().setDouble(key, value);
  }
  Future<void> clearTokenProperties() async {
    await sl<SharedPreferences>().remove(Constants.token);
    // await setToken('');
    // remove token from dio object stored in service locator
    sl<Dio>().options.headers['Authorization'] = '';
  }

  getData({
    required String key,
  }) {
    return sl<SharedPreferences>().get(key);
  }

  getToken() {
    return sl<SharedPreferences>().getString(Constants.token) ?? "";
  }
  getLang() {
    return sl<SharedPreferences>().getString(Constants.acceptLanguage) ?? "";
  }
  removeToken() {}

  Future<bool> disableOnboarding() async {
    return await sl<SharedPreferences>().setBool(Constants.onboarding, true);
  }

  bool getOnBoarding() {
    return sl<SharedPreferences>().getBool(Constants.onboarding) ?? false;
  }
  getRefreshToken() {
    return sl<SharedPreferences>().getString(Constants.refresh_token) ?? "";
  }

  // Future<void> clearAll() async {
  //   await sl<SharedPreferences>().clear();
  // }

}
