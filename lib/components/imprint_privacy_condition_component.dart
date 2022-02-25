import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class ImprintPrivacyConditionsComponent extends StatelessWidget {
  const ImprintPrivacyConditionsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    text(val) => Text(
          val,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
              fontSize: 15,
              color: ColorConstants.black,
              fontWeight: FontWeight.w500),
        );
    return Flexible(
      fit: FlexFit.tight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text("Imprint | "),
            text("Privacy Policy | "),
            text("Conditions"),
          ],
        ),
      ),
    );
  }
}