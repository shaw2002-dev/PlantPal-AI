import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/services/reminder_service.dart';
import '../../../core/storage/storage_keys.dart';
import '../model/reminder_model.dart';

class ReminderRepository {
  ReminderRepository._();

  static Box get _box => Hive.box(StorageKeys.appBox);

  static const String _key =
      StorageKeys.reminders;

  static List<ReminderModel> getReminders() {
    final List reminders = _box.get(
      _key,
      defaultValue: [],
    );

    return reminders
        .map(
          (e) => ReminderModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  static Future<void> saveReminder(
      ReminderModel reminder,
      ) async {
    final reminders = getReminders();

    final index = reminders.indexWhere(
          (e) =>
      e.plantName == reminder.plantName,
    );

    if (index == -1) {
      reminders.add(reminder);
    } else {
      reminders[index] = reminder;
    }

    await _save(reminders);

    if (reminder.enabled) {
      await ReminderService.scheduleReminder(
        id: reminder.id,
        title: "🌿 Water Reminder",
        body: "Time to water ${reminder.plantName}",
        hour: reminder.hour,
        minute: reminder.minute,
        weekDays: reminder.weekDays,
      );
    }
  }

  static int get todayReminderCount {
    final reminders = getReminders();

    final today = DateTime.now().weekday;

    return reminders.where((e) {
      return e.enabled &&
          e.weekDays.contains(today);
    }).length;
  }

  static Future<void> deleteReminder(
      ReminderModel reminder,
      ) async {
    final reminders = getReminders();

    reminders.removeWhere(
          (e) =>
      e.plantName == reminder.plantName,
    );

    await _save(reminders);

    await ReminderService.cancelReminder(
      reminder.id,
    );
  }

  static Future<void> updateReminder(
      ReminderModel reminder,
      ) async {
    await saveReminder(reminder);
  }

  static Future<void> enableReminder(
      ReminderModel reminder,
      ) async {
    await saveReminder(
      ReminderModel(
        id: reminder.id,
        plantName: reminder.plantName,
        imagePath: reminder.imagePath,
        hour: reminder.hour,
        minute: reminder.minute,
        weekDays: reminder.weekDays,
        enabled: true,
      ),
    );
  }

  static Future<void> disableReminder(
      ReminderModel reminder,
      ) async {
    await ReminderService.cancelReminder(
      reminder.id,
    );

    final reminders = getReminders();

    final index = reminders.indexWhere(
          (e) =>
      e.plantName == reminder.plantName,
    );

    if (index != -1) {
      reminders[index] = ReminderModel(
        id: reminder.id,
        plantName: reminder.plantName,
        imagePath: reminder.imagePath,
        hour: reminder.hour,
        minute: reminder.minute,
        weekDays: reminder.weekDays,
        enabled: false,
      );

      await _save(reminders);
    }
  }

  static ReminderModel? getReminder(
      String plantName,
      ) {
    try {
      return getReminders().firstWhere(
            (e) => e.plantName == plantName,
      );
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearReminders() async {
    final reminders = getReminders();

    for (final reminder in reminders) {
      await ReminderService.cancelReminder(
        reminder.id,
      );
    }

    await _box.delete(_key);
  }

  static Future<void> _save(
      List<ReminderModel> reminders,
      ) async {
    await _box.put(
      _key,
      reminders
          .map((e) => e.toJson())
          .toList(),
    );
  }
}