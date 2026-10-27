import 'package:nidaa_khafia/core/utils/constant/app_strings.dart';
import 'package:nidaa_khafia/core/utils/constant/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interfaces/local_data_source.dart';


class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences prefsHelper;
  LocalDataSourceImpl({required this.prefsHelper});

  @override
  Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await prefsHelper.setString(key, value);
    } else if (value is int) {
      return await prefsHelper.setInt(key, value);
    } else if (value is bool) {
      return await prefsHelper.setBool(key, value);
    } else if (value is double) {
      return await prefsHelper.setDouble(key, value);
    } else if (value is List<String>) {
      return await prefsHelper.setStringList(key, value);
    } else {
      return false;
    }
  }

  @override
  dynamic getData(String key) {
    return prefsHelper.get(key) ?? "";
  }

  @override
  String getToken() {
    return prefsHelper.getString(StorageKeys.accessToken) ?? "";
  }

  @override
  String getRefreshToken() {
    return prefsHelper.getString(StorageKeys.refreshToken) ?? "";
  }

  @override
  Future<bool> disableOnboarding() async {
    return await prefsHelper.setBool(AppStrings.onBoarding, true);
  }

  @override
  bool getOnBoarding() {
    return prefsHelper.getBool(AppStrings.onBoarding) ?? false;
  }

  @override
  Future removeToken() async {
    await prefsHelper.remove(StorageKeys.accessToken);
  }

  @override
  Future removeRefreshToken() async {
    await prefsHelper.remove(StorageKeys.refreshToken);
  }
}












