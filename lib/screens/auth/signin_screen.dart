import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

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
              _logo(context),
              const Expanded(child: SizedBox(height: 35)),
              _signin(context),
              const SizedBox(height: 35),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(StringConstants.email),
                   fillColor: ColorConstants.white
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text(StringConstants.password),
                  fillColor: ColorConstants.white
                ),
              ),
              const SizedBox(height: 25),
              _singInButton(context, StringConstants.signIn, () {}),
              const SizedBox(height: 22),
              _signInOptions(
                  context, AssetConstants.icApple, StringConstants.appleSignIn),
              const SizedBox(height: 22),
              _signInOptions(context, AssetConstants.icGoogle,
                  StringConstants.googleSignIn,
                  textColor: Colors.blueAccent),
              const Expanded(child: SizedBox(height: 22)),
              _richText(context)
            ],
          ),
        ),
      ),
    );
  }

  Container _signInOptions(
      BuildContext context, String assetName, String btnText,
      {Color? textColor}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
                color: ColorConstants.black.withOpacity(0.15),
                offset: const Offset(0, 1),
                blurRadius: 2)
          ]),
      padding: const EdgeInsets.all(21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetName,
            height: 24,
          ),
          const SizedBox(width: 22),
          Text(
            btnText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w700, fontSize: 24, color: textColor),
          ),
        ],
      ),
    );
  }

  Row _logo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetConstants.logo),
        Text(
          StringConstants.appName,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontWeight: FontWeight.w700, letterSpacing: 3, fontSize: 24),
        ),
      ],
    );
  }

  Text _signin(BuildContext context) {
    return Text(
      StringConstants.signIn,
      textAlign: TextAlign.start,
      style: Theme.of(context)
          .textTheme
          .headline6
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
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

  RichText _richText(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: StringConstants.signInTermsAndCondition_1 + "\n",
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontSize: 15, height: 1.2),
        children: <TextSpan>[
          TextSpan(
              text: StringConstants.signInTermsAndCondition_2,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.primary, fontWeight: FontWeight.w700),
              recognizer: TapGestureRecognizer()..onTap = () {})
        ],
      ),
    );
  }
}
