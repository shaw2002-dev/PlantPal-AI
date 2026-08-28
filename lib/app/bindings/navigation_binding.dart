import 'package:get/get.dart';

import '../../features/favorites/controller/favorites_controller.dart';
import '../../features/history/controller/history_controller.dart';
import '../../features/navigation/controller/navigation_controller.dart';
import '../../features/home/controller/home_controller.dart';
import '../../features/settings/controller/settings_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());

    Get.lazyPut(() => HomeController());

    Get.lazyPut(() => HistoryController());

    Get.lazyPut(() => FavoritesController());

    Get.lazyPut(() => SettingsController());
  }
}