import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';

abstract class RequestReservationRepository {
  Future<Either<Failure, List<RequestReservation>>> getRequestReservation();

  Future<Either<Failure, void>> upsertRequestReservation(
    RequestReservation requestReservation,
  );
  Future<Either<Failure, void>> updateRequestReservation(
    RequestReservation requestReservation,
  );
}
