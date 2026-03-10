import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'dio_interceptor.dart';
import '../storage/token_storage.dart';

class DioClient {
  late final Dio dio;

  DioClient(TokenStorage tokenStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );


    /// JWT interceptor
    dio.interceptors.add(DioInterceptor(tokenStorage));

    /// Logging interceptor (development)
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }
}
