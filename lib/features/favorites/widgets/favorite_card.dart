import 'dart:io';

import 'package:flutter/material.dart';

import '../../plant/model/plant_result_model.dart';

class FavoriteCard extends StatelessWidget {
  final PlantResultModel plant;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const FavoriteCard({
    super.key,
    required this.plant,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black.withOpacity(.05),
            ),
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
                    children: const [

                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 18,
                      ),

                      SizedBox(width: 6),

                      const Text(
                        "Favorite",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}