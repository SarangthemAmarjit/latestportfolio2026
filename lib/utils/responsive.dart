import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double contentPadding(BuildContext context) {
    final w = width(context);
    if (w > 1400) return (w - 1300) / 2;
    if (w > 900) return 48;
    return 24;
  }
}
