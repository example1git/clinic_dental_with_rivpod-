import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/doctor_patient/data/models/doctor_patient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorPatientRemoteDatasource {
  final SupabaseClient client;

  final table = "doctorpateint";
  final Duration duration = const Duration(seconds: duration15);
  DoctorPatientRemoteDatasource({required this.client});
  Future<List<DoctorPatientModel>> getDoctorPatient() async {
    try {
      final resposne = await client
          .from(table)
          .select(
            "id,doctorID,patientID,doctor(fullName),patient(fullName,phone)",
          )
          .timeout(duration);
      return resposne.map((e) => DoctorPatientModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<DoctorPatientModel> upsertDoctorPatient(
    DoctorPatientModel doctorPatientModel,
  ) async {
    try {
      final resposne = await client
          .from(table)
          .upsert(doctorPatientModel.toMap(), onConflict: 'patientID,doctorID')
          .eq('id', doctorPatientModel.id)
          .select(
            "id,doctorID,patientID,doctor(fullName),patient(fullName,phone)",
          )
          .single()
          .timeout(duration);
      return DoctorPatientModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<DoctorPatientModel> updateDoctorPatient(
    DoctorPatientModel doctorPatientModel,
  ) async {
    try {
      final resposne = await client
          .from(table)
          .update(doctorPatientModel.toMap())
          .eq('id', doctorPatientModel.id)
          .select(
            "id,doctorID,patientID,doctor(fullName),patient(fullName,phone)",
          )
          .single()
          .timeout(duration);
      return DoctorPatientModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<void> deleteDoctorPatient(
    DoctorPatientModel doctorPatientModel,
  ) async {
    try {
      await client
          .from(table)
          .delete()
          .eq('id', doctorPatientModel.id)
          .timeout(duration);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }
}
