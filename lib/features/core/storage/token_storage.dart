import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> savePreAuthToken(String token) async {
    await _storage.write(key: "pre_auth_token", value: token);
  }

  Future<String?> getPreAuthToken() async {
    return await _storage.read(key: "pre_auth_token");
  }

  Future<void> saveUserToken(String token) async {
    await _storage.write(key: "user_token", value: token);
  }

  Future<String?> getUserToken() async {
    return await _storage.read(key: "user_token");
  }

  Future<void> saveDeviceId(String deviceId) async {
    await _storage.write(key: "device_id", value: deviceId);
  }

  Future<String?> getDeviceId() async {
    return await _storage.read(key: "device_id");
  }
  Future<void> deleteUserToken() async {
  await _storage.delete(key: "user_token");
}
}
