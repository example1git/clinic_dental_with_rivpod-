import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/treament/data/datasources/treatment_local_data_source.dart';
import 'package:mysen/features/treament/data/datasources/treatment_remote_data_source.dart';
import 'package:mysen/features/treament/data/models/treatment_case_model.dart';
import 'package:mysen/features/treament/domain/entities/treatment_case.dart';
import 'package:mysen/features/treament/domain/repositories/treatment_case_repository.dart';

class TreatmentRepositoryImp implements TreatmentCaseRepository {
  final TreatmentRemoteDataSource treatmentRemoteDataSource;
  final TreatmentLocalDataSource treatmentLocalDataSource;
  final InternetService internetService;
  TreatmentRepositoryImp({
    required this.treatmentRemoteDataSource,
    required this.treatmentLocalDataSource,
    required this.internetService,
  });

  @override
  Future<Either<Failure, TreatmentCase>> addTreatmentCase(
    TreatmentCase treatment,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = TreatmentCaseModel(
          id: treatment.id,
          doctorPatientID: treatment.doctorPatientID,
          totalPrice: treatment.totalPrice,
          treatmentSatus: treatment.treatmentSatus,
          createdTime: treatment.createdTime,
        );

        final treatmentAdd = await treatmentRemoteDataSource.addTreatmentCase(
          model,
        );
        await treatmentLocalDataSource.addTreatmentCase(treatmentAdd);

        return Right(treatmentAdd);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return Left(CachFailure(e.message));
      }
    }
    return Left(ServerFailure('errror'));
  }

  @override
  Future<Either<Failure, List<TreatmentCase>>> getTreatmentCase() async {
    if (await internetService.checkNow()) {
      try {
        final treament = await treatmentRemoteDataSource.getTreatmentCase();
        for (var tr in treament) {
          await treatmentLocalDataSource.addTreatmentCase(tr);
        }
        return Right(treament);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        return Left(CachFailure(e.message));
      }
    }
    try {
      final treament = await treatmentLocalDataSource.getTreatmentCase();
      return Right(treament);
    } on RequestTimeExeption catch (e) {
      return Left(RequetsTimeFailure(e.message));
    } on CachExeption catch (e) {
      return Left(CachFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TreatmentCase>> updateTreatmentCase(
    TreatmentCase treatment,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = TreatmentCaseModel(
          id: treatment.id,
          doctorPatientID: treatment.doctorPatientID,
          totalPrice: treatment.totalPrice,
          treatmentSatus: treatment.treatmentSatus,
          createdTime: treatment.createdTime,
        );

        final treatmentUpdate = await treatmentRemoteDataSource
            .updateTreatmentCase(model);
        await treatmentLocalDataSource.updateTreatmentCase(treatmentUpdate);

        return Right(treatmentUpdate);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return Left(CachFailure(e.message));
      }
    }
    return Left(InternetFailure('errror'));
  }

  @override
  Future<Either<Failure, List<TreatmentCase>>> getTreatmentCaseByDpID(
    String dpID,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final treament = await treatmentRemoteDataSource.getTreatmentCaseByDpID(
          dpID,
        );
        for (var tr in treament) {
          await treatmentLocalDataSource.addTreatmentCase(tr);
        }
        return Right(treament);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('internet'));
  }

  @override
  Future<Either<Failure, TreatmentCase>> deleteTreatmentCase(
    TreatmentCase treatment,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = TreatmentCaseModel(
          id: treatment.id,
          doctorPatientID: treatment.doctorPatientID,
          totalPrice: treatment.totalPrice,
          treatmentSatus: treatment.treatmentSatus,
          createdTime: treatment.createdTime,
        );

        final response = await treatmentRemoteDataSource.deleteTreatmentCase(
          model,
        );
        if (response == TreatmentSatus.canceled.name) {
          await treatmentLocalDataSource.updateTreatmentCase(
            model.copyWith(treatmentSatus: TreatmentSatus.canceled),
          );
          return Right(model.copyWith(treatmentSatus: TreatmentSatus.canceled));
        }
        if (response == TreatmentSatus.canceled.name) {
          await treatmentLocalDataSource.deleteTreatmentCase(
            model.copyWith(treatmentSatus: TreatmentSatus.deleted),
          );
          return Right(model.copyWith(treatmentSatus: TreatmentSatus.deleted));
        }

        return Right(model);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return Left(CachFailure(e.message));
      }
    }
    return Left(InternetFailure('errror'));
  }
}
