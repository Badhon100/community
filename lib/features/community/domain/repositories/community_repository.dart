import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/community_entity.dart';

abstract class CommunityRepository {
  Future<Either<Failure, List<CommunityEntity>>> getCommunities({
    required int page,
    required int limit,
    String? search,
  });
}
