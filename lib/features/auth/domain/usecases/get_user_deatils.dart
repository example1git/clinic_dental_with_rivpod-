import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/auth/domain/entities/user_details.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';

class GetUserDeatils {
  final AuthRepository repository;
  GetUserDeatils({required this.repository});
  Future<Either<Failure, UserDetails?>> call() {
    return repository.getUserDetails();
  }
}
