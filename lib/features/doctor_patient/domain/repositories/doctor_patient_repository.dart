import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';

abstract class DoctorPatientRepository {
  Future<Either<Failure, List<DoctorPateint>>> getDoctorPatient();
  Future<Either<Failure, DoctorPateint>> upsertDoctorPatient(
    DoctorPateint doctorPatient,
  );
  Future<Either<Failure, DoctorPateint>> updateDoctorPatient(
    DoctorPateint doctorPatient,
  );
  Future<Either<Failure, void>> deleteDoctorPatient(
    DoctorPateint doctorPatient,
  );
}
