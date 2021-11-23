import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class FontStyles {
  //light
  static TextStyle boldFont({
    Color color = ColorConstants.black,
    double letterSpacing = 0.0,
    double fontSize = 22.0,
  }) =>
      TextStyle(
          color: color,
          fontFamily: 'helvetica',
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          fontSize: fontSize);

  //regular
  static TextStyle fontMedium(
          {Color color = ColorConstants.black,
          double letterSpacing = 0.0,
          bool bold = false,
          double fontSize = 22.0,
          double lineSpacing = 1.5,
          FontWeight fontWeight = FontWeight.w500,
          bool underLine = false}) =>
      TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'helvetica',
          fontWeight: bold ? FontWeight.bold : fontWeight,
          fontStyle: FontStyle.normal,
          height: lineSpacing, //line height 200% of actual height
          decoration:
              underLine ? TextDecoration.underline : TextDecoration.none);

//bold white title of most screens

  //regular //normal
  static TextStyle fontRegular(
          {Color color = ColorConstants.black,
          double letterSpacing = 0.0,
          // double fontSize = 12.0,
          // double fontSize = 12.0, ///UPDATED
          double fontSize = 15.0,

          ///UPDATED
          bool bold = false,
          bool underLine = false,
          double? height}) =>
      TextStyle(
          color: color,
          fontWeight: bold ? FontWeight.w500 : FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: letterSpacing,
          fontFamily: 'helvetica',
          decoration:
              underLine ? TextDecoration.underline : TextDecoration.none,
          height: height,
          fontSize: fontSize);
}
