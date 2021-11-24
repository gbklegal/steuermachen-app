import 'package:flutter/cupertino.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

import 'font_styles_constants.dart';

class WidgetStyles {
  static SizedBox sizeBoxZero() => const SizedBox(
        height: 0,
      );
  static Text textNoData() => Text(
        'Loading',
        style: FontStyles.boldFont(color: ColorConstants.white),
      );
}
