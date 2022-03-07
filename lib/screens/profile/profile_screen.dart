import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
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
  late ProfileProvider _profileProvider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        _profileProvider.getUserProfile().then((value) => response = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        "",
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Consumer<ProfileProvider>(
            builder: (context, consumer, child) {
              if (consumer.getBusyStateProfile || response == null) {
                return const LoadingComponent();
              } else if (!consumer.getBusyStateProfile && !response!.status!) {
                return const ErrorComponent();
              } else {
                return _mainBody();
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Consumer<ProfileProvider>(
        builder: (context, consumer, child) {
          if (consumer.getBusyStateProfile || response == null) {
            return const SizedBox();
          } else if (!consumer.getBusyStateProfile && !response!.status!) {
            return const SizedBox();
          } else {
            return _bottomBtn();
          }
        },
      ),
    );
  }

  Padding _mainBody() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: UserFormComponent(),
    );
  }

  Padding _bottomBtn() {
    return Padding(
      padding: AppConstants.bottomBtnPadding,
      child: ButtonComponent(
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
    );
  }
}
