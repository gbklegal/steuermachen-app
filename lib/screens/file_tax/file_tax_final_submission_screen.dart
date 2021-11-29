import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class FileTaxFinalSubmissionScreen extends StatelessWidget {
  const FileTaxFinalSubmissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.curStatus,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            const TextProgressBarComponent(
              title: "${StringConstants.step} 5/5",
              progress: 1,
            ),
            const SizedBox(
              height: 48,
            ),
            TextComponent(
              StringConstants.initAdvice,
              style: FontStyles.fontBold(fontSize: 24),
            ),
            const SizedBox(
              height: 18,
            ),
            TextComponent(
              StringConstants.ifNeedInit,
              style: FontStyles.fontRegular(fontSize: 18),
            ),
            const SizedBox(
              height: 26,
            ),
            ButtonComponent(
              buttonText: StringConstants.toTaxRe,
              onPressed: () {
                Navigator.pushNamed(
                    context, RouteConstants.fileTaxFinalSubmissionScreen);
              },
            ),
            const SizedBox(
              height: 26,
            ),
            Align(
              alignment: Alignment.center,
              child: TextComponent(
                StringConstants.or,
                style: FontStyles.fontBold(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonComponent(
              buttonText: StringConstants.orderNow,
              color: ColorConstants.toxicGreen,
              onPressed: () {
                Navigator.pushNamed(
                    context, RouteConstants.fileTaxFinalSubmissionScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
