import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mysen/features/auth/domain/entities/user_details.dart';
import 'package:mysen/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final InternetService internetService;

  AuthRepositoryImp({
    required this.authRemoteDataSource,
    required this.internetService,
  });
  @override
  Future<Either<Failure, UserDetails?>> getUserDetails() async {
    if (await internetService.checkNow()) {
      try {
        final user = await authRemoteDataSource.getUserDetails();
        if (user == null) {
          return const Right(null);
        }

        return Right(user);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('no internet'));
  }

  @override
  Future<Either<Failure, AuthResponse>> signIn(
    String email,
    String password,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final auth = await authRemoteDataSource.signIn(email, password);

        return Right(auth);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure(' no internet'));
  }

  @override
  Future<Either<Failure, AuthResponse>> signUp(
    String email,
    String password,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final auth = await authRemoteDataSource.signUp(email, password);

        return Right(auth);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('no internet'));
  }

  @override
  Future<Either<Failure, String>> checkAndLinkUserRpc(String phone) async {
    if (await internetService.checkNow()) {
      try {
        final role = await authRemoteDataSource.checkAndLinkUserRpc(phone);

        return Right(role);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('no internet'));
  }

  @override
  Future<Either<Failure, void>> createPatientUserRpc(
    String phone,
    String fullName,
  ) async {
    if (await internetService.checkNow()) {
      try {
        await authRemoteDataSource.createPatientUserRpc(phone, fullName);

        return const Right(null);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('no internet'));
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await internetService.checkNow()) {
      try {
        await authRemoteDataSource.signOut();

        return const Right(null);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('no internet'));
  }
}
