import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    final width = Responsive.width(context);
    final height = Responsive.height(context);

    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final horizontalPadding =
    Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// ================= PAGE VIEW =================
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.pages.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: controller.onPageChanged,
            itemBuilder: (_, index) {
              final page = controller.pages[index];

              return OnboardingPage(
                image: page.image,
              );
            },
          ),

          /// ================= SKIP BUTTON =================
          Positioned(
            top: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: height * 0.02,
                  right: horizontalPadding,
                ),
                child: Obx(
                      () => AnimatedOpacity(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    opacity: controller.isLastPage ? 0 : 1,
                    child: IgnorePointer(
                      ignoring: controller.isLastPage,
                      child: SizedBox(
                        width: isDesktop
                            ? 120
                            : isTablet
                            ? 105
                            : 95,
                        height: isDesktop ? 56 : 48,
                        child: ElevatedButton(
                          onPressed: controller.skip,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary,
                            elevation: 4,
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: isDesktop
                                  ? 18
                                  : isTablet
                                  ? 17
                                  : 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ================= DESKTOP CONTROLS =================
          if (isDesktop)
            Positioned(
              bottom: height * 0.035,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: _desktopCardWidth(width),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Indicator(
                        controller: controller,
                      ),

                      SizedBox(
                        height: height * 0.018,
                      ),

                      SizedBox(
                        width: width * 0.16,
                        height: 54,
                        child: _NextButton(
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          /// ================= MOBILE + TABLET CONTROLS =================
          if (!isDesktop)
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    0,
                    horizontalPadding,
                    height * 0.03,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Indicator(
                        controller: controller,
                      ),

                      SizedBox(
                        height: height * 0.025,
                      ),

                      SizedBox(
                        width: isTablet
                            ? width * 0.60
                            : double.infinity,
                        height: isTablet
                            ? height * 0.065
                            : height * 0.07,
                        child: _NextButton(
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  double _desktopCardWidth(double width) {
    final cardWidth = width * 0.32;

    if (cardWidth > 500) {
      return 500;
    }

    return cardWidth;
  }
}

/// =============================================================
/// PAGE INDICATOR
/// =============================================================

class _Indicator extends StatelessWidget {
  final OnboardingController controller;

  const _Indicator({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Obx(
          () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.pages.length,
              (index) {
            final selected =
                controller.currentIndex.value == index;

            return AnimatedContainer(
              duration: const Duration(
                milliseconds: 300,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? 7
                    : isTablet
                    ? 6
                    : 5,
              ),
              height: isDesktop
                  ? 9
                  : isTablet
                  ? 9
                  : 8,
              width: selected
                  ? isDesktop
                  ? 38
                  : isTablet
                  ? 36
                  : 32
                  : isDesktop
                  ? 9
                  : isTablet
                  ? 9
                  : 8,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary
                    : Colors.white.withValues(
                  alpha: 0.65,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// =============================================================
/// NEXT BUTTON
/// =============================================================

class _NextButton extends StatelessWidget {
  final OnboardingController controller;

  const _NextButton({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    return Obx(
          () => ElevatedButton(
        onPressed: controller.nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withValues(
            alpha: 0.20,
          ),
          minimumSize: Size.zero,
          shape: const StadiumBorder(),
        ),
        child: Text(
          controller.isLastPage
              ? 'Get Started'
              : 'Next',
          style: TextStyle(
            fontSize: isDesktop
                ? 18
                : isTablet
                ? 17
                : 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}