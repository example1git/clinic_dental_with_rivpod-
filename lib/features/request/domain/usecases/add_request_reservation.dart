import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/domain/repositories/request_reservation_repository.dart';

class AddRequestReservation {
  final RequestReservationRepository repository;
  AddRequestReservation({required this.repository});
  Future<Either<Failure, RequestReservation>> call(
    RequestReservation requestReservation,
  ) {
    return repository.upsertRequestReservation(requestReservation);
  }
}
