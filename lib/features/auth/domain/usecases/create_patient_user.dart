import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';

class CreatePatientUser {
  final AuthRepository repository;
  CreatePatientUser({required this.repository});
  Future<Either<Failure, void>> call(String phone, String fullName) {
    return repository.createPatientUserRpc(phone, fullName);
  }
}
