import 'package:get/get.dart';

import '../../features/result/controller/result_controller.dart';

class ResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultController>(
          () => ResultController(),
    );
  }
}