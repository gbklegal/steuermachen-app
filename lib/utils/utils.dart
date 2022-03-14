import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/providers/profile/profile_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static String getTimeAgo(DateTime dateTime) {
    var differenceDateTime = DateTime.now().difference(dateTime);
    final subtractedDateTime = DateTime.now()
        .subtract(Duration(milliseconds: differenceDateTime.inMilliseconds));
    // print(timeago.format(subtractedDateTime, locale: 'en_short'));
    return timeago
        .format(subtractedDateTime, locale: 'en_short')
        .toString()
        .replaceAll(RegExp(r'~'), "");
  }

  static String dateFormatter(String dateTime) {
    var formattedDate = DateFormat.yMMMd().format(DateTime.parse(dateTime));
    return formattedDate;
  }

  static void animateToPreviousPage(PageController pageController, int i) {
    pageController.animateToPage(i - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutBack);
  }

  static void animateToNextPage(PageController pageController, int i) {
    pageController.animateToPage(i + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInToLinear);
  }

  static void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
      currentFocus.dispose();
    }
  }

  static Future<bool> submitProfile(BuildContext context) async {
    ProfileProvider _provider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (_provider.genderController.text == "") {
      ToastComponent.showToast(ErrorMessagesConstants.selectGender, long: true);
    }
    if (_provider.userFormKey.currentState!.validate()) {
      PopupLoader.showLoadingDialog(context);
      CommonResponseWrapper res = await _provider.submitUserProfile();
      PopupLoader.hideLoadingDialog(context);
      ToastComponent.showToast(res.message!, long: true);
      return res.status!;
    }
    return false;
  }
}
