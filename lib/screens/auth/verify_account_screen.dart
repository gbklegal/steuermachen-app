import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/screens/auth/auth_components/logo_auth_component.dart';
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
              Image.asset(AssetConstants.verifyAccount),
              const TitleTextAuthComponent(
                  title: StringConstants.verifyYourAccount),
              const SizedBox(height: 35),
              const Text(
                "We have sent you an code via email",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),
              const Text(
                "Enter your recieved code",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 35),
              Flexible(
                child: PinCodeTextField(
                    appContext: context,
                    // controller: _otpTextEditingController,
                    backgroundColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                        fieldHeight: 72,
                        fieldWidth: 65.8,
                        inactiveFillColor: ColorConstants.black,
                        selectedColor: ColorConstants.black,
                        selectedFillColor: ColorConstants.primary,
                        activeFillColor: ColorConstants.black,
                        borderRadius: BorderRadius.circular(5),
                        borderWidth: 0.7,
                        activeColor: ColorConstants.black,
                        inactiveColor: ColorConstants.black,
                        shape: PinCodeFieldShape.box),
                    autoFocus: false,
                    animationCurve: Curves.easeIn,
                    cursorColor: ColorConstants.primary,
                    length: 4,
                    onChanged: (value) {}),
              ),
              const Expanded(child: SizedBox(height: 22)),
              _singInButton(context, StringConstants.getStarted, () {}),
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
