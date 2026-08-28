import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';

class RecentPlantCard extends StatelessWidget {
  final String image;
  final String plantName;
  final String scientificName;
  final String nextWatering;
  final bool isFavorite;
  final VoidCallback onTap;

  const RecentPlantCard({
    super.key,
    required this.image,
    required this.plantName,
    required this.scientificName,
    required this.nextWatering,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final imageSize = isDesktop
        ? 95.0
        : isTablet
        ? 85.0
        : 72.0;

    final titleSize = isDesktop
        ? 22.0
        : isTablet
        ? 20.0
        : 17.0;

    final subtitleSize = isDesktop
        ? 15.0
        : isTablet
        ? 14.0
        : 13.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.file(
                  File(image),
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                )
              ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    plantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    scientificName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: subtitleSize,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.water_drop,
                        color: Colors.blue,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Expanded(
                        child: Text(
                          nextWatering,
                          style: TextStyle(
                            fontSize: subtitleSize,
                            color: Colors.black
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: imageSize,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 18,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}