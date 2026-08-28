import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';
import '../../../app/theme/app_colors.dart';

class ScanCard extends StatelessWidget {
  final VoidCallback onTap;

  const ScanCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);
    final height = Responsive.height(context);

    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final cardHeight = isDesktop
        ? 260.0
        : isTablet
        ? 230.0
        : 250.0;

    final titleSize = isDesktop
        ? 34.0
        : isTablet
        ? 28.0
        : 22.0;

    final subtitleSize = isDesktop
        ? 18.0
        : isTablet
        ? 16.0
        : 14.0;

    final buttonWidth = isDesktop ? 190.0 : 150.0;

    return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: isDesktop
              ? 260
              : isTablet
              ? 230
              : 210,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width * .05,
          vertical: 22,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xff2E7D32),
              Color(0xff43A047),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [

            Positioned(
              right: -25,
              top: -20,
              child: Opacity(
                opacity: .08,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                final isSmall = constraints.maxWidth < 360;

                if (isSmall) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.eco,
                          size: 90,
                          color: Colors.white.withOpacity(.9),
                        ),
                      ),

                      const SizedBox(height: 20),

                      _buildContent(
                        context,
                        titleSize,
                        subtitleSize,
                        buttonWidth,
                      ),
                    ],
                  );
                }

                return Row(
                  children: [

                    Expanded(
                      flex: 6,
                      child: _buildContent(
                        context,
                        titleSize,
                        subtitleSize,
                        buttonWidth,
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Center(
                        child: Icon(
                          Icons.eco,
                          size: isDesktop ? 150 : 110,
                          color: Colors.white.withOpacity(.9),
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      );
  }

  Widget _buildContent(
      BuildContext context,
      double titleSize,
      double subtitleSize,
      double buttonWidth,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          "Scan Your Plant",
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Capture a photo and let AI identify your plant instantly.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: subtitleSize,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          width: buttonWidth,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.camera_alt),
            label: const Text("Scan Now"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}