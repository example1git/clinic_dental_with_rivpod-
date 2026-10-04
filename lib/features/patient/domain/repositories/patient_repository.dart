import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';

abstract class PatientRepository {
  Future<Either<Failure, Patient>> getPatientByUserID();
  Future<Either<Failure, Patient>> getPatientByPhone(String phone);
  Future<Either<Failure, Patient>> addtPatient(Patient patient);
}
