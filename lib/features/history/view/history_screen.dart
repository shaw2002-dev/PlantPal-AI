import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controller/history_controller.dart';
import '../widgets/history_card.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final HistoryController controller =
  Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan History"),
        actions: [

          IconButton(
            onPressed: controller.clearHistory,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Obx(() {

        if (controller.history.isEmpty) {
          return const Center(
            child: Text(
              "No Scan History",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh:
          controller.refreshHistory,
          child: ListView.builder(
            padding:
            const EdgeInsets.all(20),
            itemCount:
            controller.history.length,
            itemBuilder: (_, index) {

              final plant =
              controller.history[index];

              return HistoryCard(
                plant: plant,
                onTap: () {

                  Get.toNamed(
                    AppRoutes.result,
                    arguments: plant,
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}