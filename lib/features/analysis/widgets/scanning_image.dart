import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/responsive/responsive.dart';

class ScanningImage extends StatefulWidget {
  final File image;

  const ScanningImage({
    super.key,
    required this.image,
  });

  @override
  State<ScanningImage> createState() =>
      _ScanningImageState();
}

class _ScanningImageState
    extends State<ScanningImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final imageHeight = isDesktop
        ? 520.0
        : isTablet
        ? 430.0
        : 300.0;

    return Container(
      width: double.infinity,
      height: imageHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(.18),
            blurRadius: 30,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [

            Image.file(
              widget.image,
              fit: BoxFit.cover,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(.25),
                    Colors.transparent,
                    Colors.black.withOpacity(.15),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {

                return Positioned(
                  top: _controller.value *
                      (imageHeight - 8),
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.greenAccent,
                          Colors.white,
                          Colors.greenAccent,
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent
                              .withOpacity(.8),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                margin:
                const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius:
                  BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "AI is Scanning...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 18,
              right: 18,
              child: Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius:
                  BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.memory,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "AI Vision",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}