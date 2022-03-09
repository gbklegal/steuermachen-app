import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/textformfield_icon_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/profile/profile_provider.dart';
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
  @override
  void initState() {
    super.initState();
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
              Tab(
                child: TextComponent(
                  LocaleKeys.changePassword,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _userForm(),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: ChangePassword(),
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
        child: Consumer<ProfileProvider>(
          builder: (context, consumer, child) {
            if (consumer.getBusyStateProfile || consumer.userData == null) {
              return const LoadingComponent();
            } else if (!consumer.getBusyStateProfile &&
                consumer.userData == null) {
              return const ErrorComponent();
            } else {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 15),
                child: Column(
                  children: [
                    const UserFormComponent(),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonComponent(
                      btnHeight: 56,
                      buttonText: LocaleKeys.save.tr(),
                      onPressed: () async {
                        // if (_userFormKey.currentState!.validate()) {
                        //   PopupLoader.showLoadingDialog(context);
                        //   CommonResponseWrapper res =
                        //       await _formsProvider.submitUserProfile(UserProfileDataCollector(
                        //     firstName: _firstNameController.text,
                        //     lastName: _lastNameController.text,
                        //     street: _streetController.text,
                        //     houseNumber: _houseNumberController.text,
                        //     plz: _plzController.text,
                        //     location: _locationController.text,
                        //     phone: _phoneController.text,
                        //     email: _emailController.text,
                        //     land: _landController.text,
                        //   ));
                        //   PopupLoader.hideLoadingDialog(context);
                        //   ToastComponent.showToast(res.message!, long: true);
                        // }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ChangePassword extends StatelessWidget with InputValidationUtil {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        TextFormField(
          // controller: _passwordController,
          decoration: InputDecoration(
            label: Text(
              LocaleKeys.currentPassword.tr(),
            ),
          ),
          obscureText: true,
          validator: validatePassword,
        ),
        const SizedBox(height: 15),
        TextFormField(
          // controller: _passwordController,
          decoration: InputDecoration(
            label: Text(LocaleKeys.newPassword.tr()),
            prefixIcon: TextFormFieldIcons(
              assetName: AssetConstants.icLock,
              icColor: ColorConstants.black,
              padding: 12,
            ),
            suffixIcon: TextFormFieldIcons(
              assetName: AssetConstants.icEyeClose,
              icColor: ColorConstants.black,
              padding: 12,
            ),
          ),
          obscureText: true,
          validator: validatePassword,
        ),
        const SizedBox(height: 15),
        TextFormField(
          // controller: _passwordController,
          decoration: InputDecoration(
            label: Text(LocaleKeys.confirmNewPassword.tr()),
            prefixIcon: TextFormFieldIcons(
              assetName: AssetConstants.icLock,
              icColor: ColorConstants.black,
              padding: 12,
            ),
            suffixIcon: TextFormFieldIcons(
              assetName: AssetConstants.icEyeClose,
              icColor: ColorConstants.black,
              padding: 12,
            ),
          ),
          obscureText: true,
          validator: validatePassword,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
