import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive.dart';
import '../controller/analysis_controller.dart';

class ProgressCard extends StatelessWidget {
  final AnalysisController controller;

  const ProgressCard({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final titleSize = isDesktop
        ? 26.0
        : isTablet
        ? 24.0
        : 20.0;

    final subtitleSize = isDesktop
        ? 18.0
        : isTablet
        ? 17.0
        : 15.0;

    final percentSize = isDesktop
        ? 42.0
        : isTablet
        ? 38.0
        : 32.0;

    return Obx(
          () => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
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

            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.12),
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.green,
                    size: 32,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PlantPal AI",
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        controller.currentStep.value,
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            TweenAnimationBuilder<double>(
              tween: Tween(
                begin: 0,
                end: controller.progress.value,
              ),
              duration:
              const Duration(milliseconds: 500),
              builder: (_, value, __) {
                return Column(
                  children: [
                    Text(
                      "${(value * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: percentSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: 10,
                        backgroundColor:
                        Colors.grey.shade200,
                        valueColor:
                        const AlwaysStoppedAnimation(
                          Colors.green,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            Text(
              "Analyzing your plant using Gemini AI...",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}