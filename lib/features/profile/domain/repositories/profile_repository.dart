import 'package:community/features/profile/domain/entities/profile_user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, void>> logout();
}
