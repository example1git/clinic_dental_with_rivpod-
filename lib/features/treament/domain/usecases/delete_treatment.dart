import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/domain/repositories/treatment_case_repository.dart';

class DeleteTreatment {
  final TreatmentCaseRepository repository;
  DeleteTreatment({required this.repository});
  Future<Either<Failure, TreatmentCase>> call(TreatmentCase treatmentCase) {
    return repository.deleteTreatmentCase(treatmentCase);
  }
}
