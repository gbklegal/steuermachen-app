import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class TextFormFieldIcons extends StatelessWidget {
  final Color? icColor;
  final double? icSize;
  final double? padding;
  const TextFormFieldIcons({
    Key? key,
    required this.assetName,
    this.icColor,
    this.icSize,
    this.padding,
  }) : super(key: key);
  final String assetName;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: padding ?? 12.0,
          top: padding ?? 12.0,
          bottom: padding ?? 12.0,
          left: 0),
      child: SvgPicture.asset(
        assetName,
        color: icColor ?? ColorConstants.veryLightPurple,
        height: icSize ?? 10,
        width: icSize ?? 10,
      ),
    );
  }
}
