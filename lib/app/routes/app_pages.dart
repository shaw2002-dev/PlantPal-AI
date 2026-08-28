import 'package:get/get.dart';
import 'package:plantpal_ai/app/bindings/analysis_binding.dart';
import 'package:plantpal_ai/app/bindings/navigation_binding.dart';
import 'package:plantpal_ai/app/bindings/reminder_binding.dart';
import 'package:plantpal_ai/app/bindings/result_binding.dart';
import 'package:plantpal_ai/app/bindings/scan_binding.dart';

import '../../features/analysis/view/analysis_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/navigation/view/navigation_screen.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/reminder/view/reminder_screen.dart';
import '../../features/result/view/result_screen.dart';
import '../../features/scan/view/scan_screen.dart';
import '../../features/splash/view/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: NavigationBinding()
    ),

    GetPage(
      name: AppRoutes.scan,
      page: () => const ScanScreen(),
      binding: ScanBinding()
    ),

    GetPage(
      name: AppRoutes.result,
      page: () => const ResultScreen(),
      binding: ResultBinding()
    ),

    GetPage(
      name: AppRoutes.navigation,
      page: () => NavigationScreen(),
      binding: NavigationBinding()
    ),

    GetPage(
      name: AppRoutes.analysis,
      page: () => const AnalysisScreen(),
      binding: AnalysisBinding()
    ),

    GetPage(
      name: AppRoutes.reminder,
      page: () => ReminderScreen(),
      binding: ReminderBinding()
    ),
  ];
}