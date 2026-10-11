import 'package:dartz/dartz.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';

abstract class TreatmentCaseRepository {
  Future<Either<Failure, List<TreatmentCase>>> getTreatmentCase();
  Future<Either<Failure, List<TreatmentCase>>> getTreatmentCaseByDpID(
    String dpID,
  );
  Future<Either<Failure, TreatmentCase>> addTreatmentCase(
    TreatmentCase treatment,
  );
  Future<Either<Failure, TreatmentCase>> updateTreatmentCase(
    TreatmentCase treatment,
  );
  Future<Either<Failure, TreatmentCase>> deleteTreatmentCase(
    TreatmentCase treatment,
  );
}
