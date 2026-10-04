import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/request/domain/entities/request_reservation.dart';
import 'package:mysen/features/request/domain/repositories/request_reservation_repository.dart';

class GetRequstReserve {
  final RequestReservationRepository repository;
  GetRequstReserve({required this.repository});
  Future<Either<Failure, List<RequestReservation>>> call() {
    return repository.getRequestReservation();
  }
}
