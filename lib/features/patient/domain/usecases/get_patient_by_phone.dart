import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/domain/repositories/patient_repository.dart';

class GetPatientByPhone {
  final PatientRepository repository;
  GetPatientByPhone({required this.repository});

  Future<Either<Failure, Patient>> call(String phone) {
    return repository.getPatientByPhone(phone);
  }
}
