import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const StatisticsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    final backgroundColor = isDark
        ? Colors.white
        : Theme.of(context).cardColor;

    final primaryTextColor = isDark
        ? Colors.black
        : Theme.of(context).textTheme.bodyLarge?.color;

    final secondaryTextColor = isDark
        ? Colors.grey.shade600
        : Theme.of(context)
        .textTheme
        .bodyMedium
        ?.color
        ?.withOpacity(.65);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                value,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: secondaryTextColor,
                      ),
                    ),
                  ),

                  if (onTap != null)
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: secondaryTextColor,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}