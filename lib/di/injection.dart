import 'package:community/core/network/interceptors/auth_interceptors.dart';
import 'package:community/core/theme/theme_cubit.dart';
import 'package:community/di/dependencies.dart/auth_dependencies.dart';
import 'package:community/di/dependencies.dart/community_dependency.dart';
import 'package:community/di/dependencies.dart/profile_dependecies.dart';
import 'package:community/features/bottom_nav_bar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/network/dio_client.dart';
import '../core/network/api_service.dart';
import '../core/network/network_info.dart';
import '../core/network/interceptors/logging_interceptor.dart';
import '../core/storage/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> setupInjection() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => prefs);
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);

  // Shared Pref Service
  sl.registerLazySingleton(() => SecureStorageService(sl()));
    sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

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
  SecureStorageService(const FlutterSecureStorage());
  sl.registerLazySingleton(() => ThemeCubit(storage: sl()));

  //Bottom Nav Bar Bloc
  sl.registerFactory(() => BottomNavBarBloc());

  // Features
  authInjection(sl);
  profileInjection(sl);
  communityInjection(sl);
}
