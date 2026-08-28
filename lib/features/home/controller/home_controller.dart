import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../plant/model/plant_result_model.dart';
import '../../plant/repository/plant_repository.dart';
import '../../reminder/model/reminder_model.dart';
import '../../reminder/repository/reminder_repository.dart';

class HomeController extends GetxController
    with WidgetsBindingObserver {
  final RxInt totalPlants = 0.obs;

  final RxInt totalFavorites = 0.obs;

  final RxInt totalScans = 0.obs;

  final RxString userName = "Plant Lover".obs;

  final RxString todayTip = "".obs;

  final RxString searchText = "".obs;

  final RxInt dueToday = 0.obs;

  final RxList<PlantResultModel> filteredPlants =
      <PlantResultModel>[].obs;

  final RxList<PlantResultModel> allPlants =
      <PlantResultModel>[].obs;

  final RxList<ReminderModel> dueTodayPlants =
      <ReminderModel>[].obs;

  final RxList<PlantResultModel> recentPlants =
      <PlantResultModel>[].obs;

  final Rx<PlantResultModel?> latestPlant =
  Rx<PlantResultModel?>(null);

  Timer? _dateTimer;

  DateTime _currentDate = DateTime.now();

  @override
  void onInit() {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);

    loadDashboard();

    _startDateWatcher();
  }

  void loadDashboard() {
    totalPlants.value = PlantRepository.totalPlants;

    totalFavorites.value =
        PlantRepository.totalFavorites;

    totalScans.value =
        PlantRepository.totalScans;

    loadDueTodayPlants();

    final favorites =
    PlantRepository.getFavorites();

    final favoriteNames = favorites
        .map(
          (plant) => plant.scientificName,
    )
        .toSet();

    final history =
    PlantRepository.getHistory().map(
          (plant) {
        return plant.copyWith(
          isFavorite: favoriteNames.contains(
            plant.scientificName,
          ),
        );
      },
    ).toList();

    allPlants.assignAll(history);

    final recent =
    PlantRepository.recentPlants().map(
          (plant) {
        return plant.copyWith(
          isFavorite: favoriteNames.contains(
            plant.scientificName,
          ),
        );
      },
    ).toList();

    recentPlants.assignAll(recent);

    final latest =
    PlantRepository.latestPlant();

    if (latest != null) {
      latestPlant.value = latest.copyWith(
        isFavorite: favoriteNames.contains(
          latest.scientificName,
        ),
      );
    } else {
      latestPlant.value = null;
    }

    todayTip.value = _generateTip();

    filteredPlants.assignAll(allPlants);
  }

  void loadDueTodayPlants() {
    final reminders =
    ReminderRepository.getReminders();

    final today = DateTime.now().weekday;

    final plantsDueToday =
    reminders.where((reminder) {
      return reminder.enabled &&
          reminder.weekDays.contains(today);
    }).toList();

    plantsDueToday.sort((a, b) {
      final firstMinutes =
          (a.hour * 60) + a.minute;

      final secondMinutes =
          (b.hour * 60) + b.minute;

      return firstMinutes.compareTo(
        secondMinutes,
      );
    });

    dueTodayPlants.assignAll(
      plantsDueToday,
    );

    dueToday.value =
        plantsDueToday.length;
  }

  void refreshDueToday() {
    loadDueTodayPlants();
  }

  void _startDateWatcher() {
    _dateTimer?.cancel();

    _dateTimer = Timer.periodic(
      const Duration(minutes: 1),
          (_) {
        final now = DateTime.now();

        final dateChanged =
            now.year != _currentDate.year ||
                now.month != _currentDate.month ||
                now.day != _currentDate.day;

        if (dateChanged) {
          _currentDate = now;

          loadDueTodayPlants();
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state,
      ) {
    if (state == AppLifecycleState.resumed) {
      _currentDate = DateTime.now();

      loadDashboard();
    }
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning 🌿";
    } else if (hour < 17) {
      return "Good Afternoon ☀️";
    } else {
      return "Good Evening 🌙";
    }
  }

  String _generateTip() {
    final latest = latestPlant.value;

    if (latest == null) {
      return "Scan your first plant to receive personalized AI care tips.";
    }

    String watering =
    latest.watering.trim();

    if (watering.isEmpty) {
      return "💧 ${latest.plantName}: Water according to the soil moisture and sunlight conditions.";
    }

    watering =
        watering[0].toUpperCase() +
            watering.substring(1);

    watering = watering.replaceAllMapped(
      RegExp(r'\.\s*([a-z])'),
          (match) =>
      '. ${match.group(1)!.toUpperCase()}',
    );

    return "💧 ${latest.plantName} should be watered. $watering";
  }

  void searchPlant(String query) {
    searchText.value = query;

    if (query.trim().isEmpty) {
      filteredPlants.assignAll(
        allPlants,
      );

      return;
    }

    final searchQuery =
    query.trim().toLowerCase();

    filteredPlants.assignAll(
      allPlants.where((plant) {
        return plant.plantName
            .toLowerCase()
            .contains(searchQuery);
      }).toList(),
    );
  }

  void clearSearch() {
    searchText.value = "";

    filteredPlants.assignAll(
      allPlants,
    );
  }

  @override
  void onClose() {
    _dateTimer?.cancel();

    WidgetsBinding.instance.removeObserver(
      this,
    );

    super.onClose();
  }
}

