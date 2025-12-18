import 'package:dio/dio.dart';
import 'dart:developer';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('➡️ REQUEST [${options.method}] ${options.uri}');
    log('Headers: ${options.headers}');
    log('Body: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('✅ RESPONSE [${response.statusCode}] ${response.requestOptions.uri}');
    log('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ ERROR [${err.response?.statusCode}] ${err.requestOptions.uri}');
    log('Message: ${err.message}');
    super.onError(err, handler);
  }
}
