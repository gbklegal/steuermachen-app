import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class SignInOptionsAuthComponent extends StatelessWidget {
  const SignInOptionsAuthComponent({
    Key? key,
    required this.assetName,
    required this.btnText,
    this.textColor,
  }) : super(key: key);
  final String assetName, btnText;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
                color: ColorConstants.veryLightPurple.withOpacity(0.08),
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 3)
          ]),
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            assetName,
            height: 20,
          ),
          Center(
            child: Text(
              btnText,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w700, fontSize: 15, color: textColor),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
