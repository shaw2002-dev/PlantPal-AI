import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1024;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) return 60;
    if (isTablet(context)) return 32;
    return 20;
  }

  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 700;
    if (isTablet(context)) return 600;
    return width(context);
  }

  static bool isSmallMobile(BuildContext context) {
    return MediaQuery.of(context).size.height < 700;
  }
}