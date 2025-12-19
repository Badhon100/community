import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/profile_repository.dart';

class LogoutProfileUseCase {
  final ProfileRepository repository;

  LogoutProfileUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
