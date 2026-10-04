import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<Doctor>>> getDoctors();
  Future<Either<Failure, Doctor>> getDoctorByUserID();
  Future<Either<Failure, Doctor>> updateDoctor(Doctor doctor);
}
