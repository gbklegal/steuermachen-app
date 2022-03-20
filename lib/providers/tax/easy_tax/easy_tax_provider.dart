import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/providers/profile/profile_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_wrapper.dart';

class EasyTaxProvider extends ChangeNotifier {
  final EasyTaxDataCollectorWrapper? _easyTaxDataCollectorWrapper =
      EasyTaxDataCollectorWrapper();

  EasyTaxDataCollectorWrapper? get easyTaxDataCollectorWrapper =>
      _easyTaxDataCollectorWrapper;

  bool _busyStateEasyTax = true;
  bool get getBusyStateEasyTax => _busyStateEasyTax;
  set setBusyStateEasyTax(bool _isBusy) {
    _busyStateEasyTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getEasyTaxViewData() async {
    try {
      setBusyStateEasyTax = true;
      var res = await firestore.collection("easy_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      EasyTaxWrapper easyTaxWrapper = EasyTaxWrapper.fromJson(x);
      setBusyStateEasyTax = false;
      return CommonResponseWrapper(status: true, data: easyTaxWrapper);
    } catch (e) {
      setBusyStateEasyTax = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: easy_tax_view.json
  Future<CommonResponseWrapper> addEasyTaxViewData() async {
    try {
      // await firestore.collection("easy_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: easy_tax_initial_view.json
  Future<CommonResponseWrapper> addEasyTaxInitialViewData() async {
    try {
      // await firestore
      //     .collection("easy_tax")
      //     .doc("initial_view_content")
      //     .set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> submitDeclarationTaxData(
      BuildContext context) async {
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    _easyTaxDataCollectorWrapper?.userInfo = _user.getUserFromControllers();
    _easyTaxDataCollectorWrapper?.userAddress = _user.getSelectedAddress;
    _easyTaxDataCollectorWrapper?.termsAndConditionChecked = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("easy_tax")
          .add({
        ..._easyTaxDataCollectorWrapper!.toJson(),
        "created_at": DateTime.now(),
        "status": ProcessConstants.pending,
        "approved_by": null,
      });
      return CommonResponseWrapper(
          status: true, message: StringConstants.thankYouForOrder);
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }
}

var json = {
  "en": [
    {
      "title": "",
      "option_type": "initial_screen",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "Check your personal information\nsalutation",
      "option_type": "user_form",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": true
    },
    {
      "title": "",
      "option_type": "payment_methods",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "confirm_billing",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "terms_and_condition",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    }
  ],
  "du": [
    {
      "title": "",
      "option_type": "initial_screen",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "Check your personal information\nsalutation",
      "option_type": "user_form",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": true
    },
    {
      "title": "",
      "option_type": "payment_methods",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "confirm_billing",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "terms_and_condition",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    }
  ]
};
