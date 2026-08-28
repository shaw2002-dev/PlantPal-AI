import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../plant/model/plant_result_model.dart';
import 'recent_plant_card.dart';

class RecentPlantsSection extends StatelessWidget {
  final List<PlantResultModel> plants;

  const RecentPlantsSection({
    super.key,
    required this.plants,
  });

  @override
  Widget build(BuildContext context) {
    if (plants.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "No plants scanned yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plants.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final plant = plants[index];

        return RecentPlantCard(
          image: plant.imagePath,
          plantName: plant.plantName,
          scientificName: plant.scientificName,
          nextWatering: plant.watering,
          isFavorite: plant.isFavorite,
          onTap: () {
            Get.toNamed(
              AppRoutes.result,
              arguments: plant,
            );
          },
        );
      },
    );
  }
}