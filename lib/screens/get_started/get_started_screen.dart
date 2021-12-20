import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
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
              const SizedBox(height: 35),
              Expanded(child: _topTitle(context)),
              Image.asset(
                AssetConstants.fileArtWork,
                height: 280,
              ),
              _button(context, LocaleKeys.calculateYourPrice.tr(), () {
                Navigator.pushNamed(context, RouteConstants.calculatorScreen);
              }),
              const SizedBox(height: 20),
              _button(context, LocaleKeys.getStarted.tr(), () {
                Navigator.pushNamed(context, RouteConstants.signupScreen);
              }),
              const SizedBox(height: 22),
              Expanded(
                child: _richText(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Align _topTitle(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        LocaleKeys.getStartedText_1.tr(),
        textAlign: TextAlign.start,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w700, letterSpacing: 3),
      ),
    );
  }

  ElevatedButton _button(
      BuildContext context, String btnText, void Function()? onPressed) {
    return ElevatedButton(
      style: ElevatedButtonTheme.of(context).style?.copyWith(
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 56),
            ),
          ),
      onPressed: onPressed,
      child: Text(
        btnText,
      ),
    );
  }

  RichText _richText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: LocaleKeys.alreadyRegistered.tr() + " ",
        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15),
        children: <TextSpan>[
          TextSpan(
              text: LocaleKeys.signIn.tr(),
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.primary, fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, RouteConstants.signInScreen);
                })
        ],
      ),
    );
  }
}
