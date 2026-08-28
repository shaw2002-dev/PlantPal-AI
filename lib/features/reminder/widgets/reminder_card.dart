import 'dart:io';

import 'package:flutter/material.dart';

import '../model/reminder_model.dart';

class ReminderCard extends StatelessWidget {
  final ReminderModel reminder;
  final VoidCallback onDelete;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onDelete,
  });

  String _formatTime() {
    final hour =
    reminder.hour > 12
        ? reminder.hour - 12
        : reminder.hour == 0
        ? 12
        : reminder.hour;

    final minute =
    reminder.minute.toString().padLeft(2, "0");

    final period =
    reminder.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [

            ClipRRect(
              borderRadius:
              BorderRadius.circular(14),
              child: Image.file(
                File(reminder.imagePath),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  Text(
                    reminder.plantName,
                    style: const TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [

                      const Icon(
                        Icons.access_time,
                        color: Colors.green,
                        size: 18,
                      ),

                      const SizedBox(width: 6),

                      Text(_formatTime()),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    reminder.enabled
                        ? "Reminder Enabled"
                        : "Reminder Disabled",
                    style: TextStyle(
                      color: reminder.enabled
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}