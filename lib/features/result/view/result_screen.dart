import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../../plant/widgets/disease_analysis_card.dart';
import '../../plant/widgets/plant_health_card.dart';
import '../controller/result_controller.dart';
import '../widgets/action_buttons.dart';
import '../widgets/care_guide_card.dart';
import '../widgets/common_problems_card.dart';
import '../widgets/confidence_card.dart';
import '../widgets/info_card.dart';
import '../widgets/plant_header.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResultController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("AI Analysis"),
        centerTitle: true,
      ),
      body: Obx(() {
        final plant = controller.result;

        if (plant == null) {
          return const Center(
            child: Text("No Result Found"),
          );
        }

        return ResponsiveBuilder(
          mobile: _MobileResult(
            controller: controller,
          ),
          tablet: _DesktopResult(
            controller: controller,
          ),
          desktop: _DesktopResult(
            controller: controller,
          ),
        );
      }),
    );
  }
}

class _MobileResult extends StatelessWidget {
  final ResultController controller;

  const _MobileResult({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final plant = controller.result!;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          PlantHeader(
            plant: plant,
          ),

          const SizedBox(height: 20),

          ConfidenceCard(
            confidence: plant.confidence,
          ),

          const SizedBox(height: 20),

          PlantHealthCard(
            healthScore: plant.healthScore,
            healthStatus: plant.healthStatus,
          ),

          const SizedBox(height: 20),

          LayoutBuilder(
            builder: (context, constraints) {

              int columns;

              if (constraints.maxWidth < 450) {
                columns = 1;
              } else if (constraints.maxWidth < 900) {
                columns = 2;
              } else {
                columns = 3;
              }

              const spacing = 16.0;

              final cardWidth =
                  (constraints.maxWidth -
                      (columns - 1) * spacing) /
                      columns;

              final cards = [

                InfoCard(
                  icon: Icons.water_drop,
                  title: "Water",
                  value: plant.watering,
                  color: Colors.blue,
                ),

                InfoCard(
                  icon: Icons.wb_sunny,
                  title: "Sunlight",
                  value: plant.sunlight,
                  color: Colors.orange,
                ),

                InfoCard(
                  icon: Icons.grass,
                  title: "Soil",
                  value: plant.soil,
                  color: Colors.brown,
                ),

                InfoCard(
                  icon: Icons.science,
                  title: "Fertilizer",
                  value: plant.fertilizer,
                  color: Colors.green,
                ),

                InfoCard(
                  icon: Icons.opacity,
                  title: "Humidity",
                  value: plant.humidity,
                  color: Colors.cyan,
                ),

                InfoCard(
                  icon: Icons.thermostat,
                  title: "Temperature",
                  value: plant.temperature,
                  color: Colors.red,
                ),
              ];

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: cards.map(
                      (card) => SizedBox(
                    width: cardWidth,
                    child: card,
                  ),
                ).toList(),
              );
            },
          ),

          const SizedBox(height: 20),

          DiseaseAnalysisCard(
            diseaseDetected: plant.diseaseDetected,
            diseaseName: plant.diseaseName,
            diseaseDescription: plant.diseaseDescription,
            symptoms: plant.symptoms,
            diseaseCause: plant.diseaseCause,
            treatment: plant.treatment,
            prevention: plant.prevention,
          ),

          const SizedBox(height: 20),

          CareGuideCard(
            guide: plant.careGuide,
          ),

          const SizedBox(height: 20),

          CommonProblemsCard(
            problems: plant.commonProblems,
          ),

          const SizedBox(height: 20),

          Obx(
                () => ActionButtons(
              isFavorite: controller.isFavorite.value,
              onFavorite: controller.toggleFavorite,
              onExportPdf: controller.exportPdf,
              onSharePdf: controller.sharePdf,
              onReminder: () {
                Get.toNamed(
                  AppRoutes.reminder,
                  arguments: controller.result,
                );
              },
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _DesktopResult extends StatelessWidget {
  final ResultController controller;

  const _DesktopResult({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final plant = controller.result!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // LEFT SIDE
          Expanded(
            flex: 4,
            child: Column(
              children: [

                PlantHeader(
                  plant: plant,
                ),

                const SizedBox(height: 20),

                ConfidenceCard(
                  confidence: plant.confidence,
                ),

                const SizedBox(height: 20),

                PlantHealthCard(
                  healthScore: plant.healthScore,
                  healthStatus: plant.healthStatus,
                ),

                const SizedBox(height: 20),

                DiseaseAnalysisCard(
                  diseaseDetected: plant.diseaseDetected,
                  diseaseName: plant.diseaseName,
                  diseaseDescription: plant.diseaseDescription,
                  symptoms: plant.symptoms,
                  diseaseCause: plant.diseaseCause,
                  treatment: plant.treatment,
                  prevention: plant.prevention,
                ),
              ],
            ),
          ),

          const SizedBox(width: 30),

          // RIGHT SIDE
          Expanded(
            flex: 5,
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {

                    const spacing = 16.0;

                    final cardWidth =
                        (constraints.maxWidth - spacing) / 2;

                    final cards = [

                      InfoCard(
                        icon: Icons.water_drop,
                        title: "Water",
                        value: plant.watering,
                        color: Colors.blue,
                      ),

                      InfoCard(
                        icon: Icons.wb_sunny,
                        title: "Sunlight",
                        value: plant.sunlight,
                        color: Colors.orange,
                      ),

                      InfoCard(
                        icon: Icons.grass,
                        title: "Soil",
                        value: plant.soil,
                        color: Colors.brown,
                      ),

                      InfoCard(
                        icon: Icons.science,
                        title: "Fertilizer",
                        value: plant.fertilizer,
                        color: Colors.green,
                      ),

                      InfoCard(
                        icon: Icons.opacity,
                        title: "Humidity",
                        value: plant.humidity,
                        color: Colors.cyan,
                      ),

                      InfoCard(
                        icon: Icons.thermostat,
                        title: "Temperature",
                        value: plant.temperature,
                        color: Colors.red,
                      ),
                    ];

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: cards.map(
                            (card) => SizedBox(
                          width: cardWidth,
                          child: card,
                        ),
                      ).toList(),
                    );
                  },
                ),

                const SizedBox(height: 20),

                CareGuideCard(
                  guide: plant.careGuide,
                ),

                const SizedBox(height: 20),

                CommonProblemsCard(
                  problems: plant.commonProblems,
                ),

                const SizedBox(height: 20),

                Obx(
                      () => ActionButtons(
                    isFavorite: controller.isFavorite.value,
                    onFavorite: controller.toggleFavorite,
                    onExportPdf: controller.exportPdf,
                    onSharePdf: controller.sharePdf,
                    onReminder: () {
                      Get.toNamed(
                        AppRoutes.reminder,
                        arguments: controller.result,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}