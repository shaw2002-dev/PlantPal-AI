import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final iconContainer = isDesktop
        ? 62.0
        : isTablet
        ? 58.0
        : 54.0;

    final iconSize = isDesktop
        ? 32.0
        : isTablet
        ? 30.0
        : 28.0;

    final titleSize = isDesktop
        ? 18.0
        : isTablet
        ? 17.0
        : 15.0;

    final valueSize = isDesktop
        ? 20.0
        : isTablet
        ? 18.0
        : 16.0;

    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            width: iconContainer,
            height: iconContainer,
            decoration: BoxDecoration(
              color: color.withOpacity(.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: color,
              size: iconSize,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            softWrap: true,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
        ],
      )
    );
  }
}