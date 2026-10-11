import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';

class SignOut {
  final AuthRepository repository;
  SignOut({required this.repository});
  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
