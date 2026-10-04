import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/domain/repositories/treatment_case_repository.dart';

class AddTreatmentCase {
  final TreatmentCaseRepository repository;
  AddTreatmentCase({required this.repository});
  Future<Either<Failure, TreatmentCase>> call(TreatmentCase treatmentCase) {
    return repository.addTreatmentCase(treatmentCase);
  }
}
