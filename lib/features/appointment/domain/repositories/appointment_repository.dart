import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, List<Appointment>>> getAppointment();
  Future<Either<Failure, List<Appointment>>> getAppointmentByDpID(String dpID);

  Future<Either<Failure, Appointment>> addAppointment(Appointment appointment);
}
