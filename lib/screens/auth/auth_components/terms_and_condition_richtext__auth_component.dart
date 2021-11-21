import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class TermsAndConditionRichTextAuthComponent extends StatelessWidget {
  const TermsAndConditionRichTextAuthComponent(
      {Key? key, required this.textSpan1, required this.textSpan2, this.onTap})
      : super(key: key);
  final String textSpan1, textSpan2;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: textSpan1,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontSize: 15, height: 1.2),
        children: <TextSpan>[
          TextSpan(
              text: textSpan2,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.primary, fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ],
      ),
    );
  }
}
