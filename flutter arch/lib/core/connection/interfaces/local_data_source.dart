abstract class LocalDataSource {
  Future<bool> setData({
    required String key,
    required dynamic value,
  });
  dynamic getData(String key);
  String getToken();
  String getRefreshToken();
  Future<bool> disableOnboarding();
  bool getOnBoarding();
  Future removeToken();
  Future removeRefreshToken();
}




















