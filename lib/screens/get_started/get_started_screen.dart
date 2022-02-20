import 'package:flutter/material.dart';
import 'package:steuermachen/components/logo_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
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
              Expanded(child: _topTitle(context)),
              Image.asset(
                AssetConstants.fileArtWork,
                height: 280,
              ),
              borderButton(context, RouteConstants.calculatorScreen,
                  LocaleKeys.calculateYourPrice),
              const SizedBox(height: 20),
              borderButton(
                  context, RouteConstants.signupScreen, LocaleKeys.getStarted),
              const SizedBox(height: 22),
              _button(context, LocaleKeys.alreadyHaveAnAccount, () {
                Navigator.pushNamed(context, RouteConstants.signInScreen);
              }),
              const Expanded(
                child: SizedBox(height: 22),
              ),
              // Expanded(
              //   child: _richTextComponent(context),
              // )
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
      }, backgroundColor: MaterialStateProperty.all(ColorConstants.white)),
    );
  }

  TextComponent _topTitle(BuildContext context) {
    return TextComponent(
      LocaleKeys.getStartedText_1,
      textAlign: TextAlign.start,
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w700, letterSpacing: 3),
    );
  }

  ElevatedButton _button(
      BuildContext context, String btnText, void Function()? onPressed,
      {MaterialStateProperty<Color?>? backgroundColor}) {
    return ElevatedButton(
      style: ElevatedButtonTheme.of(context).style?.copyWith(
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 56),
            ),
            backgroundColor: backgroundColor,
          ),
      onPressed: onPressed,
      child: TextComponent(btnText,
          style: Theme.of(context).textTheme.button!.copyWith(
              color: backgroundColor != null ? ColorConstants.black : null)),
    );
  }
}
