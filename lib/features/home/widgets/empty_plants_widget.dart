import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/responsive/responsive.dart';

class EmptyPlantsWidget extends StatelessWidget {
  const EmptyPlantsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);

    final double iconSize = isDesktop
        ? 120
        : isTablet
        ? 100
        : 80;

    final double titleSize = isDesktop
        ? 28
        : isTablet
        ? 24
        : 22;

    final double subtitleSize = isDesktop
        ? 18
        : isTablet
        ? 16
        : 15;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconSize + 30,
              height: iconSize + 30,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.eco_rounded,
                size: iconSize,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "No Plants Yet",
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Scan your first plant to build your\npersonal AI plant collection.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: subtitleSize,
                color: Colors.grey.shade600,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 35),

            LayoutBuilder(
              builder: (context, constraints) {
                final buttonWidth = constraints.maxWidth > 320
                    ? 260.0
                    : constraints.maxWidth;

                return SizedBox(
                  width: buttonWidth,
                  height: 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2E7D32),
                          Color(0xFF43A047),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(.35),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.scan);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.document_scanner_outlined),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Scan Your First Plant",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}