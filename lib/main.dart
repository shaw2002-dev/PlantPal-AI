import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'core/services/reminder_service.dart';
import 'core/storage/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await StorageService.init();

  //await StorageService.clearAppData();

  await ReminderService.initialize();

  runApp(
    const PlantPalApp(),
  );
}
