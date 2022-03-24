import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class PaymentTermsConditionScreen extends StatelessWidget {
  const PaymentTermsConditionScreen({
    Key? key,
  }) : super(key: key);
  // final int currentStep, totalStep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 12),
        child: Column(
          children: const [
            // TextProgressBarComponent(
            //   title: "${LocaleKeys.step.tr()} $currentStep/$totalStep ",
            //   progress: currentStep / totalStep,
            // ),
            SizedBox(
              height: 20,
            ),
            TermsAndConditionComponent(),
          ],
        ),
      ),
    );
  }
}
