import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';

class ConfidenceCard extends StatelessWidget {
  final double confidence;

  const ConfidenceCard({
    super.key,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final cardHeight = isDesktop
        ? 190.0
        : isTablet
        ? 170.0
        : 150.0;

    final circleSize = isDesktop
        ? 110.0
        : isTablet
        ? 95.0
        : 82.0;

    final percentSize = isDesktop
        ? 26.0
        : isTablet
        ? 24.0
        : 20.0;

    final titleSize = isDesktop
        ? 22.0
        : isTablet
        ? 20.0
        : 18.0;

    final progress = (confidence / 100).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
          SizedBox(
            width: circleSize,
            height: circleSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: circleSize,
                  height: circleSize,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade200,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  "${confidence.toStringAsFixed(0)}%",
                  style: TextStyle(
                    fontSize: percentSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Confidence",
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  _confidenceLabel(confidence),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "The higher the confidence, the more certain the AI is about the identified plant.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _confidenceLabel(double value) {
    if (value >= 95) return "Excellent Match";
    if (value >= 85) return "Very Good Match";
    if (value >= 70) return "Good Match";
    if (value >= 50) return "Possible Match";
    return "Low Confidence";
  }
}