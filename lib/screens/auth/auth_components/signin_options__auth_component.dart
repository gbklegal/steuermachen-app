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
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
                color: ColorConstants.black.withOpacity(0.15),
                offset: const Offset(0, 1),
                blurRadius: 2)
          ]),
      padding: const EdgeInsets.all(21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetName,
            height: 24,
          ),
          const SizedBox(width: 22),
          Text(
            btnText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w700, fontSize: 24, color: textColor),
          ),
        ],
      ),
    );
  }
}
