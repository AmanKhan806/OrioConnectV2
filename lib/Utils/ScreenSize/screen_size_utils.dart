import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
  double responsiveHeight(double percentage) => screenHeight * percentage;
  double responsiveWidth(double percentage) => screenWidth * percentage;
  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;
  bool get isMobile => MediaQuery.of(this).size.shortestSide < 600;
}