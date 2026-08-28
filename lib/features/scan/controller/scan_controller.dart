import 'dart:io';

import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/image_picker_service.dart';

class ScanController extends GetxController {

  final Rx<File?> selectedImage = Rx<File?>(null);

  final RxBool isAnalyzing = false.obs;

  Future<void> pickFromCamera() async {
    try {
      final image = await ImagePickerService.pickCamera();

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Unable to open camera",
      );
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final image = await ImagePickerService.pickGallery();

      if (image != null) {
        selectedImage.value = image;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Unable to open gallery",
      );
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  Future<void> analyzePlant() async {
    if (selectedImage.value == null) return;

    Get.toNamed(
      AppRoutes.analysis,
      arguments: selectedImage.value,
    );
  }
}