import 'package:flutter/material.dart';

class ColorConstants {
  static Color primary = const Color(0xffFF6138);
  static Color mediumGrey = const Color(0xffDEDEDE);
  static Color black = const Color(0xff000000);
  static Color white = const Color(0xffffffff);
  static Color green = const Color(0xff14EA69);
  static MaterialColor kPrimaryColor = MaterialColor(
    0xffFF6138,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );
}
