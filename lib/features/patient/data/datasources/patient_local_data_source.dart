import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/features/patient/data/models/patient_model.dart';
import 'package:sqflite/sqlite_api.dart';

class PatientLocalDataSource {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final table = "patient";
  final Duration duration = const Duration(seconds: duration15);

  Future<PatientModel?> getPatient() async {
    try {
      final resposne = await databaseHelper.queryAll(table).timeout(duration);
      if (resposne.isEmpty) {
        return null;
      }

      return PatientModel.fromMapsql(resposne.first);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } on DatabaseException catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<PatientModel> addPatient(PatientModel model) async {
    try {
      await databaseHelper.insert(table, model.toMapsql()).timeout(duration);

      return model;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }
}
