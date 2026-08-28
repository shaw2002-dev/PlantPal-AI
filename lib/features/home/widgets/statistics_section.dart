import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive.dart';
import '../../reminder/model/reminder_model.dart';
import '../controller/home_controller.dart';
import 'statistics_card.dart';

class StatisticsSection extends StatelessWidget {
  final HomeController controller;

  const StatisticsSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop =
        Responsive.isDesktop(context);

        final isTablet =
        Responsive.isTablet(context);

        final cardWidth = isDesktop
            ? (constraints.maxWidth - 54) / 4
            : isTablet
            ? (constraints.maxWidth - 16) / 2
            : (constraints.maxWidth - 16) / 2;

        return Obx(
              () => Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: cardWidth,
                child: StatisticsCard(
                  icon: Icons.eco,
                  title: "Plants",
                  value: controller
                      .totalPlants.value
                      .toString(),
                  color: Colors.green,
                ),
              ),

              SizedBox(
                width: cardWidth,
                child: StatisticsCard(
                  icon: Icons.favorite,
                  title: "Favorites",
                  value: controller
                      .totalFavorites.value
                      .toString(),
                  color: Colors.red,
                ),
              ),

              SizedBox(
                width: cardWidth,
                child: StatisticsCard(
                  icon: Icons.water_drop,
                  title: "Due Today",
                  value: controller
                      .dueToday.value
                      .toString(),
                  color: Colors.blue,
                  onTap: () {
                    _showDueTodayPlants(
                      context,
                    );
                  },
                ),
              ),

              SizedBox(
                width: cardWidth,
                child: StatisticsCard(
                  icon: Icons.camera_alt,
                  title: "Scans",
                  value: controller
                      .totalScans.value
                      .toString(),
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDueTodayPlants(
      BuildContext context,
      ) {
    controller.refreshDueToday();

    final isDark = Get.isDarkMode;

    Get.bottomSheet(
      Obx(
            () => Container(
          constraints: BoxConstraints(
            maxHeight:
            MediaQuery.sizeOf(context).height * 0.72,
          ),
          padding: const EdgeInsets.fromLTRB(
            20,
            14,
            20,
            20,
          ),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black
                : const Color(0xffF6FBF6),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 45,
                height: 5,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 22),

              _buildHeader(isDark),

              const SizedBox(height: 24),

              Expanded(
                child: controller.dueTodayPlants.isEmpty
                    ? _EmptyDueToday(
                  isDark: isDark,
                )
                    : ListView.separated(
                  physics:
                  const BouncingScrollPhysics(),
                  itemCount: controller
                      .dueTodayPlants.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final reminder = controller
                        .dueTodayPlants[index];

                    return _DuePlantCard(
                      reminder: reminder,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 45,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.water_drop,
            color: Colors.blue,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Plants Due Today",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              const SizedBox(height: 4),

              Obx(
                    () => Text(
                  "${controller.dueToday.value} watering reminder${controller.dueToday.value == 1 ? "" : "s"}",
                  style: TextStyle(
                    color: isDark
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.close,
            color: isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }
}

class _DuePlantCard extends StatelessWidget {
  final ReminderModel reminder;

  const _DuePlantCard({
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    final imageFile = File(reminder.imagePath);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: imageFile.existsSync()
                ? Image.file(
              imageFile,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            )
                : Container(
              width: 65,
              height: 65,
              color: Colors.green.shade50,
              child: const Icon(
                Icons.eco,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.plantName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 18,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      _formatTime(),
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.water_drop,
                  size: 15,
                  color: Colors.blue,
                ),

                SizedBox(width: 4),

                Text(
                  "Water",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime() {
    final hour = reminder.hour == 0
        ? 12
        : reminder.hour > 12
        ? reminder.hour - 12
        : reminder.hour;

    final minute = reminder.minute
        .toString()
        .padLeft(2, '0');

    final period =
    reminder.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }
}

class _EmptyDueToday extends StatelessWidget {
  final bool isDark;

  const _EmptyDueToday({
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.eco,
            size: 72,
            color: Colors.green,
          ),

          const SizedBox(height: 18),

          Text(
            "All Plants Are Happy 🌿",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? Colors.white
                  : Colors.black,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "No plants need watering today.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDark
                  ? Colors.grey.shade400
                  : Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}