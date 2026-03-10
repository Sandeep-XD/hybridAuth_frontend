import 'package:dio/dio.dart';
import 'package:frontend/features/core/network/dio_client.dart';

import '../models/auth_init_response.dart';
import 'package:uuid/uuid.dart';

class AuthRemoteDatasource {
  final DioClient client;

  AuthRemoteDatasource(this.client);

  Future<AuthInitResponse> initAuth() async {
    final deviceId = const Uuid().v4();

    final response = await client.dio.post(
      "/auth/init",
      options: Options(
        headers: {"X-Device-Id": deviceId, "X-Client-Type": "WEB"},
      ),
    );

    final data = response.data['data'];

    return AuthInitResponse.fromJson(data);
  }
}
