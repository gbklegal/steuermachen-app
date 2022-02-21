import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/screens/auth/auth_components/richtext__auth_component.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent( 
        StringConstants.appName,
        // LocaleKeys.appName.tr(),
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showBottomLine: false,
        showPersonIcon: false,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Image.asset(AssetConstants.verifyAccount),
                  Text(
                    LocaleKeys.verifyYourAccount.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        fontWeight: FontWeight.w700, letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "We have sent you an code via email",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Enter your recieved code",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 35),
                  PinCodeTextField(
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
                  const SizedBox(height: 22),
                  _singInButton(context, LocaleKeys.getStarted.tr(), () {
                    Navigator.pushNamed(
                        context, RouteConstants.bottomNavBarScreen);
                  }),
                  const SizedBox(height: 35),
                  RichTextAuthComponent(
                    textSpan1: LocaleKeys.didntReceiveCode.tr(),
                    textSpan2: LocaleKeys.resend.tr(),
                    onTap: () {
                      // Navigator.pushNamed(context, RouteConstants.signupScreen);
                    },
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
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
