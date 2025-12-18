import 'package:community/core/network/api_service.dart';
import 'package:community/core/network/network_info.dart';
import 'package:community/core/storage/shared_pref_service.dart';
import 'package:community/features/authenticaction/data/data_sources/auth_remote_data_source.dart';
import 'package:community/features/authenticaction/data/repositories/auth_repository_impl.dart';
import 'package:community/features/authenticaction/domain/repositories/auth_repository.dart';
import 'package:community/features/authenticaction/domain/usecases/usecase.dart';
import 'package:community/features/authenticaction/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';


void authInjection(GetIt sl) {
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiService>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl<NetworkInfo>(),
      pref: sl<SharedPrefService>(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerFactory(() => AuthBloc(sl()));
}
