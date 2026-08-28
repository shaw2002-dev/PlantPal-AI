import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../../plant/model/plant_result_model.dart';

class PlantHeader extends StatelessWidget {
  final PlantResultModel plant;

  const PlantHeader({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final imageHeight = isDesktop
        ? 420.0
        : isTablet
        ? 340.0
        : 260.0;

    final titleSize = isDesktop
        ? 36.0
        : isTablet
        ? 32.0
        : 26.0;

    final scientificSize = isDesktop
        ? 18.0
        : isTablet
        ? 17.0
        : 15.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            child: plant.imagePath.isNotEmpty
                ? Image.file(
              File(plant.imagePath),
              width: double.infinity,
              height: imageHeight,
              fit: BoxFit.cover,
            )
                : Container(
              width: double.infinity,
              height: imageHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2E7D32),
                    Color(0xff43A047),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.eco,
                  color: Colors.white,
                  size: 120,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  plant.plantName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  plant.scientificName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: scientificSize,
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
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