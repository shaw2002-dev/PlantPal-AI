import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';

class OnboardingPage extends StatelessWidget {
  final String image;

  const OnboardingPage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);
    final height = Responsive.height(context);

    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    if (isDesktop) {
      return _buildDesktop(
        width: width,
        height: height,
      );
    }

    if (isTablet) {
      return _buildTablet();
    }

    return _buildMobile();
  }

  /// ================= MOBILE =================
  Widget _buildMobile() {
    return SizedBox.expand(
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  /// ================= TABLET =================
  Widget _buildTablet() {
    return SizedBox.expand(
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      ),
    );
  }

  /// ================= DESKTOP =================
  Widget _buildDesktop({
    required double width,
    required double height,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        /// BACKGROUND IMAGE
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),

        /// BLUR BACKGROUND
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 25,
            sigmaY: 25,
          ),
          child: Container(
            color: Colors.black.withValues(
              alpha: 0.20,
            ),
          ),
        ),

        /// DARK OVERLAY
        Container(
          color: Colors.black.withValues(
            alpha: 0.12,
          ),
        ),

        /// MAIN IMAGE
        Center(
          child: Container(
            width: width * 0.32,
            height: height * 0.90,
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: 0.30,
                  ),
                  blurRadius: 40,
                  spreadRadius: 5,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}