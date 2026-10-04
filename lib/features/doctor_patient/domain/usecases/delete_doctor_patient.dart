import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/repositories/doctor_patient_repository.dart';

class DeleteDoctorPatient {
  final DoctorPatientRepository repository;

  DeleteDoctorPatient({required this.repository});
  Future<Either<Failure, void>> call(DoctorPateint doctorPateint) {
    return repository.deleteDoctorPatient(doctorPateint);
  }
}
