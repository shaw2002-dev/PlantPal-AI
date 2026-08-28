import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/reminder_controller.dart';

class TimePickerCard extends StatelessWidget {
  TimePickerCard({super.key});

  final ReminderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () =>
            controller.pickTime(context),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(.05),
                blurRadius: 15,
              ),
            ],
          ),
          child: Column(
            children: [

              const Icon(
                Icons.access_time_filled,
                size: 50,
                color: Colors.green,
              ),

              const SizedBox(height: 18),

              Text(
                controller.formattedTime,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Tap to change reminder time",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}