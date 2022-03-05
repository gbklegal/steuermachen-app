import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/textformfield_icon_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/auth/auth_provider.dart';
import 'package:steuermachen/screens/auth/auth_components/button_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/choice_auth_component.dart';
import 'package:steuermachen/components/imprint_privacy_condition_component.dart';
import 'package:steuermachen/screens/auth/auth_components/richtext__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/signin_options__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/title_text_auth_component.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with InputValidationUtil {
  late AuthProvider authProvider;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.initializeGoogleSignIn();
    authProvider.checkSignInWithAppleAvailable();
    super.initState();
  }

  _signupWithEmailAndPass() async {
    if (_signupFormKey.currentState!.validate()) {
      PopupLoader.showLoadingDialog(context);
      CommonResponseWrapper res =
          await authProvider.registerWithEmailAndPassword(
              _emailController.text, _passwordController.text);
      ToastComponent.showToast(res.message!, long: true);
      PopupLoader.hideLoadingDialog(context);
      Navigator.pushNamed(context, RouteConstants.completeProfileScreen);
    }
  }

  _googleSignIn() async {
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res = await authProvider.signInWithGoogle();
    ToastComponent.showToast(res.message!, long: true);
    PopupLoader.hideLoadingDialog(context);
    if (res.status!) {
      if (authProvider.isFirstTimeLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.completeProfileScreen, (val) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.bottomNavBarScreen, (val) => false);
      }
    }
  }

  _appleSignIn() async {
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res = await authProvider.signInWithApple();
    ToastComponent.showToast(res.message!, long: true);

    PopupLoader.hideLoadingDialog(context);
    if (res.status!) {
      if (authProvider.isFirstTimeLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.completeProfileScreen, (val) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.bottomNavBarScreen, (val) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showBottomLine: false,
        showPersonIcon: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 35),
                TitleTextAuthComponent(title: LocaleKeys.toRegister.tr()),
                const SizedBox(height: 35),
                _authFields(),
                const SizedBox(height: 25),
                ButtonAuthComponent(
                    btnText: LocaleKeys.toRegister.tr(),
                    onPressed: _signupWithEmailAndPass),
                const SizedBox(height: 22),
                RichTextAuthComponent(
                  textSpan1: LocaleKeys.alreadyRegistered.tr() + " ",
                  textSpan2: LocaleKeys.signIn.tr(),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RouteConstants.signInScreen);
                  },
                ),
                const ChoiceTextAuthComponent(text: LocaleKeys.signinWith),
                _signInWithApple(),
                const SizedBox(height: 22),
                InkWell(
                  onTap: _googleSignIn,
                  child: SignInOptionsAuthComponent(
                      assetName: AssetConstants.icGoogle,
                      btnText: LocaleKeys.googleSignIn.tr(),
                      textColor: Colors.blueAccent),
                ),
                const SizedBox(height: 50),
                const ImprintPrivacyConditionsComponent(),
                const Flexible(child: SizedBox(height: 180)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInWithApple() {
    return Consumer<AuthProvider>(builder: (context, consumer, child) {
      if (consumer.signInWithAppleIsAvailable) {
        return InkWell(
          onTap: _appleSignIn,
          child: SignInOptionsAuthComponent(
              assetName: AssetConstants.icApple,
              btnText: LocaleKeys.appleSignIn.tr()),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Consumer _authFields() {
    return Consumer<AuthProvider>(builder: (context, consumer, child) {
      return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text(LocaleKeys.email.tr()),
                prefixIcon: TextFormFieldIcons(
                  assetName: AssetConstants.icEmail,
                  padding: 16,
                ),
              ),
              validator: validateEmail,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                label: Text(LocaleKeys.password.tr()),
                prefixIcon: TextFormFieldIcons(
                  assetName: AssetConstants.icEmail,
                  icColor: ColorConstants.white,
                  padding: 16,
                ),
              ),
              obscureText: true,
              validator: validatePassword,
            ),
          ],
        ),
      );
    });
  }
}
