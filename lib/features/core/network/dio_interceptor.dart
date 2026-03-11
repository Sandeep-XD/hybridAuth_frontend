import 'package:dio/dio.dart';
import '../storage/token_storage.dart';

class DioInterceptor extends Interceptor {
  final TokenStorage storage;

  DioInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final userToken = await storage.getUserToken();

    if (userToken != null) {
      options.headers["Authorization"] = "Bearer $userToken";
    } else {
      final preAuthToken = await storage.getPreAuthToken();

      if (preAuthToken != null) {
        options.headers["Authorization"] = "Bearer $preAuthToken";
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final data = err.response?.data;

      if (data != null && data['status'] != null) {
        final message = data['status']['message'];

        throw Exception(message);
      }
    }

    handler.next(err);
  }
  
}
