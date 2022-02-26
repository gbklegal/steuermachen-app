import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class ShadowCardComponent extends StatelessWidget {
  const ShadowCardComponent({
    Key? key,
    required this.leadingAsset,
    required this.title,
    this.trailingAsset,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.height = 48,
    this.fontSize = 14,
  }) : super(key: key);
  final String? leadingAsset;
  final String? trailingAsset;
  final String title;
  final double? height;
  final double? fontSize;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
                color: ColorConstants.veryLightPurple.withOpacity(0.4),
                offset: const Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 1)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  leadingAsset != null
                      ? SvgPicture.asset(
                          leadingAsset!,
                          height: 18,
                          color: ColorConstants.black,
                        )
                      : const SizedBox(),
                  const SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize,
                          letterSpacing: -0.3),
                    ),
                  ),
                ],
              ),
              trailingAsset != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SvgPicture.asset(
                        trailingAsset!,
                        height: 12,
                        color: ColorConstants.black,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
