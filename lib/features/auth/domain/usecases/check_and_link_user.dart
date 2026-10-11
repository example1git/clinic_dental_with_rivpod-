import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';

class CheckAndLinkUser {
  final AuthRepository repository;
  CheckAndLinkUser({required this.repository});
  Future<Either<Failure, String>> call(String phone) {
    return repository.checkAndLinkUserRpc(phone);
  }
}
