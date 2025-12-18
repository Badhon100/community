import 'package:community/core/network/interceptors/auth_interceptors.dart';
import 'package:community/core/theme/theme_cubit.dart';
import 'package:community/di/dependencies.dart/auth_dependencies.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/dio_client.dart';
import '../core/network/api_service.dart';
import '../core/network/network_info.dart';
import '../core/network/interceptors/logging_interceptor.dart';
import '../core/storage/shared_pref_service.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);

  // Shared Pref Service
  sl.registerLazySingleton(() => SharedPrefService(sl()));

  // Interceptors
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => AuthInterceptor(sl()));

  // Dio Client
  sl.registerLazySingleton(
    () => DioClient(authInterceptor: sl(), loggingInterceptor: sl()),
  );

  // Api Service
  sl.registerLazySingleton(() => ApiService(sl<DioClient>().dio));

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Theme Cubit
  sl.registerLazySingleton(() => ThemeCubit());

  // Features
  authInjection(sl);
}
