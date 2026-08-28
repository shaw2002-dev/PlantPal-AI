import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';
import '../../plant/model/plant_result_model.dart';
import '../model/reminder_model.dart';
import '../repository/reminder_repository.dart';

class ReminderController extends GetxController {
  final RxList<ReminderModel> reminders =
      <ReminderModel>[].obs;

  final Rx<TimeOfDay> selectedTime =
      const TimeOfDay(hour: 8, minute: 0).obs;

  final RxList<int> selectedDays = <int>[].obs;

  final RxBool enabled = true.obs;

  final RxBool hasExistingReminder = false.obs;

  PlantResultModel? plant;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null &&
        Get.arguments is PlantResultModel) {
      plant = Get.arguments;

      _loadExistingReminder();
    }

    loadReminders();
  }

  void loadReminders() {
    reminders.assignAll(
      ReminderRepository.getReminders(),
    );
  }

  void _loadExistingReminder() {
    final reminder = ReminderRepository.getReminder(
      plant!.plantName,
    );

    if (reminder == null) {
      hasExistingReminder.value = false;
      return;
    }

    hasExistingReminder.value = true;

    selectedTime.value = TimeOfDay(
      hour: reminder.hour,
      minute: reminder.minute,
    );

    selectedDays.assignAll(
      reminder.weekDays,
    );

    enabled.value = reminder.enabled;
  }

  Future<void> pickTime(
      BuildContext context,
      ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );

    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  void toggleDay(int day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  Future<void> saveReminder() async {
    if (plant == null) return;

    if (selectedDays.isEmpty) {
      _showSnackbar(
        "Select Days",
        "Please select at least one day.",
        isError: true,
      );

      return;
    }

    final existing = ReminderRepository.getReminder(
      plant!.plantName,
    );

    final bool isUpdating = existing != null;

    final reminder = ReminderModel(
      id: existing?.id ??
          (DateTime.now().millisecondsSinceEpoch %
              2147483647),
      plantName: plant!.plantName,
      imagePath: plant!.imagePath,
      hour: selectedTime.value.hour,
      minute: selectedTime.value.minute,
      weekDays: selectedDays.toList(),
      enabled: enabled.value,
    );

    await ReminderRepository.saveReminder(
      reminder,
    );

    loadReminders();

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDueTodayPlants();
    }

    Get.back();

    _showSnackbar(
      isUpdating
          ? "Reminder Updated"
          : "Reminder Saved",
      isUpdating
          ? "Water reminder updated successfully."
          : "Water reminder created successfully.",
    );
  }

  Future<void> deleteReminder() async {
    if (plant == null) return;

    final reminder =
    ReminderRepository.getReminder(
      plant!.plantName,
    );

    if (reminder == null) return;

    await ReminderRepository.deleteReminder(
      reminder,
    );

    loadReminders();

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDueTodayPlants();
    }

    Get.back();

    _showSnackbar(
      "Deleted",
      "Reminder removed successfully.",
      isError: true,
    );
  }

  void toggleEnable(bool value) {
    enabled.value = value;
  }

  String get formattedTime {
    final hour =
    selectedTime.value.hourOfPeriod == 0
        ? 12
        : selectedTime.value.hourOfPeriod;

    final minute = selectedTime.value.minute
        .toString()
        .padLeft(2, '0');

    final period =
    selectedTime.value.period == DayPeriod.am
        ? "AM"
        : "PM";

    return "$hour:$minute $period";
  }

  bool isSelected(int day) {
    return selectedDays.contains(day);
  }

  void _showSnackbar(
      String title,
      String message, {
        bool isError = false,
      }) {
    final isDark = Get.isDarkMode;

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,

      backgroundColor: isDark
          ? Colors.white
          : isError
          ? Colors.red
          : Colors.green,

      colorText: isDark
          ? Colors.black
          : Colors.white,

      icon: Icon(
        isError
            ? Icons.warning_amber_rounded
            : Icons.check_circle,
        color: isDark
            ? isError
            ? Colors.red
            : Colors.green
            : Colors.white,
      ),

      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: const Duration(seconds: 3),
    );
  }

  void initializePlant(PlantResultModel selectedPlant) {
    plant = selectedPlant;

    final reminder = ReminderRepository.getReminder(
      selectedPlant.plantName,
    );

    if (reminder != null) {
      hasExistingReminder.value = true;

      selectedTime.value = TimeOfDay(
        hour: reminder.hour,
        minute: reminder.minute,
      );

      selectedDays.assignAll(
        reminder.weekDays,
      );

      enabled.value = reminder.enabled;
    } else {
      hasExistingReminder.value = false;

      selectedTime.value = const TimeOfDay(
        hour: 8,
        minute: 0,
      );

      selectedDays.clear();

      enabled.value = true;
    }
  }
}