
import 'package:community/features/community/data/datasources/community_data_source.dart';
import 'package:community/features/community/data/repositories/community_repository_impl.dart';
import 'package:community/features/community/domain/repositories/community_repository.dart';
import 'package:community/features/community/domain/usecases/community_usecase.dart';
import 'package:community/features/community/presentation/bloc/community_bloc.dart';
import 'package:get_it/get_it.dart';

void communityInjection(GetIt sl) {
  sl.registerLazySingleton<CommunityRemoteDataSource>(
    () => CommunityRemoteDataSourceImpl(apiService: sl(),),
  );

  sl.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton(() => GetCommunityUseCase(sl()));
  sl.registerFactory(
    () => CommunityBloc(repository: sl(),),
  );
}
