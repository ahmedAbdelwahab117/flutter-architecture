import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constant/app_enums.dart';
import '../constant/storage_keys.dart'; 

class HandleMultiCallLocal {
  static const _storage = FlutterSecureStorage();

  String? _accessToken;
  String? _refreshToken;
  String? _userName;
  String? _userEmail;
  String? _userPhone;
 
  Future<void> saveLocalData({
    required String? data,
    required LocalEnumKey keyType,
  }) async {
    switch (keyType) {
      case LocalEnumKey.accessToken:
        _accessToken = data;
        await _storage.write(key: StorageKeys.accessToken, value: data);
        break;

      case LocalEnumKey.refreshToken:
        _refreshToken = data;
        await _storage.write(key: StorageKeys.refreshToken, value: data);
        break;

      case LocalEnumKey.userName:
        _userName = data;
        await _storage.write(key: StorageKeys.userName, value: data);
        break;
      
      case LocalEnumKey.userEmail:
        _userEmail = data;
        await _storage.write(key: StorageKeys.userEmail, value: data);
        break;
      
      case LocalEnumKey.userPhone:
        _userPhone = data;
        await _storage.write(key: StorageKeys.userPhone, value: data);
        break;
    }
  }

  Future<String?> getLocalData({required LocalEnumKey keyType}) async {
    switch (keyType) {
      case LocalEnumKey.accessToken:
        _accessToken ??= await _storage.read(key: StorageKeys.accessToken);
        return _accessToken;

      case LocalEnumKey.refreshToken:
        _refreshToken ??= await _storage.read(key: StorageKeys.refreshToken);
        return _refreshToken;

      case LocalEnumKey.userName:
        _userName ??= await _storage.read(key: StorageKeys.userName);
        return _userName;

      case LocalEnumKey.userEmail:
        _userEmail ??= await _storage.read(key: StorageKeys.userEmail);
        return _userEmail;

      case LocalEnumKey.userPhone:
        _userPhone ??= await _storage.read(key: StorageKeys.userPhone);
        return _userPhone;
    }
  }

  Future<void> clear() async {
    _accessToken = null;
    _refreshToken = null;
    _userName = null;
    _userEmail = null;
    _userPhone = null;
 
    await _storage.delete(key: StorageKeys.accessToken);
    await _storage.delete(key: StorageKeys.refreshToken);
    await _storage.delete(key: StorageKeys.userName);
    await _storage.delete(key: StorageKeys.userEmail);
    await _storage.delete(key: StorageKeys.userPhone);
  }
}
