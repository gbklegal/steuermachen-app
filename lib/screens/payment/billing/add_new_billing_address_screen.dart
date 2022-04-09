import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class AddNewBillingAddressScreen extends StatelessWidget {
  const AddNewBillingAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    AssetConstants.icCross,
                    color: ColorConstants.black,
                  ),
                ),
              ),
              const UserFormComponent(
                isAddNewAddress: true,
              )
            ],
          ),
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
            return Padding(
              padding: AppConstants.bottomBtnPadding,
              child: ButtonComponent(
                buttonText: LocaleKeys.useThisAddress.tr(),
                onPressed: () async {
                  if (consumer.userFormKey.currentState!.validate()) {
                    PopupLoader.showLoadingDialog(context);
                    CommonResponseWrapper res =
                        await consumer.addUserAddresss();
                    PopupLoader.hideLoadingDialog(context);
                    if (res.status!) {
                      Navigator.pop(context);
                    } else {
                      ToastComponent.showToast(res.message!, long: true);
                    }
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
