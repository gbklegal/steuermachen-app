import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ColorConstants {
  static const Color primary = Color(0xffFF6138);
  static const Color body = Color(0xffffffff);
  static const Color bodyLight = Color(0xffFCFCFC);
  static const Color formFieldBackground = Color(0xffF1F6FC);
  static const Color mediumGrey = Color(0xffDEDEDE);
  static const Color greyBottomBar = Color(0x84787878);
  static const Color grey = Color.fromARGB(132, 167, 167, 167);
  static const Color black = Color(0xff000000);
  static const Color veryLightPurple = Color(0xff5A6684);
  static const Color white = Color(0xffffffff);
  static const Color green = Color(0xff14EA69);
  static const Color toxicGreen = Color(0xff66db3b);
  static const Color plantGreen = Color(0xff4CC871);
  static const Color paleGrey = Color(0xffe5e5ea);
  static const Color charcoalGrey = Color(0x993c3c43);
  static const Color blackSix = Color(0x0f000000);
  static const Color duckEggBlue = Color(0xfff1f6fc);
  static const Color blue = Color(0xff4975E9);

  static MaterialColor kPrimaryColor = const MaterialColor(
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

  static const userColors = [
    Color(0xffff6767),
    Color(0xff66e0da),
    Color(0xfff5a2d9),
    Color(0xfff0c722),
    Color(0xff6a85e5),
    Color(0xfffd9a6f),
    Color(0xff92db6e),
    Color(0xff73b8e5),
    Color(0xfffd7590),
    Color(0xffc78ae5),
  ];
  static Color getUserAvatarNameColor(types.User user) {
    final index = user.id.hashCode % userColors.length;
    return userColors[index];
  }

  static String getUserName(types.User user) =>
      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
}
