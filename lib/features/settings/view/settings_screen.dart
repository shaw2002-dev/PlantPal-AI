import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/settings_controller.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller =
  Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Obx(
            () => ListView(
          padding: const EdgeInsets.all(20),
          children: [

            SettingsTile(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              subtitle:
              "Enable dark appearance",
              color: Colors.indigo,
              trailing: Switch(
                value:
                controller.darkMode.value,
                onChanged:
                controller.toggleTheme,
              ),
            ),

            SettingsTile(
              icon: Icons.history,
              title: "Clear History",
              subtitle:
              "Remove all scan history",
              color: Colors.orange,
              onTap:
              controller.clearHistory,
            ),

            SettingsTile(
              icon: Icons.favorite,
              title: "Clear Favorites",
              subtitle:
              "Remove favorite plants",
              color: Colors.red,
              onTap:
              controller.clearFavorites,
            ),

            const SizedBox(height: 20),

            Center(
              child: Column(
                children: [

                  Icon(
                    Icons.eco,
                    color: Theme.of(context)
                        .colorScheme
                        .primary,
                    size: 70,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "PlantPal AI",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Version 1.0.0",
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Built with Flutter ❤️",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}