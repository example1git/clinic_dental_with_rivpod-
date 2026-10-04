import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const Color whitecolor = Colors.white;
const Color blackcolor = Colors.black;
const duration15 = 15;
const double elevation = 3;
final SupabaseClient client = Supabase.instance.client;

class SupabaseInfo {
  Future<void> init() async {
    await dotenv.load(fileName: '.env');
    try {
      await Supabase.initialize(
        url: dotenv.env['supabaseUrl']!,
        // ignore: deprecated_member_use
        anonKey: dotenv.env['supabaseAnoneKey']!,
        authOptions: FlutterAuthClientOptions(
          autoRefreshToken: true,
          localStorage: SharedPreferencesLocalStorage(
            persistSessionKey: 'supabase_session',
          ),
        ),
      );
    } catch (_) {}
  }
}
