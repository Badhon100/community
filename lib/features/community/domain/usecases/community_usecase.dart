import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/community_entity.dart';
import '../repositories/community_repository.dart';

class GetCommunityUseCase {
  final CommunityRepository repository;

  GetCommunityUseCase(this.repository);

  Future<Either<Failure, List<CommunityEntity>>> call({
    required int page,
    required int limit,
  }) {
    return repository.getCommunities(page: page, limit: limit);
  }
}
