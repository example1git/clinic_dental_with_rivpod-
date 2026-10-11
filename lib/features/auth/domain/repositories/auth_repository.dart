import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/auth/domain/entities/user_details.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserDetails?>> getUserDetails();
  Future<Either<Failure, AuthResponse>> signIn(String email, String password);
  Future<Either<Failure, AuthResponse>> signUp(String email, String password);
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, String>> checkAndLinkUserRpc(String phone);
  Future<Either<Failure, void>> createPatientUserRpc(
    String phone,
    String fullName,
  );
}
