import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mysen/core/services/local_notfication_services.dart';
import 'package:mysen/core/services/sharedprefrenceservice.dart';
import 'package:mysen/core/utiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

/// Shared Preferences Service
final sharedPrefServiceProvider = Provider<SharedPrefService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return SharedPrefService(prefs);
});

/// Local Notification Service
final localNotificationServiceProvider = Provider<LocalNotificationService>((
  ref,
) {
  return LocalNotificationService();
});

final internetServiceProvider = Provider<InternetService>(
  (ref) => InternetService(),
);
