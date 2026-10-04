import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/domain/repositories/appointment_repository.dart';

class AddAppointment {
  final AppointmentRepository repository;
  AddAppointment({required this.repository});
  Future<Either<Failure, Appointment>> call(Appointment appointment) {
    return repository.addAppointment(appointment);
  }
}
