import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';

class CommonProblemsCard extends StatelessWidget {
  final List<String> problems;

  const CommonProblemsCard({
    super.key,
    required this.problems,
  });

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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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

          /// Header
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFFC62828)
                      : Colors.red,
                  size: 30,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Text(
                  "Common Problems",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// No Problems
          if (problems.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(.08),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.green.withOpacity(.25),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 30,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      "Great! No common diseases or issues were detected for this plant.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )

          /// Problems
          else
            Column(
              children: List.generate(
                problems.length,
                    (index) {
                  final problem = problems[index];

                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF4A1515)
                          : Colors.red.withOpacity(.08),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF8B2E2E)
                            : Colors.red.withOpacity(.20),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.priority_high,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Problem ${index + 1}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? const Color(0xFFFF8A80)
                                      : Colors.red,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                problem,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                  fontSize: bodySize,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}