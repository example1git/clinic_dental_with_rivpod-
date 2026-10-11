import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/appointment/data/models/appointment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentRemoteDataSorce {
  final SupabaseClient client;
  AppointmentRemoteDataSorce({required this.client});

  final table = "appointment";
  final Duration duration = const Duration(seconds: duration15);
  Future<List<AppointmentModel>> getAppointment() async {
    try {
      final resposne = await client.from(table).select().timeout(duration);
      return resposne.map((e) => AppointmentModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<List<AppointmentModel>> getAppointmentByDpid(String dpID) async {
    try {
      final resposne = await client
          .from(table)
          .select()
          .eq('doctorPatientID', dpID)
          .timeout(duration);
      return resposne.map((e) => AppointmentModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<AppointmentModel> addAppointment(
    AppointmentModel appointmentModel,
  ) async {
    try {
      final resposne = await client
          .from(table)
          .insert(appointmentModel.toMap())
          .select()
          .single()
          .timeout(duration);
      return AppointmentModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }
}
