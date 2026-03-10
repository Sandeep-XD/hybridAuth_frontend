import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:frontend/features/core/constants/api_constants.dart';
import 'package:frontend/features/core/network/dio_client.dart';
import 'package:frontend/features/core/storage/token_storage.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final DioClient client;
  final TokenStorage storage;

  AuthRepositoryImpl(this.client, this.storage);

  /// STEP 1
  @override
  Future<String> initAuth() async {
    final deviceId = await storage.getDeviceId() ?? const Uuid().v4();
    await storage.saveDeviceId(deviceId);

    final response = await client.dio.post(
      ApiConstants.authInit,
      options: Options(
        headers: {
          "X-Device-Id": deviceId,
          "X-Client-Type": "WEB",
          "Content-Type": "application/json",
        },
      ),
    );

    final token = response.data['data']['accessToken'];

    await savePreAuthToken(token);

    client.dio.options.headers['Authorization'] = "Bearer $token";

    return token;
  }

  /// STEP 2
  @override
  Future<void> savePreAuthToken(String token) async {
    print("Saving pre auth token");
    await storage.savePreAuthToken(token);
  }

  /// STEP 3
  @override
  Future<Map<String, dynamic>> initSession(String authType) async {
    print("Calling initSession with authType: $authType");
    final response = await client.dio.post(
      ApiConstants.sessionInit,
      data: {"authType": authType},
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await storage.getPreAuthToken()}",
        },
      ),
    );

    print("initSession response: ${response.data}");
    return response.data['data'];
  }

  /// STEP 4
  @override
  Future<Map<String, dynamic>> identifyUser(
    String mobile,
    String pan,
    String dob,
    String sessionId,
  ) async {
    print("Calling identifyUser with sessionId: $sessionId");
    final data = {
      "mobile": mobile,
      "sessionId": sessionId,
      if (pan.isNotEmpty) "pan": pan else "dob": dob,
    };
    final response = await client.dio.post(ApiConstants.identify, data: data);

    print("identifyUser response: ${response.data}");
    return response.data["data"];
  }

  /// STEP 5
  @override
  Future<Map<String, dynamic>> generateQr(String sessionId) async {
    print("Calling generateQr with sessionId: $sessionId");
    final response = await client.dio.post(
      ApiConstants.qrGenerate,
      queryParameters: {"sessionId": sessionId},
      options: Options(
        headers: {"Authorization": "Bearer ${await storage.getPreAuthToken()}"},
      ),
    );

    print("generateQr response: ${response.data}");
    final data = response.data['data'];

    print("QR GENERATED → $data");

    return data;
  }

  /// STEP 6
  @override
  Future<String> fetchSession(String sessionId) async {
    print("Calling fetchSession with sessionId: $sessionId");
    final response = await client.dio.post(
      ApiConstants.sessionFetch,
      queryParameters: {"sessionId": sessionId},
      options: Options(
        headers: {"Authorization": "Bearer ${await storage.getPreAuthToken()}"},
      ),
    );

    print("fetchSession response: ${response.data}");
    return response.data['data']['status'];
  }

  /// STEP 7
  @override
  Future<String> exchangeToken(String sessionId) async {
    print("Calling exchangeToken with sessionId: $sessionId");
    final response = await client.dio.post(
      ApiConstants.authToken,
      data: {"sessionId": sessionId},
    );

    print("exchangeToken response: ${response.data}");
    return response.data['data']['accessToken'];
  }

  /// STEP 8
  @override
  Future<void> saveUserToken(String token) async {
    print("Saving user token");
    await storage.saveUserToken(token);
  }

  /// Get stored user token
  @override
  Future<String?> getSavedUserToken() async {
    return await storage.getUserToken();
  }

  /// Clear user token
  @override
  Future<void> clearUserToken() async {
    await storage.deleteUserToken(); //The method 'deleteUserToken' isn't defined for the type 'TokenStorage'.
// Try correcting the name to the name of an existing method, or defining a method named '
  }
}
