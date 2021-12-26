import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/auth_provider.dart';
import 'package:steuermachen/screens/auth/auth_components/button_auth_component.dart';
import 'package:steuermachen/screens/auth/auth_components/title_text_auth_component.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with InputValidationUtil {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();
  late AuthProvider authProvider;
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.initializeGoogleSignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
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
                TitleTextAuthComponent(title: LocaleKeys.forgotPassword.tr()),
                const SizedBox(height: 35),
                _authFields(),
                const SizedBox(height: 25),
                _forgotPasswordBtn(context),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonAuthComponent _forgotPasswordBtn(BuildContext context) {
    return ButtonAuthComponent(
        btnText: LocaleKeys.submit.tr(),
        onPressed: () async {
          if (_forgotPasswordFormKey.currentState!.validate()) {
            PopupLoader.showLoadingDialog(context);
            CommonResponseWrapper res =
                await authProvider.forgotPassword(_emailController.text);
            ToastComponent.showToast(res.message!, long: true);

            PopupLoader.hideLoadingDialog(context);
            // if (res.status!) {
            //   Navigator.pushNamedAndRemoveUntil(
            //       context, RouteConstants.bottomNavBarScreen, (val) => false);
            // }
          }
        });
  }

  Form _authFields() {
    return Form(
      key: _forgotPasswordFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text(LocaleKeys.email.tr()),
            ),
            validator: validateEmail,
          ),
        ],
      ),
    );
  }
}
