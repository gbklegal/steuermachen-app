import 'package:flutter/material.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/providers/auth_provider.dart';
import 'package:steuermachen/screens/auth/auth_components/button_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/choice_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/logo_auth_component.dart';
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

class _SignupScreenState extends State<SignupScreen> {
  late AuthProvider authProvider;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.initializeGoogleSignIn();
    super.initState();
  }

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
              _authFields(),
              const SizedBox(height: 25),
              ButtonAuthComponent(
                  btnText: StringConstants.signUp,
                  onPressed: () async {
                    if (_signupFormKey.currentState!.validate()) {
                      CommonResponseWrapper res =
                          await authProvider.registerWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                      // ToastComponent.showToast(res.message!);
                      // Navigator.pushNamed(
                      //     context, RouteConstants.verifyAccountScreen);
                    }
                  }),
              const ChoiceTextAuthComponent(text: StringConstants.orSigninWith),
              SignInOptionsAuthComponent(
                  assetName: AssetConstants.icApple,
                  btnText: StringConstants.appleSignIn),
              const SizedBox(height: 22),
              InkWell(
                onTap: () async {
                  await authProvider.signInWithGoogle();
                },
                child: SignInOptionsAuthComponent(
                    assetName: AssetConstants.icGoogle,
                    btnText: StringConstants.googleSignIn,
                    textColor: Colors.blueAccent),
              ),
              const SizedBox(height: 22),
              RichTextAuthComponent(
                textSpan1: StringConstants.alreadyRegistered + " ",
                textSpan2: StringConstants.signIn,
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RouteConstants.signInScreen);
                },
              ),
              const Expanded(child: SizedBox(height: 22)),
              RichTextAuthComponent(
                textSpan1: StringConstants.signInTermsAndCondition_1 + "\n",
                textSpan2: StringConstants.signInTermsAndCondition_2,
                onTap: () {
                  // Navigator.pushNamed(context, RouteConstants.signupScreen);
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Consumer _authFields() {
    return Consumer<AuthProvider>(builder: (context, consumer, child) {
      return Form(
        key: _signupFormKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration:
                  const InputDecoration(label: Text(StringConstants.email)),
              validator: consumer.validateEmail,
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                label: Text(StringConstants.password),
              ),
              obscureText: true,
              validator: consumer.validatePassword,
            ),
          ],
        ),
      );
    });
  }
}
