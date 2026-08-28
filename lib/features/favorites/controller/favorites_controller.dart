import 'package:get/get.dart';

import '../../plant/model/plant_result_model.dart';
import '../../plant/repository/plant_repository.dart';

class FavoritesController extends GetxController {
  final RxList<PlantResultModel> favorites =
      <PlantResultModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    favorites.assignAll(
      PlantRepository.getFavorites(),
    );
  }

  Future<void> refreshFavorites() async {
    loadFavorites();
  }

  Future<void> removeFavorite(
      PlantResultModel plant) async {
    await PlantRepository.toggleFavorite(
      plant,
    );

    loadFavorites();
  }
}