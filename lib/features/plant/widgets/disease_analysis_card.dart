import 'package:flutter/material.dart';

class DiseaseAnalysisCard extends StatelessWidget {
  final bool diseaseDetected;
  final String diseaseName;
  final String diseaseDescription;
  final List<String> symptoms;
  final String diseaseCause;
  final String treatment;
  final String prevention;

  const DiseaseAnalysisCard({
    super.key,
    required this.diseaseDetected,
    required this.diseaseName,
    required this.diseaseDescription,
    required this.symptoms,
    required this.diseaseCause,
    required this.treatment,
    required this.prevention,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor =
    diseaseDetected ? Colors.orange : Colors.green;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.25),
        ),
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
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  diseaseDetected
                      ? Icons.coronavirus_rounded
                      : Icons.verified_rounded,
                  color: statusColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI Disease Analysis",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      diseaseDetected
                          ? "Possible health issue detected"
                          : "No visible disease detected",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _Section(
            icon: Icons.eco_rounded,
            title: diseaseDetected
                ? "Likely Disease / Issue"
                : "Analysis Result",
            content: diseaseName,
          ),

          if (diseaseDescription.isNotEmpty) ...[
            const SizedBox(height: 18),
            _Section(
              icon: Icons.description_outlined,
              title: "AI Observation",
              content: diseaseDescription,
            ),
          ],

          if (symptoms.isNotEmpty) ...[
            const SizedBox(height: 18),
            Text(
              "Visible Symptoms",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            const SizedBox(height: 10),
            ...symptoms.map(
                  (symptom) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: statusColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        symptom,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          if (diseaseCause.isNotEmpty) ...[
            const SizedBox(height: 18),
            _Section(
              icon: Icons.biotech_rounded,
              title: "Possible Cause",
              content: diseaseCause,
            ),
          ],

          if (treatment.isNotEmpty) ...[
            const SizedBox(height: 18),
            _Section(
              icon: Icons.medical_services_outlined,
              title: "Recommended Treatment",
              content: treatment,
            ),
          ],

          if (prevention.isNotEmpty) ...[
            const SizedBox(height: 18),
            _Section(
              icon: Icons.shield_outlined,
              title: "Prevention",
              content: prevention,
            ),
          ],

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1E3A5F) // Dark Blue
                  : const Color(0xFFE8F4FD), // Light Blue
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "AI-assisted visual analysis. Results are based "
                        "on visible symptoms and should not be treated "
                        "as a laboratory-confirmed diagnosis.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _Section({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 21,
          color: Colors.green,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
              const SizedBox(height: 6),
              Text(
                content,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  height: 1.8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}