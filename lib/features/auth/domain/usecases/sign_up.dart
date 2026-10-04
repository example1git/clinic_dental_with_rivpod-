import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp {
  final AuthRepository repository;
  SignUp({required this.repository});
  Future<Either<Failure, AuthResponse>> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
