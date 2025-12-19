import 'package:community/features/community/data/datasources/community_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/community_entity.dart';
import '../../domain/repositories/community_repository.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CommunityRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CommunityEntity>>> getCommunities({
    required int page,
    required int limit,
    String? search,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final communities = await remoteDataSource.fetchCommunities(
          page: page,
          limit: limit,
          search: search,
        );
        return Right(communities);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
