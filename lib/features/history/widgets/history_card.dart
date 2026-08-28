import 'dart:io';

import 'package:flutter/material.dart';

import '../../plant/model/plant_result_model.dart';

class HistoryCard extends StatelessWidget {
  final PlantResultModel plant;
  final VoidCallback onTap;

  const HistoryCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 12,
            )
          ],
        ),
        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(plant.imagePath),
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    plant.plantName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    plant.scientificName,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      const Icon(
                        Icons.water_drop,
                        size: 18,
                        color: Colors.blue,
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          plant.watering,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "${plant.scannedAt.day}/${plant.scannedAt.month}/${plant.scannedAt.year}",
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}