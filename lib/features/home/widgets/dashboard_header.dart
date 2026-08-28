import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controller/home_controller.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final latest = controller.latestPlant.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xff2E7D32),
              Color(0xff43A047),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              controller.greeting,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "PlantPal AI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            if (latest == null)
              const Text(
                "Scan your first plant to begin your collection.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            else
              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Last Scan",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    latest.plantName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "${latest.confidence.toStringAsFixed(0)}% AI Confidence",
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }
}