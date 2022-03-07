import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class ImprintPrivacyConditionsComponent extends StatelessWidget {
  const ImprintPrivacyConditionsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    text(val) => TextComponent(
          val,
          style: FontStyles.fontMedium(fontSize: 15),
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
