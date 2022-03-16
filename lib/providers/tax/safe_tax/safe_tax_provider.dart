import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/safe_tax_wrapper.dart';

class SafeTaxProvider extends ChangeNotifier {
  bool _busyStateSafeTax = true;
  bool get getBusyStateSafeTax => _busyStateSafeTax;
  set setBusyStateSafeTax(bool _isBusy) {
    _busyStateSafeTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getSafeTaxViewData() async {
    try {
      setBusyStateSafeTax = true;
      var res = await firestore.collection("safe_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      SafeTaxWrapper safeTaxWrapper = SafeTaxWrapper.fromJson(x);
      setBusyStateSafeTax = false;
      return CommonResponseWrapper(status: true, data: safeTaxWrapper);
    } catch (e) {
      setBusyStateSafeTax = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: safe_tax_view.json
  Future<CommonResponseWrapper> addSafeTaxViewData() async {
    try {
      await firestore.collection("safe_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "safe tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }
}

var json = {
    "en": [
        {
            "title": "Select the appropriate tax year",
            "option_type": "single_select",
            "options": [
                "2018",
                "2019",
                "2020",
                "2021",
                "2022"
            ],
            "option_img_path": [],
            "show_bottom_nav": false
        },
        {
            "title": "Choose your marital status",
            "option_type": "single_select",
            "options": [
                "Single",
                "Married",
                "Divorced",
                "Widowed"
            ],
            "option_img_path": [
                "",
                "",
                "",
                ""
            ],
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
            "option_type": "signature",
            "options": [],
            "option_img_path": [],
            "show_bottom_nav": true
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
            "title": "Select the appropriate tax year",
            "option_type": "single_select",
            "options": [
                "2018",
                "2019",
                "2020",
                "2021",
                "2022"
            ],
            "option_img_path": [],
            "show_bottom_nav": false
        },
        {
            "title": "Choose your marital status",
            "option_type": "single_select",
            "options": [
                "Single",
                "Married",
                "Divorced",
                "Widowed"
            ],
            "option_img_path": [
                "",
                "",
                "",
                ""
            ],
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
            "option_type": "signature",
            "options": [],
            "option_img_path": [],
            "show_bottom_nav": true
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
