import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/request/data/models/request_reservation_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestReservationRemoteDataSource {
  final SupabaseClient client;
  RequestReservationRemoteDataSource({required this.client});

  final table = "requestreservation";
  final Duration duration = const Duration(seconds: duration15);
  Future<List<RequestReservationModel>> getRequestReservation() async {
    try {
      final resposne = await client
          .from(table)
          .select("*,patient(fullName,phone)")
          .timeout(duration);
      return resposne.map((e) => RequestReservationModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<RequestReservationModel> upsertRequestReservation(
    RequestReservationModel requestReservationModel,
  ) async {
    try {
      final resposne = await client
          .from(table)
          .upsert(
            requestReservationModel.toMap(),
            onConflict: 'patientID,doctorID',
          )
          .select("*,patient(fullName,phone)")
          .single()
          .timeout(duration);
      return RequestReservationModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<RequestReservationModel> updateRequestReservation(
    RequestReservationModel requestReservationModel,
  ) async {
    try {
      final response = await client
          .from(table)
          .update(requestReservationModel.toMap())
          .eq('id', requestReservationModel.id)
          .select("*,patient(fullName,phone)")
          .single()
          .timeout(duration);
      return RequestReservationModel.fromMap(response);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }
}
