import 'package:get/get.dart';

import '../../plant/model/plant_result_model.dart';
import '../../plant/repository/plant_repository.dart';

class HistoryController extends GetxController {
  final RxList<PlantResultModel> history =
      <PlantResultModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    history.assignAll(
      PlantRepository.getHistory(),
    );
  }

  Future<void> refreshHistory() async {
    loadHistory();
  }

  Future<void> clearHistory() async {
    await PlantRepository.clearHistory();

    history.clear();
  }
}