import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/features/doctor_patient/data/models/doctor_patient_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DoctorPatientLocalDataSourc {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final table = "doctorPatient";
  final Duration duration = const Duration(seconds: duration15);

  Future<List<DoctorPatientModel>> getDoctorPatient() async {
    try {
      final resposne = await databaseHelper.queryAll(table).timeout(duration);

      return resposne.map((e) => DoctorPatientModel.fromMapSql(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } on DatabaseException catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<DoctorPatientModel> upsertDoctorPatient(
    DoctorPatientModel doctorPatientModel,
  ) async {
    try {
      await databaseHelper
          .insert(table, doctorPatientModel.toMapSql())
          .timeout(duration);

      return doctorPatientModel;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<DoctorPatientModel> updatetDoctorPatient(
    DoctorPatientModel doctorPatientModel,
  ) async {
    try {
      await databaseHelper
          .update(table, doctorPatientModel.toMapSql(), doctorPatientModel.id)
          .timeout(duration);

      return doctorPatientModel;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<void> deleteDoctorPatient(
    DoctorPatientModel doctorPatientModel,
  ) async {
    try {
      await databaseHelper
          .delete(table, doctorPatientModel.id)
          .timeout(duration);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }
}
