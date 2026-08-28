import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderService {
  ReminderService._();

  static final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();

    String timezone = await FlutterTimezone.getLocalTimezone();

    if (timezone == "Asia/Calcutta") {
      timezone = "Asia/Kolkata";
    }

    try {
      tz.setLocalLocation(tz.getLocation(timezone));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation("UTC"));
    }

    const settings = InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
      iOS: DarwinInitializationSettings(),
      macOS: DarwinInitializationSettings(),
      linux: LinuxInitializationSettings(
        defaultActionName: 'Open notification',
      ),
      windows: WindowsInitializationSettings(
        appName: 'PlantPal AI',
        appUserModelId: 'com.plantpal.ai',
        guid: '5c8c1d67-b0d5-4a9b-9c38-9d5f4fd4b0f6',
      ),
    );

    await _notifications.initialize(settings: settings);

    const AndroidNotificationChannel channel =
    AndroidNotificationChannel(
      'plantpal_channel',
      'Plant Reminders',
      description: 'Plant watering reminders',
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    if (Platform.isAndroid) {
      await requestPermission();
    }
  }

  static Future<void> requestPermission() async {
    await Permission.notification.request();

    final android =
    _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();

    await android?.requestExactAlarmsPermission();

  }

  static tz.TZDateTime _nextInstanceOfWeekday(
      int weekday,
      int hour,
      int minute,
      ) {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    while (scheduled.weekday != weekday ||
        scheduled.isBefore(now)) {
      scheduled = scheduled.add(
        const Duration(days: 1),
      );
    }

    return scheduled;
  }

  static Future<void> scheduleReminder({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
    required List<int> weekDays,
  }) async {
    // Cancel previously scheduled notifications
    for (int i = 1; i <= 7; i++) {
      await _notifications.cancel(
        id: id + i,
      );
    }

    for (final day in weekDays) {
      final scheduledDate = _nextInstanceOfWeekday(
        day,
        hour,
        minute,
      );

      await _notifications.zonedSchedule(
          id: id + day,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'plantpal_channel',
              'Plant Reminders',
              channelDescription: 'Plant watering reminders',
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
    }
  }

  static Future<void> cancelReminder(int id) async {
    for (int i = 1; i <= 7; i++) {
      await _notifications.cancel(
        id: id + i,
      );
    }
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  static Future<void> showTestNotification() async {
    await _notifications.show(
      id: 9999,
      title: "🌿 PlantPal AI",
      body: "Time to water your plant!",
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'plantpal_channel',
          'Plant Reminders',
          channelDescription: 'Plant watering reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }
}