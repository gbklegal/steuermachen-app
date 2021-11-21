import 'package:flutter/material.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/screens/auth/auth_components/choice_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/logo_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/signin_options__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/richtext__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/title_text_auth_component.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

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
              Image.asset(AssetConstants.fileArtWork),
              const Expanded(child: SizedBox(height: 35)),
              const TitleTextAuthComponent(title: StringConstants.signUp),
              const SizedBox(height: 35),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text(StringConstants.email)),
              ),
              const SizedBox(height: 25),
              _singInButton(context, StringConstants.signUp, () {}),
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
                textSpan1: StringConstants.didntReceiveCode,
                textSpan2: StringConstants.resend,
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
}
