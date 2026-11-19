import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor_patient/data/datasources/local_data_source.dart';
import 'package:mysen/features/doctor_patient/data/datasources/remote_data_source.dart';
import 'package:mysen/features/doctor_patient/data/models/doctor_patient_model.dart';
import 'package:mysen/features/doctor_patient/domain/entities/doctor_patient.dart';
import 'package:mysen/features/doctor_patient/domain/repositories/doctor_patient_repository.dart';

class DoctorPatientRepositryImp implements DoctorPatientRepository {
  final DoctorPatientRemoteDatasource doctorPatientRemoteDatasource;
  final DoctorPatientLocalDataSourc doctorPatientLocalDataSourc;
  final InternetService internetService;

  DoctorPatientRepositryImp({
    required this.doctorPatientRemoteDatasource,
    required this.doctorPatientLocalDataSourc,
    required this.internetService,
  });
  @override
  Future<Either<Failure, List<DoctorPateint>>> getDoctorPatient() async {
    if (await internetService.checkNow()) {
      try {
        final doctorpatient = await doctorPatientRemoteDatasource
            .getDoctorPatient();
        for (var dp in doctorpatient) {
          await doctorPatientLocalDataSourc.upsertDoctorPatient(dp);
        }
        return Right(doctorpatient);
      } on RequestTimeExeption catch (e) {
        return Left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return Left(ServerFailure(e.message));
      }
    }
    try {
      final doctorpatient = await doctorPatientLocalDataSourc
          .getDoctorPatient();
      return Right(doctorpatient);
    } on RequestTimeExeption catch (e) {
      return Left(RequetsTimeFailure(e.message));
    } on CachExeption catch (e) {
      return Left(CachFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, DoctorPateint>> upsertDoctorPatient(
    DoctorPateint doctorPateint,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = DoctorPatientModel(
          doctorID: doctorPateint.doctorID,
          patientID: doctorPateint.patientID,
          isDeleteDoctor: doctorPateint.isDeleteDoctor,
          isDeletePatient: doctorPateint.isDeletePatient,
          id: doctorPateint.id,
          doctorFullName: '',
          patientFullName: '',
          patientphone: '',
        );

        final doctorPatientUpsert = await doctorPatientRemoteDatasource
            .upsertDoctorPatient(model);
        await doctorPatientLocalDataSourc.upsertDoctorPatient(
          doctorPatientUpsert,
        );

        return Right(doctorPatientUpsert);
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
  Future<Either<Failure, void>> deleteDoctorPatient(
    DoctorPateint doctorPatient,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = DoctorPatientModel(
          doctorID: doctorPatient.doctorID,
          patientID: doctorPatient.patientID,

          isDeleteDoctor: doctorPatient.isDeleteDoctor,
          isDeletePatient: doctorPatient.isDeletePatient,
          id: doctorPatient.id,
          doctorFullName: '',
          patientFullName: '',
          patientphone: '',
        );

        doctorPatientRemoteDatasource.deleteDoctorPatient(model);
        await doctorPatientLocalDataSourc.deleteDoctorPatient(model);

        return Right(null);
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
  Future<Either<Failure, DoctorPateint>> updateDoctorPatient(
    DoctorPateint doctorPatient,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = DoctorPatientModel(
          doctorID: doctorPatient.doctorID,
          patientID: doctorPatient.patientID,

          patientphone: doctorPatient.patientphone,
          isDeleteDoctor: doctorPatient.isDeleteDoctor,
          isDeletePatient: doctorPatient.isDeletePatient,
          id: doctorPatient.id,
          doctorFullName: '',
          patientFullName: '',
        );

        final doctorPatientUpdate = await doctorPatientRemoteDatasource
            .updateDoctorPatient(model);
        await doctorPatientLocalDataSourc.updatetDoctorPatient(
          doctorPatientUpdate,
        );

        return Right(doctorPatientUpdate);
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
