import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/responsive_builder.dart';
import '../controller/scan_controller.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ScanController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Scan Plant",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobile: _MobileLayout(controller: controller),
          tablet: _DesktopLayout(controller: controller),
          desktop: _DesktopLayout(controller: controller),
        ),
      ),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final ScanController controller;

  const _MobileLayout({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);
    final height = Responsive.height(context);

    final isLandscape =
        MediaQuery.of(context).orientation ==
            Orientation.landscape;

    // Smaller preview in landscape so the
    // complete screen fits comfortably.
    final imageHeight = isLandscape
        ? height * 0.45
        : width * 0.75;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(
        isLandscape ? 16 : 20,
      ),
      child: Column(
        children: [
          /// ================= IMAGE PREVIEW =================
          SizedBox(
            height: imageHeight,
            width: double.infinity,
            child: _ImagePreview(
              controller: controller,
              customHeight: imageHeight,
            ),
          ),

          SizedBox(
            height: isLandscape ? 16 : 24,
          ),

          /// ================= CAMERA + GALLERY =================
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.camera_alt,
                  title: "Camera",
                  color: Colors.green,
                  onTap: controller.pickFromCamera,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _ActionButton(
                  icon: Icons.photo_library,
                  title: "Gallery",
                  color: Colors.blue,
                  onTap: controller.pickFromGallery,
                ),
              ),
            ],
          ),

          SizedBox(
            height: isLandscape ? 20 : 28,
          ),

          /// ================= ANALYZE BUTTON =================
          SizedBox(
            width: double.infinity,
            height: 56,
            child: Obx(
                  () => ElevatedButton.icon(
                onPressed:
                controller.selectedImage.value == null ||
                    controller.isAnalyzing.value
                    ? null
                    : controller.analyzePlant,

                icon: controller.isAnalyzing.value
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(
                  Icons.auto_awesome,
                ),

                label: Text(
                  controller.isAnalyzing.value
                      ? "Analyzing..."
                      : "Analyze Plant",
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  final ScanController controller;

  const _DesktopLayout({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * .05,
        vertical: 30,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _ImagePreview(controller: controller),
          ),

          const SizedBox(width: 40),

          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ActionButton(
                  icon: Icons.camera_alt,
                  title: "Open Camera",
                  color: Colors.green,
                  onTap: controller.pickFromCamera,
                ),

                const SizedBox(height: 20),

                _ActionButton(
                  icon: Icons.photo_library,
                  title: "Choose Gallery",
                  color: Colors.blue,
                  onTap: controller.pickFromGallery,
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                        () => ElevatedButton.icon(
                      onPressed:
                      controller.selectedImage.value == null ||
                          controller.isAnalyzing.value
                          ? null
                          : controller.analyzePlant,
                      icon: controller.isAnalyzing.value
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(Icons.auto_awesome),
                      label: Text(
                        controller.isAnalyzing.value
                            ? "Analyzing..."
                            : "Analyze Plant",
                      ),
                    ),
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

class _ImagePreview extends StatelessWidget {
  final ScanController controller;
  final double? customHeight;

  const _ImagePreview({
    required this.controller,
    this.customHeight,
  });

  @override
  Widget build(BuildContext context) {
    final height = customHeight ??
        (Responsive.isDesktop(context)
            ? 550.0
            : Responsive.isTablet(context)
            ? 420.0
            : 300.0);

    return Obx(
          () {
        final File? image = controller.selectedImage.value;

        return Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: image == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.image_outlined,
                size: 90,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                "No Image Selected",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          )
              : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.file(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: controller.removeImage,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}