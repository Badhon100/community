import 'package:community/core/network/interceptors/auth_interceptors.dart';
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient({
    required AuthInterceptor authInterceptor,
    required LoggingInterceptor loggingInterceptor,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([authInterceptor, loggingInterceptor]);
  }
}
