import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class TextProgressBarComponent extends StatelessWidget {
  final String title;
  final double progress;
  const TextProgressBarComponent(
      {Key? key, required this.title, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextComponent(title, style: FontStyles.fontRegular(fontSize: 16)),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          // value: progress,
          valueColor: const AlwaysStoppedAnimation<Color>(
            ColorConstants.toxicGreen,
          ),
          value: progress,
          backgroundColor: ColorConstants.mediumGrey,
        ),
      ],
    );
  }
}
