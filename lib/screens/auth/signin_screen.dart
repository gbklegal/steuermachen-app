import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/auth_provider.dart';
import 'package:steuermachen/screens/auth/auth_components/button_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/choice_auth_component.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showBottomLine: false,
        showNotificationIcon: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 10),
                TitleTextAuthComponent(title: LocaleKeys.signIn.tr()),
                const SizedBox(height: 35),
                _authFields(),
                const SizedBox(height: 25),
                _signInBtn(context),
                _forgotPassword(context),
                ChoiceTextAuthComponent(text: LocaleKeys.orSigninWith.tr()),
                _signInWithApple(),
                const SizedBox(height: 22),
                InkWell(
                  onTap: () async {
                    PopupLoader.showLoadingDialog(context);
                    CommonResponseWrapper res =
                        await authProvider.signInWithGoogle();
                    ToastComponent.showToast(res.message!, long: true);

                    PopupLoader.hideLoadingDialog(context);
                    if (res.status!) {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteConstants.bottomNavBarScreen, (val) => false);
                    }
                  },
                  child: SignInOptionsAuthComponent(
                      assetName: AssetConstants.icGoogle,
                      btnText: LocaleKeys.googleSignIn.tr(),
                      textColor: Colors.blueAccent),
                ),
                const SizedBox(height: 22),
                RichTextAuthComponent(
                  textSpan1: LocaleKeys.dontHaveAnAccount.tr(),
                  textSpan2: LocaleKeys.signupNow.tr(),
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstants.signupScreen);
                  },
                ),
                const SizedBox(height: 22),
                RichTextAuthComponent(
                  textSpan1: LocaleKeys.signInTermsAndCondition_1.tr() + "\n",
                  textSpan2: LocaleKeys.signInTermsAndCondition_2.tr(),
                  onTap: () {
                    // Navigator.pushNamed(context, RouteConstants.signupScreen);
                  },
                ),
                const SizedBox(height: 22),
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
          onTap: () async {
            PopupLoader.showLoadingDialog(context);
            CommonResponseWrapper res = await authProvider.signInWithApple();
            ToastComponent.showToast(res.message!, long: true);

            PopupLoader.hideLoadingDialog(context);
            if (res.status!) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstants.bottomNavBarScreen, (val) => false);
            }
          },
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
        btnText: LocaleKeys.signIn.tr(),
        onPressed: () async {
          if (_signupFormKey.currentState!.validate()) {
            PopupLoader.showLoadingDialog(context);
            CommonResponseWrapper res =
                await authProvider.signInWithEmailAndPassword(
                    _emailController.text, _passwordController.text);
            ToastComponent.showToast(res.message!, long: true);

            PopupLoader.hideLoadingDialog(context);
            if (res.status!) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstants.bottomNavBarScreen, (val) => false);
            }
          }
        });
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
            ),
            validator: validateEmail,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              label: Text(LocaleKeys.password.tr()),
            ),
            obscureText: true,
            validator: validateFieldEmpty,
          ),
        ],
      ),
    );
  }
}
