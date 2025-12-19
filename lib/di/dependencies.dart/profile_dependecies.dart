
import 'package:community/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:community/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:community/features/profile/domain/repositories/profile_repository.dart';
import 'package:community/features/profile/domain/usecases/logout_profile_usecase.dart';
import 'package:community/features/profile/domain/usecases/profile_usecase.dart';
import 'package:community/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:get_it/get_it.dart';

void profileInjection(GetIt sl) {
  sl.registerLazySingleton<ProfileRemoteDataSource>(
  () => ProfileRemoteDataSourceImpl(apiService: sl(), networkInfo: sl()),
);

sl.registerLazySingleton<ProfileRepository>(
  () => ProfileRepositoryImpl(
    remoteDataSource: sl(),
    networkInfo: sl(),
  ),
);

sl.registerLazySingleton(() => GetProfileUseCase(sl()));
sl.registerLazySingleton(() => LogoutProfileUseCase(sl()));
sl.registerFactory(() => ProfileBloc(getProfileUseCase: sl(), logoutProfileUseCase: sl(),));


}
