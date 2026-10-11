import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/domain/repositories/appointment_repository.dart';

class GetAppointmentByDpid {
  final AppointmentRepository repository;
  GetAppointmentByDpid({required this.repository});
  Future<Either<Failure, List<Appointment>>> call(String doctorPatientID) {
    return repository.getAppointment();
  }
}
