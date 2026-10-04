import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';

abstract class RequestReservationRepository {
  Future<Either<Failure, List<RequestReservation>>> getRequestReservation();

  Future<Either<Failure, RequestReservation>> upsertRequestReservation(
    RequestReservation requestReservation,
  );
  Future<Either<Failure, RequestReservation>> updateRequestReservation(
    RequestReservation requestReservation,
  );
}
