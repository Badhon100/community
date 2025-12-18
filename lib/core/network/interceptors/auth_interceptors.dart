import 'package:dio/dio.dart';
import '../../storage/shared_pref_service.dart';
import '../../storage/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final SharedPrefService pref;

  AuthInterceptor(this.pref);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = pref.getString(StorageKey.authToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
