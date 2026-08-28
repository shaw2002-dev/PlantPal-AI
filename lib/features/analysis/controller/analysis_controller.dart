import 'dart:io';

import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/gemini_service.dart';
import '../../favorites/controller/favorites_controller.dart';
import '../../history/controller/history_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../plant/repository/plant_repository.dart';
import '../../result/controller/result_controller.dart';

class AnalysisController extends GetxController {

  final RxDouble progress = 0.0.obs;

  final RxString currentStep =
      "Preparing AI...".obs;

  late File image;

  @override
  void onInit() {
    super.onInit();

    image = Get.arguments as File;

    startAnalysis();
  }

  Future<void> startAnalysis() async {

    progress.value = .10;
    currentStep.value = "Uploading Image...";

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    progress.value = .35;
    currentStep.value =
    "Identifying Plant Species...";

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    progress.value = .65;
    currentStep.value =
    "Generating Care Guide...";

    try {
      final result =
      await PlantRepository.analyzePlant(image);

      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>()
            .loadDashboard();
      }

      if (Get.isRegistered<HistoryController>()) {
        Get.find<HistoryController>()
            .loadHistory();
      }

      if (Get.isRegistered<FavoritesController>()) {
        Get.find<FavoritesController>()
            .loadFavorites();
      }

      progress.value = .90;

      currentStep.value = "Preparing Beautiful Report...";

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      progress.value = 1.0;

      Get.offNamed(
        AppRoutes.result,
        arguments: result,
      );
    } catch (e) {
      Get.snackbar(
        "Analysis Failed",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.back();
    }
  }
}