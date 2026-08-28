import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.green.shade700,
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              color: Colors.green.shade700,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: controller.searchPlant,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black
                    : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Search plants...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 15,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),

          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _textController,
            builder: (_, value, __) {
              if (value.text.isEmpty) {
                return const SizedBox(width: 8);
              }

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  _textController.clear();
                  controller.searchPlant("");
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}