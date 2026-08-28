import 'package:flutter/material.dart';

class PlantHealthCard extends StatelessWidget {
  final int healthScore;
  final String healthStatus;

  const PlantHealthCard({
    super.key,
    required this.healthScore,
    required this.healthStatus,
  });

  Color get _healthColor {
    if (healthScore >= 90) {
      return Colors.green;
    } else if (healthScore >= 75) {
      return Colors.lightGreen;
    } else if (healthScore >= 50) {
      return Colors.orange;
    } else if (healthScore >= 25) {
      return Colors.deepOrange;
    } else {
      return Colors.red;
    }
  }

  IconData get _healthIcon {
    if (healthScore >= 90) {
      return Icons.eco_rounded;
    } else if (healthScore >= 75) {
      return Icons.spa_rounded;
    } else if (healthScore >= 50) {
      return Icons.warning_amber_rounded;
    } else {
      return Icons.health_and_safety_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _healthColor;

    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _healthIcon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Plant Health Score",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      healthStatus,
                      style: TextStyle(
                        color: color,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "$healthScore",
                style: TextStyle(
                  color: color,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "/100",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.black87
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: healthScore.clamp(0, 100) / 100,
              minHeight: 14,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}