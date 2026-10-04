import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/domain/repositories/appointment_repository.dart';

class GetAppointment {
  final AppointmentRepository repository;
  GetAppointment({required this.repository});
  Future<Either<Failure, List<Appointment>>> call() {
    return repository.getAppointment();
  }
}
