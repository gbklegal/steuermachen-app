import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:steuermachen/screens/auth/auth_components/signin_options__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/richtext__auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/title_text_auth_component.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with InputValidationUtil {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  late AuthProvider authProvider;
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.initializeGoogleSignIn();
    authProvider.checkSignInWithAppleAvailable();
    super.initState();
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

  _emailPasswordSignIn() async {
    if (_signupFormKey.currentState!.validate()) {
      PopupLoader.showLoadingDialog(context);
      CommonResponseWrapper res = await authProvider.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text);
      ToastComponent.showToast(res.message!, long: true);

      PopupLoader.hideLoadingDialog(context);
      if (res.status!) {
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
                const SizedBox(height: 10),
                const SizedBox(height: 35),
                TitleTextAuthComponent(title: LocaleKeys.login.tr()),
                const SizedBox(height: 35),
                _authFields(),
                const SizedBox(height: 25),
                _signInBtn(context),
                const SizedBox(height: 15),
                _forgotPassword(context),
                const SizedBox(height: 20),
                RichTextAuthComponent(
                  textSpan1: LocaleKeys.dontHaveAnAccount.tr(),
                  textSpan2: LocaleKeys.signupNow.tr(),
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RouteConstants.signupScreen);
                  },
                ),
                const ChoiceTextAuthComponent(text: LocaleKeys.signinWith),
                const SizedBox(height: 25),
                _signInWithApple(),
                const SizedBox(height: 22),
                InkWell(
                  onTap: _googleSignIn,
                  child: SignInOptionsAuthComponent(
                      assetName: AssetConstants.icGoogle,
                      btnText: LocaleKeys.googleSignIn.tr(),
                      textColor: Colors.blueAccent),
                ),
                const SizedBox(height: 22),
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

  InkWell _forgotPassword(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteConstants.forgotPasswordScreen);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          LocaleKeys.forgotPassword.tr() + "?",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: ColorConstants.primary, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  ButtonAuthComponent _signInBtn(BuildContext context) {
    return ButtonAuthComponent(
        btnText: LocaleKeys.login.tr(), onPressed: _emailPasswordSignIn);
  }

  Form _authFields() {
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
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              label: Text(LocaleKeys.password.tr()),
              contentPadding: const EdgeInsets.only(left: 0),
              prefixIcon: TextFormFieldIcons(
                assetName: AssetConstants.icEmail,
                padding: 16,
                icColor: ColorConstants.white,
              ),
            ),
            obscureText: true,
            validator: validateFieldEmpty,
          ),
        ],
      ),
    );
  }
}
