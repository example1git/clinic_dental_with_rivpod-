import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/core/sql.dart';
import 'package:mysen/features/request/data/models/request_reservation_model.dart';
import 'package:sqflite/sqflite.dart';

class RequestReservationLocalDataSource {
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  RequestReservationLocalDataSource();

  final table = "request";
  final Duration duration = const Duration(seconds: duration15);
  Future<List<RequestReservationModel>> getRequestReservation() async {
    try {
      final resposne = await databaseHelper.queryAll(table).timeout(duration);

      return resposne
          .map((e) => RequestReservationModel.fromMapsql(e))
          .toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } on DatabaseException catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<RequestReservationModel> upsertRequestReservation(
    RequestReservationModel requestReservationMode,
  ) async {
    try {
      await databaseHelper
          .insert(table, requestReservationMode.toMapsql())
          .timeout(duration);

      return requestReservationMode;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }

  Future<RequestReservationModel> updateRequestReservation(
    RequestReservationModel requestReservationModel,
  ) async {
    try {
      await databaseHelper
          .update(
            table,
            requestReservationModel.toMapsql(),
            requestReservationModel.id,
          )
          .timeout(duration);

      return requestReservationModel;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'local time out');
    } catch (e) {
      throw CachExeption(message: 'local cach${e.toString()}');
    }
  }
}
