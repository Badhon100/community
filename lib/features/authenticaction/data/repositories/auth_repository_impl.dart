import 'package:community/features/authenticaction/data/data_sources/auth_remote_data_source.dart';
import 'package:community/features/authenticaction/domain/entities/auth_user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/storage/shared_pref_service.dart';
import '../../../../core/storage/storage_keys.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final SharedPrefService pref;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.pref,
  });

  @override
  Future<Either<Failure, AuthUserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.login(
          email: email,
          password: password,
        );

        // ✅ STORE DATA USING ENUM KEYS
        await pref.setString(StorageKey.authToken, user.token);
        await pref.setBool(StorageKey.isLoggedIn, true);

        return Right(user);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
