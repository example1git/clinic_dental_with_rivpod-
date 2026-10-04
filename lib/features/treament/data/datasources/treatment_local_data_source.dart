import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/features/treament/data/models/treatment_case_model.dart';
import 'package:sqflite/sqflite.dart';

class TreatmentLocalDataSource {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;
  final table = "treatmentCase";
  final Duration duration = const Duration(seconds: duration15);
  Future<List<TreatmentCaseModel>> getTreatmentCase() async {
    try {
      final resposne = await databaseHelper.queryAll(table).timeout(duration);

      return resposne.map((e) => TreatmentCaseModel.fromMapSql(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } on DatabaseException catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<TreatmentCaseModel> addTreatmentCase(
    TreatmentCaseModel treatmentCaseModel,
  ) async {
    try {
      await databaseHelper
          .insert(table, treatmentCaseModel.toMapSql())
          .timeout(duration);

      return treatmentCaseModel;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<TreatmentCaseModel> updateTreatmentCase(
    TreatmentCaseModel treatmentCaseModel,
  ) async {
    try {
      await databaseHelper
          .update(table, treatmentCaseModel.toMapSql(), treatmentCaseModel.id)
          .timeout(duration);

      return treatmentCaseModel;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }
}
