import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/treament/data/models/treatment_case_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TreatmentRemoteDataSource {
  final SupabaseClient client;
  TreatmentRemoteDataSource({required this.client});

  final table = "treatmentCase";
  final Duration duration = const Duration(seconds: duration15);
  Future<List<TreatmentCaseModel>> getTreatmentCase() async {
    try {
      final resposne = await client.from(table).select().timeout(duration);
      return resposne.map((e) => TreatmentCaseModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<List<TreatmentCaseModel>> getTreatmentCaseByDpID(String dpID) async {
    try {
      final resposne = await client
          .from(table)
          .select()
          .eq('doctorPatientID', dpID)
          .timeout(duration);
      return resposne.map((e) => TreatmentCaseModel.fromMap(e)).toList();
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<TreatmentCaseModel> addTreatmentCase(
    TreatmentCaseModel treatmentCaseModel,
  ) async {
    try {
      final resposne = await client
          .from(table)
          .insert(treatmentCaseModel.toMap())
          .select()
          .single()
          .timeout(duration);
      return TreatmentCaseModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<TreatmentCaseModel> updateTreatmentCase(
    TreatmentCaseModel treatmentCaseModel,
  ) async {
    try {
      final resposne = await client
          .from(table)
          .update(treatmentCaseModel.toMap())
          .eq('id', treatmentCaseModel.id)
          .select()
          .single()
          .timeout(duration);
      return TreatmentCaseModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<String> deleteTreatmentCase(
    TreatmentCaseModel treatmentCaseModel,
  ) async {
    try {
      final String response = await client.rpc(
        'cancel_or_delete_treatment_case',
        params: {'p_treatment_case_id': treatmentCaseModel.id},
      );
      return response;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }
}
