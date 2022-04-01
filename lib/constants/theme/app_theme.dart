import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

ThemeData appTheme() {
  return ThemeData(
    primarySwatch: ColorConstants.kPrimaryColor,
    scaffoldBackgroundColor: ColorConstants.body,
    textTheme: _textTheme(),
    elevatedButtonTheme: _elevatedBtnTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  underlineInputBorder({Color? color = ColorConstants.veryLightPurple}) =>
      UnderlineInputBorder(
        borderSide: BorderSide(color: color!, width: 0.3),
      );
  return InputDecorationTheme(
      labelStyle: GoogleFonts.raleway(
        fontSize: 14.0,
        fontStyle: FontStyle.normal,
        color: ColorConstants.veryLightPurple,
      ),
      floatingLabelStyle: GoogleFonts.raleway(
        fontSize: 15.0,
        fontStyle: FontStyle.normal,
        color: ColorConstants.blue,
      ),
      enabledBorder: underlineInputBorder(color: ColorConstants.blue),
      focusedBorder: underlineInputBorder(color: ColorConstants.blue),
      border: underlineInputBorder(color: ColorConstants.blue),
      fillColor: ColorConstants.formFieldBackground);
}

ElevatedButtonThemeData _elevatedBtnTheme() {
  return ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.8,
      backgroundColor: ColorConstants.primary,
      textStyle: GoogleFonts.raleway(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal),
    ),
  );
}

TextTheme _textTheme() {
  return TextTheme(
    headline1: GoogleFonts.raleway(fontSize: 72.0, fontWeight: FontWeight.bold),
    headline6: GoogleFonts.raleway(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal),
    headline5: GoogleFonts.raleway(
        fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
    bodyText1: GoogleFonts.raleway(
        fontSize: 16.0,
        color: ColorConstants.black,
        fontStyle: FontStyle.normal),
    bodyText2: GoogleFonts.raleway(fontSize: 14.0, color: ColorConstants.black),
    button: GoogleFonts.raleway(
        fontSize: 16.0,
        color: ColorConstants.white,
        fontWeight: FontWeight.normal),
  );
}
