import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

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
        Text(title),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          valueColor: AlwaysStoppedAnimation<Color>(
            ColorConstants.toxicGreen,
          ),
          backgroundColor: ColorConstants.mediumGrey,
        ),
      ],
    );
  }
}
