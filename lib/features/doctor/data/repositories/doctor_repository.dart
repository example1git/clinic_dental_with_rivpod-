import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/doctor/data/datasources/local_data_sourc.dart';
import 'package:mysen/features/doctor/data/models/doctor_model.dart';
import 'package:mysen/features/doctor/data/datasources/remot_data_source.dart';
import 'package:mysen/features/doctor/domain/entities/doctor.dart';
import 'package:mysen/features/doctor/domain/repositories/repository.dart';

class DoctorRepositoryImp implements DoctorRepository {
  final DoctorRemotDataSource doctorRemotDataSource;
  final DoctorLocalDataSourc doctorLocalDataSource;
  final InternetService internetService;

  DoctorRepositoryImp({
    required this.doctorRemotDataSource,
    required this.doctorLocalDataSource,
    required this.internetService,
  });

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    if (await internetService.checkNow()) {
      try {
        final doctors = await doctorRemotDataSource.getDoctors();
        for (var d in doctors) {
          await doctorLocalDataSource.addDoctor(d);
        }
        return Right(doctors);
      } on RequestTimeExeption catch (e) {
        return left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return left(ServerFailure(e.message));
      }
    }
    try {
      final doctors = await doctorLocalDataSource.getDoctors();
      return Right(doctors);
    } on RequestTimeExeption catch (e) {
      return left(RequetsTimeFailure(e.message));
    } on CachExeption catch (e) {
      return left(CachFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Doctor>> getDoctorByUserID() async {
    final doctorSql = await doctorLocalDataSource.getDoctor();
    if (doctorSql != null) {
      return right(doctorSql);
    }
    if (await internetService.checkNow()) {
      try {
        final doctor = await doctorRemotDataSource.getDoctorByUserID();
        if (doctor == null) {
          return Left(ServerFailure('error'));
        }
        doctorLocalDataSource.addDoctor(doctor);

        return Right(doctor);
      } on RequestTimeExeption catch (e) {
        return left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return left(ServerFailure(e.message));
      }
    }
    return Left(ServerFailure('error network'));
  }

  @override
  Future<Either<Failure, Doctor>> updateDoctor(Doctor doctor) async {
    if (await internetService.checkNow()) {
      try {
        final model = DoctorModel(
          id: doctor.id,
          userID: doctorRemotDataSource.client.auth.currentUser?.id,
          fullName: doctor.fullName,
          phone: doctor.phone,
          gender: doctor.gender,
          equlatifications: doctor.equlatifications,
          imgUrl: doctor.imgUrl,
          isWorking: doctor.isWorking,
          location: doctor.location,
        );

        final doctorUpdate = await doctorRemotDataSource.updateDoctor(model);
        await doctorLocalDataSource.updateDoctor(doctorUpdate);

        return Right(doctorUpdate);
      } on RequestTimeExeption catch (e) {
        return left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return left(ServerFailure(e.message));
      } on CachExeption catch (e) {
        return left(CachFailure(e.message));
      }
    }
    return Left(ServerFailure('errror'));
  }
}
