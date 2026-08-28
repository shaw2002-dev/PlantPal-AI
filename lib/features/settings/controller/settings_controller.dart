import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../history/controller/history_controller.dart';
import '../../favorites/controller/favorites_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../plant/repository/plant_repository.dart';

class SettingsController extends GetxController {
  final RxBool darkMode = false.obs;

  Future<void> clearHistory() async {
    await PlantRepository.clearHistory();

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDashboard();
    }

    if (Get.isRegistered<HistoryController>()) {
      Get.find<HistoryController>().loadHistory();
    }

    _showSuccessSnackbar(
      "Success",
      "History cleared successfully",
    );
  }

  Future<void> clearFavorites() async {
    await PlantRepository.clearFavorites();

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadDashboard();
    }

    if (Get.isRegistered<FavoritesController>()) {
      Get.find<FavoritesController>().loadFavorites();
    }

    _showSuccessSnackbar(
      "Success",
      "Favorites cleared successfully",
    );
  }

  void toggleTheme(bool value) {
    darkMode.value = value;

    Get.changeThemeMode(
      value ? ThemeMode.dark : ThemeMode.light,
    );
  }

  void _showSuccessSnackbar(
      String title,
      String message,
      ) {
    final isDark = Get.isDarkMode;

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDark
          ? Colors.white
          : Colors.green,
      colorText: isDark
          ? Colors.black
          : Colors.white,
      icon: Icon(
        Icons.check_circle,
        color: isDark
            ? Colors.green
            : Colors.white,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: const Duration(seconds: 3),
    );
  }
}