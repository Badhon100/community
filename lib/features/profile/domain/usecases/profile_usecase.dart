import 'package:community/features/profile/domain/entities/profile_user_entity.dart';
import 'package:dartz/dartz.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/errors/failures.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> call() async {
    return await repository.getProfile();
  }
}
