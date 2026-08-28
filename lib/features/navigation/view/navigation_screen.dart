import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../favorites/view/favorites_screen.dart';
import '../../history/view/history_screen.dart';
import '../../home/view/home_screen.dart';
import '../../settings/view/settings_screen.dart';
import '../controller/navigation_controller.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  final NavigationController controller =
  Get.find<NavigationController>();

  final List<Widget> pages = [
    HomeScreen(),
    HistoryScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeIndex,
          height: 72,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: "History",
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: "Favorites",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}