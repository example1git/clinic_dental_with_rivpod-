import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/patient/data/models/patient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PatientRemoteDataSorce {
  final SupabaseClient client;

  final table = "patient";
  final Duration duration = const Duration(seconds: duration15);
  PatientRemoteDataSorce({required this.client});
  Future<PatientModel?> getPatientByuserID() async {
    try {
      final userID = client.auth.currentUser?.id ?? '';
      final resposne = await client
          .from(table)
          .select("id,fullName,phone")
          .eq('userID', userID)
          .maybeSingle()
          .timeout(duration);
      if (resposne == null) {
        return null;
      }
      return PatientModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<PatientModel?> getPatientByPhone(String phone) async {
    try {
      final resposne = await client
          .from(table)
          .select("id,fullName,phone")
          .eq('phone', phone)
          .maybeSingle()
          .timeout(duration);
      if (resposne == null) {
        return null;
      }
      return PatientModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<PatientModel> addPatient(PatientModel patientModel) async {
    try {
      final resposne = await client
          .from(table)
          .insert(patientModel.toMap())
          .select()
          .single()
          .timeout(duration);
      return PatientModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }
}
