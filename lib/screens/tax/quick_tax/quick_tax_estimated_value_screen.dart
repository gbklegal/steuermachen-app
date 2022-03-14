import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/providers/auth/auth_provider.dart';
import 'package:steuermachen/providers/tax/quick_tax/quick_tax_provider.dart';

class QuickTaxEstimatedValueScreen extends StatelessWidget {
  const QuickTaxEstimatedValueScreen({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorConstants.formFieldBackground),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextComponent(
                    LocaleKeys.goodNews,
                    textAlign: TextAlign.start,
                    style: FontStyles.fontMedium(fontSize: 16),
                  ),
                  SvgPicture.asset(
                    AssetConstants.icActiveCheck,
                    height: 50,
                  ),
                  Consumer<QuickTaxProvider>(
                      builder: (context, consumer, child) {
                    return TextComponent(
                      consumer
                          .getTotalPoints()
                          .replaceAll(".", LocaleKeys.to.tr()),
                      textAlign: TextAlign.start,
                      style: FontStyles.fontMedium(fontSize: 30),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            borderButton(context, RouteConstants.quickTaxScreen,
                LocaleKeys.calculateTaxReturnCost),
            const SizedBox(height: 20),
            borderButton(context, RouteConstants.signupScreen,
                LocaleKeys.startNowWithTheTaxReturn),
            const SizedBox(height: 50),
            Visibility(
              visible: !Provider.of<AuthProvider>(context, listen: false)
                  .checkUserInPreference(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    LocaleKeys.alreadyHaveAnAccount
                        .tr()
                        .replaceAll("Sign in here", ""),
                    textAlign: TextAlign.start,
                    style: FontStyles.fontMedium(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  _button(context, LocaleKeys.loginHere, () {
                    Navigator.pushNamed(context, RouteConstants.signInScreen);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container borderButton(
      BuildContext context, String nextRoute, String btnText) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.primary),
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: _button(context, btnText, () {
        Navigator.pushNamed(context, nextRoute);
      }, backgroundColor: ColorConstants.white),
    );
  }

  ButtonComponent _button(
      BuildContext context, String btnText, void Function()? onPressed,
      {Color? backgroundColor}) {
    return ButtonComponent(
      color: backgroundColor,
      onPressed: onPressed,
      buttonText: btnText,
      textStyle: FontStyles.fontMedium(
          fontSize: 15,
          color: backgroundColor == null
              ? ColorConstants.white
              : ColorConstants.black),
    );
  }
}
