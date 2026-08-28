import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class PlantPalApp extends StatelessWidget {
  const PlantPalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: "PlantPal AI",

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      themeMode: ThemeMode.system,

      initialRoute: AppRoutes.splash,

      getPages: AppPages.routes,
    );
  }
}