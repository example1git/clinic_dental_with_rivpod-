import 'dart:async';

import 'package:mysen/core/constant.dart';
import 'package:mysen/core/exeption.dart';
import 'package:mysen/features/auth/data/models/user_details_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient client;
  AuthRemoteDataSource({required this.client});

  final table = "userdetails";
  final Duration duration = const Duration(seconds: duration15);
  Future<UserDetailsModel?> getUserDetails() async {
    try {
      final resposne = await client
          .from(table)
          .select('role,id')
          .eq('userID', client.auth.currentUser?.id ?? '')
          .maybeSingle()
          .timeout(duration);

      if (resposne == null) {
        return null;
      }
      return UserDetailsModel.fromMap(resposne);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<AuthResponse> signUp(String email, String password) async {
    try {
      final resposne = await client.auth
          .signUp(email: email, password: password)
          .timeout(duration);
      return resposne;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      final resposne = await client.auth
          .signInWithPassword(email: email, password: password)
          .timeout(duration);
      return resposne;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await client.auth.signOut().timeout(duration);
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<String> checkAndLinkUserRpc(String phone) async {
    try {
      final String resposne = await client
          .rpc('check_and_link_user', params: {'p_phone': phone.trim()})
          .timeout(duration);
      return resposne;
    } on TimeoutException {
      throw RequestTimeExeption(message: 'time out');
    } on PostgrestException catch (e) {
      throw ServerExeption(message: 'server${e.message}');
    } catch (e) {
      throw ServerExeption(message: 'server${e.toString()}');
    }
  }

  Future<void> createPatientUserRpc(String phone, String fullName) async {
    try {
      await client
          .rpc(
            'create_patient_user',
            params: {'p_phone': phone.trim(), 'p_fullname': fullName},
          )
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
