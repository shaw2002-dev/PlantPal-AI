import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/storage/storage_service.dart';
import '../model/onboarding_model.dart';
import '../data/onboarding_data.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();

  final RxInt currentIndex = 0.obs;

  List<OnboardingModel> get pages => onboardingPages;

  bool get isLastPage =>
      currentIndex.value == pages.length - 1;

  @override
  void onInit() {
    super.onInit();

    // 🔒 Lock onboarding to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (isLastPage) {
      finishOnboarding();
      return;
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    if (currentIndex.value == 0) return;

    pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void skip() {
    pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> finishOnboarding() async {
    // 🔓 Allow rotation before leaving onboarding
    await _enableRotation();

    await StorageService.completeOnboarding();

    Get.offAllNamed(AppRoutes.navigation);
  }

  Future<void> _enableRotation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}