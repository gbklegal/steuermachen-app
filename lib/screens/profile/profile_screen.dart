import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/textformfield_icon_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/auth/auth_provider.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with InputValidationUtil {
  CommonResponseWrapper? response;
  late final GlobalKey<FormState> changePasswordForm;
  late TextEditingController currentPassword;
  late TextEditingController newPassword;
  late TextEditingController confirmPassword;
  @override
  void initState() {
    currentPassword = TextEditingController();
    newPassword = TextEditingController();
    confirmPassword = TextEditingController();
    changePasswordForm = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void deactivate() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarComponent(
          "",
          backgroundColor: Colors.transparent,
          showBackButton: true,
          showPersonIcon: false,
          showBottomLine: false,
          appBarHeight: kToolbarHeight + (kToolbarHeight / 1.1),
          bottom: TabBar(
            unselectedLabelColor: ColorConstants.mediumGrey,
            unselectedLabelStyle: FontStyles.fontMedium(
                color: ColorConstants.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
                fontSize: 14),
            labelStyle: FontStyles.fontMedium(
                color: ColorConstants.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
                fontSize: 14),
            labelColor: ColorConstants.black,
            tabs: const [
              Tab(
                child: TextComponent(
                  LocaleKeys.personalData,
                ),
              ),
              Visibility(
                visible: true,
                child: Tab(
                  child: TextComponent(
                    LocaleKeys.changePassword,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _userForm(),
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: ChangePassword(
                  currentPassword: currentPassword,
                  newPassword: newPassword,
                  confirmPassword: confirmPassword,
                  changePasswordForm: changePasswordForm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _userForm() {
    return SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 15),
            child: UserFormComponent(
              showSaveBtn: true,
            ),
          )),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword(
      {Key? key,
      required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword,
      required this.changePasswordForm})
      : super(key: key);
  final TextEditingController currentPassword;
  final TextEditingController newPassword;
  final TextEditingController confirmPassword;
  final GlobalKey<FormState> changePasswordForm;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword>
    with InputValidationUtil {
  bool showPassword = true;
  bool showNewPassword = true;
  bool showConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.changePasswordForm,
      child: Column(
        children: [
          const SizedBox(height: 15),
          TextFormField(
            controller: widget.currentPassword,
            decoration: InputDecoration(
              label: Text(
                LocaleKeys.currentPassword.tr(),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: TextFormFieldIcons(
                  assetName: showPassword
                      ? AssetConstants.icEyeClose
                      : AssetConstants.icEyeOpen,
                  icColor: ColorConstants.black,
                  padding: 12,
                ),
              ),
            ),
            obscureText: showPassword,
            validator: validatePassword,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: widget.newPassword,
            decoration: InputDecoration(
              label: Text(LocaleKeys.newPassword.tr()),
              prefixIcon: TextFormFieldIcons(
                assetName: AssetConstants.icLock,
                icColor: ColorConstants.black,
                padding: 12,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showNewPassword = !showNewPassword;
                  });
                },
                child: TextFormFieldIcons(
                  assetName: showNewPassword
                      ? AssetConstants.icEyeClose
                      : AssetConstants.icEyeOpen,
                  icColor: ColorConstants.black,
                  padding: 12,
                ),
              ),
            ),
            obscureText: showNewPassword,
            validator: validatePassword,
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: widget.confirmPassword,
            decoration: InputDecoration(
              label: Text(LocaleKeys.confirmNewPassword.tr()),
              prefixIcon: TextFormFieldIcons(
                assetName: AssetConstants.icLock,
                icColor: ColorConstants.black,
                padding: 12,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    showConfirmPassword = !showConfirmPassword;
                  });
                },
                child: TextFormFieldIcons(
                  assetName: showConfirmPassword
                      ? AssetConstants.icEyeClose
                      : AssetConstants.icEyeOpen,
                  icColor: ColorConstants.black,
                  padding: 12,
                ),
              ),
            ),
            obscureText: showConfirmPassword,
            validator: (val) => InputValidationUtil()
                .validatePassAndConfirmPass(widget.newPassword.text, val),
          ),
          const SizedBox(height: 15),
          ButtonComponent(
            onPressed: () => _changePassword(context),
            buttonText: LocaleKeys.changePassword.tr(),
          )
        ],
      ),
    );
  }

  _changePassword(BuildContext context) async {
    if (widget.changePasswordForm.currentState!.validate()) {
      PopupLoader.showLoadingDialog(context);
      var res = await Provider.of<AuthProvider>(context, listen: false)
          .changePassword(widget.currentPassword.text, widget.newPassword.text);
      PopupLoader.hideLoadingDialog(context);
      ToastComponent.showToast(res.message!, long: true);
    }
  }
}
