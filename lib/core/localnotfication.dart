import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class LocalNotificationService {
  // Singleton (مثيل واحد فقط)
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// 🔹 تهيئة النظام (تُستدعى مرة واحدة عند تشغيل التطبيق)
  Future<void> init() async {
    // إعداد المنطقة الزمنية
    tzdata.initializeTimeZones();

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
    );

    await _notifications.initialize(initSettings);

    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  /// 🔹 عرض إشعار فوري (للتجربة)
  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'default_channel_id',
          'General Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(0, title, body, platformDetails);
  }

  /// 🔹 جدولة إشعار قبل 2 ساعات من الموعد
  Future<void> scheduleAppointmentReminder({
    required DateTime appointmentTime,
    required String doctorName,
  }) async {
    // حساب وقت التذكير
    final reminderTime = appointmentTime.subtract(const Duration(hours: 2));

    // إذا الموعد بعد أقل من 2 ساعات، لا يتم الجدولة
    if (reminderTime.isBefore(DateTime.now())) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'appointment_channel_id',
          'Appointment Reminders',
          channelDescription: 'Reminders for upcoming appointments',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.zonedSchedule(
      appointmentTime.hashCode, // ID فريد
      'تذكير بالموعد',
      'لديك موعد مع الدكتور / ه : ${doctorName.split(' ').sublist(0, 2).join()}${doctorName.split(' ').last} في ${DateFormat('yyyy-MM-dd hh : mm a').format(appointmentTime)}',
      tz.TZDateTime.from(reminderTime, tz.local),
      details,

      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// 🔹 إلغاء جميع الإشعارات المجدولة
  Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  /// 🔹 إلغاء إشعار واحد حسب الـ ID
  Future<void> cancelById(int id) async {
    await _notifications.cancel(id);
  }
}
