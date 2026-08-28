import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/services/gemini_service.dart';
import '../../../core/storage/storage_keys.dart';
import '../model/plant_result_model.dart';

class PlantRepository {
  PlantRepository._();

  static Box get _box => Hive.box(StorageKeys.appBox);

  static Future<PlantResultModel> analyzePlant(
      File image,
      ) async {
    final result =
    await GeminiService.identifyPlant(image);

    await saveHistory(result);

    return result;
  }

  static Future<void> saveHistory(
      PlantResultModel plant,
      ) async {

    final List history =
    _box.get(
      StorageKeys.plantHistory,
      defaultValue: [],
    );

    history.insert(
      0,
      plant.toJson(),
    );

    await _box.put(
      StorageKeys.plantHistory,
      history,
    );
  }

  static List<PlantResultModel> getHistory() {

    final List history =
    _box.get(
      StorageKeys.plantHistory,
      defaultValue: [],
    );

    return history
        .map(
          (e) => PlantResultModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  static Future<void> clearHistory() async {

    await _box.delete(
      StorageKeys.plantHistory,
    );
  }

  static Future<void> toggleFavorite(
      PlantResultModel plant) async {

    final List favorites =
    _box.get(
      StorageKeys.favorites,
      defaultValue: [],
    );

    final index = favorites.indexWhere(
          (e) =>
      e["scientific_name"] ==
          plant.scientificName,
    );

    if (index == -1) {
      favorites.add(
        plant.copyWith(
          isFavorite: true,
        ).toJson(),
      );
    } else {
      favorites.removeAt(index);
    }

    await _box.put(
      StorageKeys.favorites,
      favorites,
    );
  }

  static List<PlantResultModel>
  getFavorites() {

    final List favorites =
    _box.get(
      StorageKeys.favorites,
      defaultValue: [],
    );

    return favorites
        .map(
          (e) => PlantResultModel.fromJson(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  static Future<void> clearFavorites() async {

    await _box.delete(
      StorageKeys.favorites,
    );
  }

  static int get totalScans {

    return getHistory().length;
  }

  static int get totalFavorites {

    return getFavorites().length;
  }

  static int get totalPlants {

    final history = getHistory();

    return history
        .map((e) => e.scientificName)
        .toSet()
        .length;
  }

  static List<PlantResultModel> recentPlants({

    int limit = 5,
  }) {

    final history = getHistory();

    if (history.length <= limit) {
      return history;
    }

    return history.take(limit).toList();
  }

  static PlantResultModel? latestPlant() {

    final history = getHistory();

    if (history.isEmpty) {
      return null;
    }

    return history.first;
  }
}