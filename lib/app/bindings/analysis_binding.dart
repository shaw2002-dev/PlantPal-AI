import 'package:get/get.dart';

import '../../features/analysis/controller/analysis_controller.dart';

class AnalysisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisController>(
          () => AnalysisController(),
    );
  }
}