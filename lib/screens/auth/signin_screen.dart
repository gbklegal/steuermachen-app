import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/screens/auth/auth_components/choice_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/logo_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/signin_options__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/terms_and_condition_richtext__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/title_text_auth_component.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const LogoAuthComponent(),
              const Expanded(child: SizedBox(height: 35)),
              const TitleTextAuthComponent(title: StringConstants.signIn),
              const SizedBox(height: 35),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(StringConstants.email),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(StringConstants.password),
                ),
              ),
              const SizedBox(height: 25),
              _singInButton(context, StringConstants.signIn, () {}),
              const ChoiceTextAuthComponent(text: StringConstants.orSigninWith),
              SignInOptionsAuthComponent(
                  assetName: AssetConstants.icApple,
                  btnText: StringConstants.appleSignIn),
              const SizedBox(height: 22),
              SignInOptionsAuthComponent(
                  assetName: AssetConstants.icGoogle,
                  btnText: StringConstants.googleSignIn,
                  textColor: Colors.blueAccent),
              const SizedBox(height: 22),
              TermsAndConditionRichTextAuthComponent(
                textSpan1: StringConstants.dontHaveAnAccount,
                textSpan2: StringConstants.signupNow,
                onTap: () {
                  Navigator.pushNamed(context, RouteConstants.signupScreen);
                },
              ),
              const Expanded(child: SizedBox(height: 22)),
              TermsAndConditionRichTextAuthComponent(
                textSpan1: StringConstants.signInTermsAndCondition_1 + "\n",
                textSpan2: StringConstants.signInTermsAndCondition_2,
                onTap: () {
                  // Navigator.pushNamed(context, RouteConstants.signupScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _singInButton(
      BuildContext context, String btnText, void Function()? onPressed) {
    return ElevatedButton(
      style: ElevatedButtonTheme.of(context).style?.copyWith(
            minimumSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context).size.width, 70),
            ),
          ),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }

  RichText _richText(BuildContext context, String textSpan1, String textSpan2,
      void Function()? onTap) {
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
