import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/patient/data/datasources/patient_local_data_source.dart';
import 'package:mysen/features/patient/data/datasources/patient_remote_data_sorce.dart';
import 'package:mysen/features/patient/data/models/patient_model.dart';
import 'package:mysen/features/patient/domain/entities/patient.dart';
import 'package:mysen/features/patient/domain/repositories/patient_repository.dart';

class PatientRepositoryImp implements PatientRepository {
  final PatientRemoteDataSorce patientRemoteDataSorce;
  final PatientLocalDataSource patientLocalDataSource;
  final InternetService internetService;
  PatientRepositoryImp({
    required this.patientRemoteDataSorce,
    required this.patientLocalDataSource,
    required this.internetService,
  });

  @override
  Future<Either<Failure, Patient>> addtPatient(Patient patient) async {
    if (await internetService.checkNow()) {
      try {
        final model = PatientModel(
          id: '',
          fullName: patient.fullName,
          phone: patient.phone,
        );

        final patientAdd = await patientRemoteDataSorce.addPatient(model);
        await patientLocalDataSource.addPatient(patientAdd);

        return Right(patientAdd);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return Left(CachFailure(e.message));
      }
    }
    return Left(InternetFailure('internt'));
  }

  @override
  Future<Either<Failure, Patient?>> getPatientByPhone(String phone) async {
    if (await internetService.checkNow()) {
      try {
        final patient = await patientRemoteDataSorce.getPatientByPhone(phone);
        if (patient == null) {
          return Right(null);
        }
        patientLocalDataSource.addPatient(patient);

        return Right(patient);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }

    return Left(InternetFailure('error network failer'));
  }

  @override
  Future<Either<Failure, Patient?>> getPatientByUserID() async {
    final patient = await patientLocalDataSource.getPatient();
    if (patient != null) {
      return Right(patient);
    }
    if (await internetService.checkNow()) {
      try {
        final patient = await patientRemoteDataSorce.getPatientByuserID();
        if (patient == null) {
          return Right(null);
        }
        patientLocalDataSource.addPatient(patient);

        return Right(patient);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    return Left(InternetFailure('error network failer'));
  }
}
