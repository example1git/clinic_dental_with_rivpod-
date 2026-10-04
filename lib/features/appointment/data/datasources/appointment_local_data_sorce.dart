import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/features/appointment/data/models/appointment_model.dart';
import 'package:sqflite/sqflite.dart';

class AppointmentLocalDataSorce {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final table = "appointment";
  final Duration duration = const Duration(seconds: duration15);
  Future<List<AppointmentModel>> getAppointment() async {
    try {
      final resposne = await databaseHelper.queryAll(table).timeout(duration);

      return resposne.map((e) => AppointmentModel.fromMapSql(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } on DatabaseException catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<AppointmentModel> addAppointment(
    AppointmentModel appointmentModel,
  ) async {
    try {
      await databaseHelper
          .insert(table, appointmentModel.toMapSql())
          .timeout(duration);

      return appointmentModel;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }
}
