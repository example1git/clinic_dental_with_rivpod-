import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/domain/repositories/treatment_case_repository.dart';

class UpdateTreatmentCase {
  final TreatmentCaseRepository repository;
  UpdateTreatmentCase({required this.repository});
  Future<Either<Failure, TreatmentCase>> call(TreatmentCase treatmentCase) {
    return repository.updateTreatmentCase(treatmentCase);
  }
}
