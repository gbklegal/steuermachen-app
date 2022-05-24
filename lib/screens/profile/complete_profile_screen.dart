import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with InputValidationUtil {
  late ProfileProvider _profileProvider;
  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _profileProvider.getUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showPersonIcon: false,
        showBottomLine: false,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _mainBody(),
        ),
      ),
      bottomNavigationBar: Consumer<ProfileProvider>(
        builder: (context, consumer, child) {
          if (consumer.getBusyStateProfile || consumer.userData == null) {
            return const LoadingComponent();
          } else if (!consumer.getBusyStateProfile &&
              consumer.userData == null) {
            return const SizedBox();
          } else {
            return _bottomBtn(consumer);
          }
        },
      ),
    );
  }

  Padding _mainBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.startWithPersonalInfo.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const UserFormComponent(),
        ],
      ),
    );
  }

  Padding _bottomBtn(ProfileProvider consumer) {
    return Padding(
      padding: AppConstants.bottomBtnPadding,
      child: ButtonComponent(
        btnHeight: 56,
        buttonText: LocaleKeys.continueText.tr(),
        onPressed: () async {
          if (consumer.genderController.text == "") {
            ToastComponent.showToast(ErrorMessagesConstants.selectGender,
                long: true);
          }
          if (consumer.userFormKey.currentState!.validate()) {
            PopupLoader.showLoadingDialog(context);
            CommonResponseWrapper res = await consumer.submitUserProfile();
            PopupLoader.hideLoadingDialog(context);
            if (res.status!) {
              _profileProvider.getUserProfile();
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstants.bottomNavBarScreen, (val) => false);
            } else {
              ToastComponent.showToast(res.message!, long: true);
            }
          }
        },
      ),
    );
  }
}
