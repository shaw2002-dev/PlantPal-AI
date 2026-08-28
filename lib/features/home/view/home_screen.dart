import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../controller/home_controller.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/empty_plants_widget.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/plant_tip_card.dart';
import '../widgets/recent_plant_card.dart';
import '../widgets/recent_plants_section.dart';
import '../widgets/scan_card.dart';
import '../widgets/statistics_card.dart';
import '../widgets/statistics_section.dart';
import '../widgets/todays_tip_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 8,
        heroTag: "home_scan_fab",
        onPressed: () {
          Get.toNamed(AppRoutes.scan);
        },
        icon: const Icon(Icons.eco),
        label: const Text("Scan"),
      ),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobile: _MobileHome(controller: controller),
          tablet: _TabletHome(controller: controller),
          desktop: _DesktopHome(controller: controller),
        ),
      ),
    );
  }
}

class _MobileHome extends StatelessWidget {
  final HomeController controller;

  const _MobileHome({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: _HomeContent(
        controller: controller,
      ),
    );
  }
}

class _TabletHome extends StatelessWidget {
  final HomeController controller;

  const _TabletHome({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: _HomeContent(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class _DesktopHome extends StatelessWidget {
  final HomeController controller;

  const _DesktopHome({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1300,
          ),
          child: _HomeContent(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final HomeController controller;

  const _HomeContent({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final isMobile = Responsive.isMobile(context);

    final titleSize = isDesktop
        ? 28.0
        : isTablet
        ? 24.0
        : 22.0;

    final spacing = isDesktop
        ? 30.0
        : isTablet
        ? 26.0
        : 22.0;

    final horizontalPadding = isMobile ? 0.0 : 0.0;

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [

        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const DashboardHeader(),

                SizedBox(height: spacing),

                const HomeSearchBar(),

                SizedBox(height: spacing),

                ScanCard(
                  onTap: () {
                    Get.toNamed(AppRoutes.scan);
                  },
                ),

                SizedBox(height: spacing),

                Text(
                  "Plant Tip of the Day",
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                const TodaysTipCard(),

                SizedBox(height: spacing),

                Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                StatisticsSection(
                  controller: controller,
                ),

                SizedBox(height: spacing),

                Obx(() {
                  final isSearching =
                      controller.searchText.value.trim().isNotEmpty;

                  final plants = isSearching
                      ? controller.filteredPlants
                      : controller.recentPlants;

                  if (plants.isEmpty) {
                    return const EmptyPlantsWidget();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        isSearching
                            ? "Search Results (${plants.length})"
                            : "Recent Plants",
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      RecentPlantsSection(
                        plants: plants.toList(),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}