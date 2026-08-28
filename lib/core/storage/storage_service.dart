import 'package:hive_flutter/hive_flutter.dart';

import 'storage_keys.dart';

class StorageService {
  StorageService._();

  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox(
      StorageKeys.appBox,
    );
  }

  static bool get onboardingCompleted =>
      _box.get(
        StorageKeys.onboardingCompleted,
        defaultValue: false,
      );

  static Future<void> completeOnboarding() async {
    await _box.put(
      StorageKeys.onboardingCompleted,
      true,
    );
  }

  static Future<void> clearAppData() async {
    await _box.clear();
  }
}