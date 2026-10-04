import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/doctor/data/models/doctor_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DoctorRemotDataSource {
  final SupabaseClient client;

  final table = "doctor";
  final Duration duration = const Duration(seconds: duration15);
  DoctorRemotDataSource({required this.client});
  Future<List<DoctorModel>> getDoctors() async {
    try {
      final resposne = await client.from(table).select("*").timeout(duration);
      return resposne.map((e) => DoctorModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<DoctorModel?> getDoctorByUserID() async {
    try {
      final String userID = client.auth.currentUser?.id ?? '';
      final resposne = await client
          .from(table)
          .select("*")
          .eq('userID', userID)
          .maybeSingle()
          .timeout(duration);
      if (resposne == null) {
        return null;
      }
      return DoctorModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<DoctorModel?> getDoctorByPhone(String phone) async {
    try {
      final resposne = await client
          .from(table)
          .select("*")
          .eq('phone->>phone', phone)
          .maybeSingle()
          .timeout(duration);

      if (resposne == null) {
        return null;
      }
      return DoctorModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<DoctorModel> updateDoctor(DoctorModel doctor) async {
    try {
      final resposne = await client
          .from(table)
          .update(doctor.toMap())
          .eq('id', doctor.id)
          .select()
          .single()
          .timeout(duration);
      return DoctorModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }
}
