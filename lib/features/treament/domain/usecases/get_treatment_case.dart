import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/domain/repositories/treatment_case_repository.dart';

class GetTreatmentCase {
  final TreatmentCaseRepository repository;
  GetTreatmentCase({required this.repository});
  Future<Either<Failure, List<TreatmentCase>>> call() {
    return repository.getTreatmentCase();
  }
}
