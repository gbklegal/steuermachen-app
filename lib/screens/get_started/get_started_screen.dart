import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/logo_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const LogoComponent(),
              const SizedBox(height: 35),
              _topTitle(context),
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                AssetConstants.fileArtWork,
                height: 157,
                width: 357,
              ),
              const SizedBox(
                height: 50,
              ),
              borderButton(context, RouteConstants.quickTaxScreen,
                  LocaleKeys.tryForFree),
              const SizedBox(height: 14),
              borderButton(context, RouteConstants.signupScreen,
                  LocaleKeys.startYourTaxReturn),
              const SizedBox(height: 24),
              _button(context, LocaleKeys.alreadyHaveAnAccount, () {
                Navigator.pushNamed(context, RouteConstants.signInScreen);
              }),
              const Expanded(
                child: SizedBox(height: 22),
              ),
            ],
          ),
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

  TextComponent _topTitle(BuildContext context) {
    return TextComponent(
      LocaleKeys.getStartedText_1,
      textAlign: TextAlign.start,
      style: FontStyles.fontMedium(
          fontWeight: FontWeight.w700,
          letterSpacing: 1.8,
          fontSize: 32,
          lineSpacing: 1.1),
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
          lineSpacing: 1.1,
          color: backgroundColor == null
              ? ColorConstants.white
              : ColorConstants.black),
    );
  }
}
