import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../../plant/model/plant_result_model.dart';
import '../controller/reminder_controller.dart';
import '../widgets/day_selector.dart';
import '../widgets/time_picker_card.dart';

class ReminderScreen extends StatefulWidget {
  ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final ReminderController controller =
  Get.find<ReminderController>();

  @override
  void initState() {
    super.initState();

    final plant =
    Get.arguments as PlantResultModel;

    controller.initializePlant(plant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Water Reminder"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobile: _MobileLayout(),
          tablet: _DesktopLayout(),
          desktop: _DesktopLayout(),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReminderController>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Obx(
            () => Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            if (controller.plant != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 18,
                    )
                  ],
                ),
                child: Column(
                  children: [

                    ClipOval(
                      child: Image.file(
                        File(controller.plant!.imagePath),
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                        errorBuilder: (
                            context,
                            error,
                            stackTrace,
                            ) {
                          return Container(
                            width: 84,
                            height: 84,
                            color: Colors.green.shade100,
                            child: const Icon(
                              Icons.eco,
                              size: 42,
                              color: Colors.green,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    Text(
                      controller.plant!.plantName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                        color: Colors.black
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: controller.hasExistingReminder.value
                            ? Colors.green.withOpacity(.1)
                            : Colors.orange.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        controller.hasExistingReminder.value
                            ? "🔔 Reminder Active"
                            : "No Reminder Set",
                        style: TextStyle(
                          color: controller.hasExistingReminder.value
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      controller.hasExistingReminder.value
                          ? "You already have a watering reminder for this plant."
                          : "Create a watering reminder for this plant.",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 28),

            const Text(
              "Reminder Time",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            TimePickerCard(),

            const SizedBox(height: 28),

            const Text(
              "Repeat On",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 16),

            DaySelector(),

            const SizedBox(height: 28),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                  )
                ],
              ),
              child: Row(
                children: [

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Enable Reminder",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Receive notification at the selected time.",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  Switch(
                    value: controller.enabled.value,
                    onChanged:
                    controller.toggleEnable,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: controller.saveReminder,
                icon: Icon(
                  controller.hasExistingReminder.value
                      ? Icons.update
                      : Icons.notifications_active,
                ),
                label: Text(
                  controller.hasExistingReminder.value
                      ? "Update Reminder"
                      : "Create Reminder",
                ),
              ),
            ),

            const SizedBox(height: 14),

            if (controller.hasExistingReminder.value)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: controller.deleteReminder,
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                  label: const Text(
                    "Delete Reminder",
                  ),
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReminderController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(24),
              ),
              child: Column(
                children: [

                  ClipOval(
                    child: Image.file(
                      File(controller.plant!.imagePath),
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
                        return Container(
                          width: 120,
                          height: 120,
                          color: Colors.green.shade100,
                          child: const Icon(
                            Icons.eco,
                            size: 60,
                            color: Colors.green,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    controller.plant?.plantName ??
                        "Plant",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.black
                    ),
                  ),

                  const SizedBox(height: 14),

                  Obx(
                        () => Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: controller.hasExistingReminder.value
                                ? Colors.green.withOpacity(.1)
                                : Colors.orange.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            controller.hasExistingReminder.value
                                ? "🔔 Reminder Active"
                                : "No Reminder Set",
                            style: TextStyle(
                              color: controller.hasExistingReminder.value
                                  ? Colors.green
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          controller.hasExistingReminder.value
                              ? "Update the existing watering reminder."
                              : "Schedule automatic watering reminders.",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 30),

          Expanded(
            flex: 2,
            child: Column(
              children: [

                TimePickerCard(),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Repeat On",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),

                      const SizedBox(height: 20),

                      DaySelector(),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Obx(
                      () => SwitchListTile(
                    title:
                    const Text("Enable Reminder"),
                    subtitle: const Text(
                      "Receive notifications",
                    ),
                    value: controller.enabled.value,
                    onChanged:
                    controller.toggleEnable,
                  ),
                ),

                const SizedBox(height: 30),

                Obx(
                      () => Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: controller.saveReminder,
                            child: Text(
                              controller.hasExistingReminder.value
                                  ? "Update Reminder"
                                  : "Create Reminder",
                            ),
                          ),
                        ),
                      ),

                      if (controller.hasExistingReminder.value) ...[
                        const SizedBox(width: 16),

                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: OutlinedButton(
                              onPressed: controller.deleteReminder,
                              child: const Text(
                                "Delete Reminder",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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