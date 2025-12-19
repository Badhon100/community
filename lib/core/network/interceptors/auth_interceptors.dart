import 'package:community/core/routes/route_service.dart';
import 'package:community/core/storage/secure_storage_service.dart';
import 'package:community/core/storage/storage_keys.dart';
import 'package:community/features/authenticaction/presentation/pages/login_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService storage;

  // ✅ Put it HERE (class-level)
  bool _isLoggingOut = false;

  AuthInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.getString(StorageKey.token);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isLoggingOut) {
      _isLoggingOut = true;

      await storage.clear(); // or clearAll() if you added that method

      RouteService.navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (_) => false,
      );
    }

    super.onError(err, handler);
  }
}
