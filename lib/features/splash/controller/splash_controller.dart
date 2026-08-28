import 'dart:async';

import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/storage/storage_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (StorageService.onboardingCompleted) {
      Get.offAllNamed(
        AppRoutes.navigation,
      );
    } else {
      Get.offAllNamed(
        AppRoutes.onboarding,
      );
    }
  }
}