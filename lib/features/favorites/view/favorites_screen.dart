import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controller/favorites_controller.dart';
import '../widgets/favorite_card.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoritesController controller =
  Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Obx(() {

        if (controller.favorites.isEmpty) {
          return const Center(
            child: Text(
              "No Favorite Plants",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh:
          controller.refreshFavorites,
          child: ListView.builder(
            padding:
            const EdgeInsets.all(20),
            itemCount:
            controller.favorites.length,
            itemBuilder: (_, index) {

              final plant =
              controller.favorites[index];

              return FavoriteCard(
                plant: plant,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.result,
                    arguments: plant,
                  );
                },
                onDelete: () {
                  controller.removeFavorite(
                    plant,
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}