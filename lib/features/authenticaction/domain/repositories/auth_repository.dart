import 'package:community/features/authenticaction/domain/entities/auth_user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUserEntity>> login({
    required String email,
    required String password,
  });
}
