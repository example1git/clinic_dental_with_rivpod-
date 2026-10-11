import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/domain/repositories/request_reservation_repository.dart';

class UpdateRequestReservation {
  final RequestReservationRepository repository;
  UpdateRequestReservation({required this.repository});
  Future<Either<Failure, void>> call(RequestReservation requestReservation) {
    return repository.updateRequestReservation(requestReservation);
  }
}
