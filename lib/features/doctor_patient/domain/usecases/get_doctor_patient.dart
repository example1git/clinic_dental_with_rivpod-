import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/repositories/doctor_patient_repository.dart';

class GetDoctorPatient {
  final DoctorPatientRepository repository;

  GetDoctorPatient({required this.repository});
  Future<Either<Failure, List<DoctorPateint>>> call() {
    return repository.getDoctorPatient();
  }
}
