import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tzdata.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidInit);

    await _notifications.initialize(initSettings);

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    _initialized = true;
  }

  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel_id',
      'General Notifications',
      channelDescription: 'General application notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  Future<void> scheduleAppointmentReminder({
    required DateTime appointmentTime,
    required String doctorName,
  }) async {
    final reminderTime = appointmentTime.subtract(const Duration(hours: 2));

    if (reminderTime.isBefore(DateTime.now())) {
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'appointment_channel_id',
      'Appointment Reminders',
      channelDescription: 'Reminders for upcoming appointments',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const details = NotificationDetails(android: androidDetails);

    final doctorDisplayName = _formatDoctorName(doctorName);

    final formattedDate = DateFormat('yyyy-MM-dd hh:mm a')
        .format(appointmentTime);

    await _notifications.zonedSchedule(
      appointmentTime.hashCode,
      'تذكير بالموعد',
      'لديك موعد مع الدكتور/ة $doctorDisplayName في $formattedDate',
      tz.TZDateTime.from(reminderTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  String _formatDoctorName(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return name;
    }

    if (parts.length == 1) {
      return parts.first;
    }

    return parts.take(2).join(' ');
  }

  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  Future<void> cancelById(int id) async {
    await _notifications.cancel(id);
  }
}
