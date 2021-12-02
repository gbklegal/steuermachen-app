// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> de = {
  "appName": "steuermachen",
  "onboardingOne": "Durchschnittliche Steuerrückerstattung für Steuerzahler",
  "onboardingOneText": "€ 1047",
  "onboardingTwo": "Nerven gespart und mehr Freizeit",
  "onboardingTwoText": "100 %",
  "onboardingThree": "Jeder 5. Steuerbescheid ist falsch",
  "onboardingThreeText": "5",
  "onboardingFour": "Jeder dritte Steuerzahler denkt, es lohnt sich nicht",
  "onboardingFourText": "3"
};
static const Map<String,dynamic> en = {
  "appName": "make tax",
  "onboardingOne": "Average tax refund for taxpayers",
  "onboardingOneText": "€ 1047",
  "onboardingTwo": "Saved nerves and more free time",
  "onboardingTwoText": "100 %",
  "onboardingThree": "Every 5th tax assessment is incorrect",
  "onboardingThreeText": "5",
  "onboardingFour": "Every third taxpayer thinks it's not worth it",
  "onboardingFourText": "3"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"de": de, "en": en};
}
