import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/request/data/datasources/request_reservation_local_data_source.dart';
import 'package:mysen/features/request/data/datasources/request_reservation_remote_data_source.dart';
import 'package:mysen/features/request/data/models/request_reservation_model.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/domain/repositories/request_reservation_repository.dart';

class RequestReservationRepositoryImp implements RequestReservationRepository {
  final RequestReservationRemoteDataSource requestReservationRemoteDataSource;
  final RequestReservationLocalDataSource requestReservationLocalDataSource;
  final InternetService internetService;
  RequestReservationRepositoryImp({
    required this.requestReservationRemoteDataSource,
    required this.requestReservationLocalDataSource,
    required this.internetService,
  });

  @override
  Future<Either<Failure, void>> upsertRequestReservation(
    RequestReservation requestReservation,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = RequestReservationModel(
          id: requestReservation.id,
          doctorID: requestReservation.doctorID,
          patientID: requestReservation.patientID,
          patientName: requestReservation.patientName,
          stateRequest: requestReservation.stateRequest,
          phone: requestReservation.phone,
        );

        await requestReservationRemoteDataSource.upsertRequestReservation(
          model,
        );

        return Right(null);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return Left(CachFailure(e.message));
      }
    }
    return Left(InternetFailure('errror'));
  }

  @override
  Future<Either<Failure, List<RequestReservation>>>
  getRequestReservation() async {
    if (await internetService.checkNow()) {
      try {
        final requestReservation = await requestReservationRemoteDataSource
            .getRequestReservation();
        for (var app in requestReservation) {
          await requestReservationLocalDataSource.upsertRequestReservation(app);
        }
        return Right(requestReservation);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    try {
      final requestReservation = await requestReservationLocalDataSource
          .getRequestReservation();

      for (var r in requestReservation) {
        await requestReservationLocalDataSource.upsertRequestReservation(r);
      }
      return Right(requestReservation);
    } on RequestTimeExeption catch (e) {
      return Left(RequetsTimeFailure(e.message));
    } on CachExeption catch (e) {
      return Left(CachFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateRequestReservation(
    RequestReservation requestReservation,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = RequestReservationModel(
          id: requestReservation.id,
          doctorID: requestReservation.doctorID,
          patientID: requestReservation.patientID,
          patientName: requestReservation.patientName,
          stateRequest: requestReservation.stateRequest,
          phone: requestReservation.phone,
        );

        requestReservationRemoteDataSource.updateRequestReservation(model);

        return Right(null);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return Left(CachFailure(e.message));
      }
    }
    return Left(InternetFailure('errror'));
  }
}
