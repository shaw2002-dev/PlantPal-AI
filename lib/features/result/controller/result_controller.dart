import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/services/pdf_service.dart';
import '../../favorites/controller/favorites_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../plant/model/plant_result_model.dart';
import '../../plant/repository/plant_repository.dart';


class ResultController extends GetxController {

  final Rx<PlantResultModel?> plant =
  Rx<PlantResultModel?>(null);

  final RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();

    plant.value = Get.arguments as PlantResultModel;

    final favorites = PlantRepository.getFavorites();

    isFavorite.value = favorites.any(
          (e) => e.scientificName == result.scientificName,
    );
  }

  PlantResultModel get result =>
      plant.value!;

  Future<void> toggleFavorite() async {
    await PlantRepository.toggleFavorite(result);

    final favorites =
    PlantRepository.getFavorites();

    isFavorite.value = favorites.any(
          (plant) =>
      plant.scientificName ==
          result.scientificName,
    );

    if (Get.isRegistered<FavoritesController>()) {
      Get.find<FavoritesController>()
          .loadFavorites();
    }

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>()
          .loadDashboard();
    }
  }

  Future<void> exportPdf() async {
    try {
      final file =
      await PdfService.generatePlantReport(result);

      _showSnackbar(
        title: "PDF Exported",
        message: "PDF saved successfully\n${file.path}",
      );
    } catch (e) {
      _showSnackbar(
        title: "Export Failed",
        message: e.toString(),
        isError: true,
      );
    }
  }

  Future<void> sharePdf() async {
    try {
      final file =
      await PdfService.generatePlantReport(result);

      await Share.shareXFiles(
        [
          XFile(file.path),
        ],
        text: "Plant Health Report",
      );
    } catch (e) {
      _showSnackbar(
        title: "Share Failed",
        message: e.toString(),
        isError: true,
      );
    }
  }

  void _showSnackbar({
    required String title,
    required String message,
    bool isError = false,
  }) {
    final isDark = Get.isDarkMode;

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError
          ? (isDark ? Colors.red.shade900 : Colors.red.shade50)
          : (isDark
          ? const Color(0xFF1E2A22)
          : Colors.green.shade50),
      colorText: isDark ? Colors.white : Colors.black87,
      icon: Icon(
        isError
            ? Icons.error_outline
            : Icons.check_circle_outline,
        color: isError
            ? Colors.redAccent
            : Colors.green,
      ),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}