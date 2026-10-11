import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/provider/providers.dart';
import 'package:mysen/core/services/local_notfication_services.dart';
import 'package:mysen/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseInfo().init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final sharedPreferences = await SharedPreferences.getInstance();
  final notificationService = LocalNotificationService();
  await notificationService.init();
  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),

        localNotificationServiceProvider.overrideWithValue(notificationService),
      ],
      child: DevicePreview(enabled: true, builder: (context) => const MyApp()),
    ),
  );
}
