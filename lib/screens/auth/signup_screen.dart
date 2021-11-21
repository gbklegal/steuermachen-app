import 'package:flutter/material.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/screens/auth/auth_components/button_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/choice_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/logo_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/signin_options__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/richtext__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/title_text_auth_component.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
              const TitleTextAuthComponent(title: StringConstants.signUp),
              const SizedBox(height: 35),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text(StringConstants.email)),
              ),
              const SizedBox(height: 25),
              ButtonAuthComponent(
                  btnText: StringConstants.signUp, onPressed: () {
                    Navigator.pushNamed(context, RouteConstants.verifyAccountScreen);
                  }),
              const ChoiceTextAuthComponent(text: StringConstants.orSigninWith),
              SignInOptionsAuthComponent(
                  assetName: AssetConstants.icApple,
                  btnText: StringConstants.appleSignIn),
              const SizedBox(height: 22),
              SignInOptionsAuthComponent(
                  assetName: AssetConstants.icGoogle,
                  btnText: StringConstants.googleSignIn,
                  textColor: Colors.blueAccent),
              const Expanded(child: SizedBox(height: 22)),
              RichTextAuthComponent(
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
}

