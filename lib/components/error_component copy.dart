import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    Key? key,
    required this.onTap,
    required this.message,
  }) : super(key: key);
  final void Function() onTap;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _richText(
            message,
            " Retry",
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  RichText _richText(String title, String text, {void Function()? onTap}) {
    return RichText(
      text: TextSpan(
        text: title,
        style: FontStyles.fontRegular(
          color: ColorConstants.mediumGrey,
          fontSize: 13,
        ),
        children: <TextSpan>[
          TextSpan(
              text: text,
              style: FontStyles.fontMedium(
                  color: ColorConstants.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ],
      ),
    );
  }
}
