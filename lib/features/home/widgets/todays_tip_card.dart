import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controller/home_controller.dart';

class TodaysTipCard extends StatelessWidget {
  const TodaysTipCard({super.key});

  @override
  Widget build(BuildContext context) {

    final controller =
    Get.find<HomeController>();

    return Obx(() {

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: AppColors.primary
                    .withOpacity(.1),
                borderRadius:
                BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.tips_and_updates,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Text(
                controller.todayTip.value,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.7,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}