import 'package:dio/dio.dart';
import '../../storage/secure_storage_service.dart';
import '../../storage/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await storage.getString(StorageKey.token); // async
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      // optionally log error
      print("AuthInterceptor error: $e");
    }

    super.onRequest(options, handler);
  }
}
