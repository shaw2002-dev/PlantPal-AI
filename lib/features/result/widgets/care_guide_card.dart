import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';

class CareGuideCard extends StatefulWidget {
  final String guide;

  const CareGuideCard({
    super.key,
    required this.guide,
  });

  @override
  State<CareGuideCard> createState() => _CareGuideCardState();
}

class _CareGuideCardState extends State<CareGuideCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
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
        : 15.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  "AI Care Guide",
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              widget.guide,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: bodySize,
                height: 1.8,
                color: AppColors.textSecondary,
              ),
            ),
            secondChild: Text(
              widget.guide,
              style: TextStyle(
                fontSize: bodySize,
                height: 1.8,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(
                _expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
              label: Text(
                _expanded ? "Read Less" : "Read More",
              ),
            ),
          ),
        ],
      ),
    );
  }
}