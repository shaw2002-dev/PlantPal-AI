import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../controller/analysis_controller.dart';
import '../widgets/ai_steps.dart';
import '../widgets/progress_card.dart';
import '../widgets/scanning_image.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalysisController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ResponsiveBuilder(
          mobile: _MobileLayout(
            controller: controller,
          ),
          tablet: _DesktopLayout(
            controller: controller,
          ),
          desktop: _DesktopLayout(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final AnalysisController controller;

  const _MobileLayout({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [

          ScanningImage(
            image: controller.image,
          ),

          const SizedBox(height: 24),

          ProgressCard(
            controller: controller,
          ),

          const SizedBox(height: 24),

          AiSteps(
            controller: controller,
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final AnalysisController controller;

  const _DesktopLayout({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            flex: 5,
            child: ScanningImage(
              image: controller.image,
            ),
          ),

          const SizedBox(width: 30),

          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  ProgressCard(
                    controller: controller,
                  ),

                  const SizedBox(height: 24),

                  AiSteps(
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}