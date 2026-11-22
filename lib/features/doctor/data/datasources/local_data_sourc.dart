import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/features/doctor/data/models/doctor_model.dart';
import 'package:sqflite/sqlite_api.dart';

class DoctorLocalDataSourc {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final doctortable = "doctor";
  final doctorstable = "doctors";
  final Duration duration = const Duration(seconds: duration15);

  Future<List<DoctorModel>> getDoctors() async {
    try {
      final resposne = await databaseHelper
          .queryAll(doctorstable)
          .timeout(duration);

      return resposne.map((e) => DoctorModel.fromMapSql(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } on DatabaseException catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<DoctorModel?> getDoctor() async {
    try {
      final resposne = await databaseHelper
          .queryAll(doctortable)
          .timeout(duration);
      if (resposne.isEmpty) {
        return null;
      }

      final map = resposne.first;

      return DoctorModel.fromMapSql(map);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<DoctorModel> addDoctor(DoctorModel doctor) async {
    try {
      await databaseHelper
          .insert(doctortable, doctor.toMapSql())
          .timeout(duration);

      return doctor;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<DoctorModel> addDoctors(DoctorModel doctor) async {
    try {
      await databaseHelper
          .insert(doctorstable, doctor.toMapSql())
          .timeout(duration);

      return doctor;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<DoctorModel> updateDoctor(DoctorModel doctor) async {
    try {
      await databaseHelper
          .update(doctortable, doctor.toMapSql(), doctor.id)
          .timeout(duration);

      return doctor;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }
}
