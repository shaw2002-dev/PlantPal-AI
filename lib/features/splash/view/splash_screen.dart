import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Get.put(SplashController());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: .8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  Widget bubble({
    required double size,
    required double top,
    required double left,
    required double opacity,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = Responsive.width(context);
    final height = Responsive.height(context);

    final logoSize = Responsive.isDesktop(context)
        ? 180.0
        : Responsive.isTablet(context)
        ? 150.0
        : width * .32;

    final titleSize = Responsive.isDesktop(context)
        ? 42.0
        : Responsive.isTablet(context)
        ? 36.0
        : 30.0;

    final subtitleSize = Responsive.isDesktop(context)
        ? 18.0
        : Responsive.isTablet(context)
        ? 17.0
        : 15.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2E7D32),
              Color(0xff43A047),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [

            bubble(
              size: width * .35,
              top: -40,
              left: -40,
              opacity: .08,
            ),

            bubble(
              size: width * .50,
              top: height * .12,
              left: width * .70,
              opacity: .05,
            ),

            bubble(
              size: width * .42,
              top: height * .72,
              left: -40,
              opacity: .06,
            ),

            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.maxContentWidth(context),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      Responsive.horizontalPadding(context),
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [

                            Container(
                              height: logoSize,
                              width: logoSize,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.eco_rounded,
                                color: const Color(0xff2E7D32),
                                size: logoSize * .55,
                              ),
                            ),

                            SizedBox(
                              height: height * .05,
                            ),

                            Text(
                              "PlantPal AI",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(
                              height: height * .015,
                            ),

                            Text(
                              "Your Intelligent Plant Care Companion",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: subtitleSize,
                                color: Colors.white70,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(
                              height: height * .07,
                            ),

                            SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}