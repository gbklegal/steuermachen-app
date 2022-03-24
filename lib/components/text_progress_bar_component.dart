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
        TextComponent(title,
            style: FontStyles.fontMedium(
                fontSize: 16, color: ColorConstants.black)),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          // value: progress,
          valueColor: const AlwaysStoppedAnimation<Color>(
            ColorConstants.plantGreen,
          ),
          value: progress,
          backgroundColor: ColorConstants.grey,
        ),
      ],
    );
  }
}
