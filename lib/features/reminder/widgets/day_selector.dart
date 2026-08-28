import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/reminder_controller.dart';

class DaySelector extends StatelessWidget {
  DaySelector({super.key});

  final ReminderController controller = Get.find();

  static const List<String> days = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Wrap(
        spacing: 12,
        runSpacing: 12,
        children: List.generate(
          days.length,
              (index) {
            final selected =
            controller.isSelected(index + 1);

            return InkWell(
              borderRadius:
              BorderRadius.circular(14),
              onTap: () =>
                  controller.toggleDay(index + 1),
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 250),
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: selected
                      ? Colors.green
                      : Colors.grey.shade200,
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    days[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.black87,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}