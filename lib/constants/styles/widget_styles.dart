import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

import 'font_styles_constants.dart';

class WidgetStyles {
  static SizedBox sizeBoxZero() => const SizedBox(
        height: 0,
      );
  static Text textNoData() => Text(
        'Loading',
        style: FontStyles.fontBold(color: ColorConstants.white),
      );
  static const underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: ColorConstants.veryLightPurple, width: 0.3),
  );
  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: const BorderSide(color: ColorConstants.formFieldBackground),
  );
}
