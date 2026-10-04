import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/domain/repositories/patient_repository.dart';

class AddPatient {
  final PatientRepository repository;
  AddPatient({required this.repository});

  Future<Either<Failure, Patient>> call(Patient patient) {
    return repository.addtPatient(patient);
  }
}
