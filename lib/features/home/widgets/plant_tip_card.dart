import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';

class PlantTipCard extends StatelessWidget {
  final String tip;
  final VoidCallback? onLearnMore;

  const PlantTipCard({
    super.key,
    required this.tip,
    this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    final height = Responsive.height(context);

    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final titleSize = isDesktop
        ? 24.0
        : isTablet
        ? 22.0
        : 20.0;

    final bodySize = isDesktop
        ? 17.0
        : isTablet
        ? 16.0
        : 14.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.tips_and_updates_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Tip",
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                SizedBox(height: height * .01),

                Text(
                  tip,
                  style: TextStyle(
                    fontSize: bodySize,
                    color: Colors.grey.shade700,
                    height: 1.7,
                  ),
                ),

                SizedBox(height: height * .02),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: onLearnMore,
                    icon: const Icon(
                      Icons.arrow_forward,
                      size: 18,
                    ),
                    label: const Text("Learn More"),
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