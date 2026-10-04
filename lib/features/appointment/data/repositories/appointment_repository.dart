import 'package:dartz/dartz.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/failure.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/appointment/data/datasources/appointment_local_data_sorce.dart';
import 'package:mysen/features/appointment/data/datasources/appointment_remote_data_sorce.dart';
import 'package:mysen/features/appointment/data/models/appointment_model.dart';
import 'package:mysen/features/appointment/domain/entities/appointment.dart';
import 'package:mysen/features/appointment/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImp implements AppointmentRepository {
  final AppointmentRemoteDataSorce appointmentRemoteDataSorce;
  final AppointmentLocalDataSorce appointmentLocalDataSorce;
  final InternetService internetService;
  AppointmentRepositoryImp({
    required this.appointmentRemoteDataSorce,
    required this.appointmentLocalDataSorce,
    required this.internetService,
  });
  @override
  Future<Either<Failure, Appointment>> addAppointment(
    Appointment appointment,
  ) async {
    if (await internetService.checkNow()) {
      try {
        final model = AppointmentModel(
          id: '',
          treatmentCaseID: appointment.treatmentCaseID,
          timeAppointment: appointment.timeAppointment,
          payPrice: appointment.payPrice,
          teethSelected: appointment.teethSelected,
        );

        final appointmentAdd = await appointmentRemoteDataSorce.addAppointment(
          model,
        );
        await appointmentLocalDataSorce.addAppointment(appointmentAdd);

        return Right(appointmentAdd);
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

  @override
  Future<Either<Failure, List<Appointment>>> getAppointment() async {
    if (await internetService.checkNow()) {
      try {
        final appointment = await appointmentRemoteDataSorce.getAppointment();
        for (var app in appointment) {
          await appointmentLocalDataSorce.addAppointment(app);
        }
        return Right(appointment);
      } on RequestTimeExeption catch (e) {
        return left(RequetsTimeFailure(e.message));
      } on ServerExeption catch (e) {
        return left(ServerFailure(e.message));
      }
    }
    try {
      final appointment = await appointmentLocalDataSorce.getAppointment();
      return Right(appointment);
    } on RequestTimeExeption catch (e) {
      return left(RequetsTimeFailure(e.message));
    } on CachExeption catch (e) {
      return left(CachFailure(e.message));
    }
  }
}
