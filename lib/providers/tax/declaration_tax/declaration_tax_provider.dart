import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_view_wrapper.dart';

class DeclarationTaxProvider extends ChangeNotifier {
  final DeclarationTaxDataCollectorWrapper?
      _declarationTaxDataCollectorWrapper =
      DeclarationTaxDataCollectorWrapper();
  DeclarationTaxDataCollectorWrapper? get dataCollectorWrapper =>
      _declarationTaxDataCollectorWrapper;
  bool _busyStateDeclarationTax = true;
  bool get getBusyStateDeclarationTax => _busyStateDeclarationTax;
  set setBusyStateDeclarationTax(bool _isBusy) {
    _busyStateDeclarationTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getDeclarationTaxViewData() async {
    try {
      setBusyStateDeclarationTax = true;
      var res =
          await firestore.collection("declaration_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      DeclarationTaxViewWrapper declarationTaxWrapper =
          DeclarationTaxViewWrapper.fromJson(x);
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(status: true, data: declarationTaxWrapper);
    } catch (e) {
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: declaration_tax_view.json
  Future<CommonResponseWrapper> addDeclarationTaxViewData() async {
    try {
      await firestore.collection("declaration_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "declaration tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  setTaxYear(String year) {
    _declarationTaxDataCollectorWrapper?.taxYear = year;
  }

  setMartialStatus(String status) {
    _declarationTaxDataCollectorWrapper?.martialStatus = status;
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
            "show_bottom_nav": true
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
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fstickman.png?alt=media&token=e8ec4b68-8c56-40a9-9d3e-63bc58e76598",
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fwedding-rings.png?alt=media&token=cfc82be7-113c-46d6-bbdd-40ae8a841caa",
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fbroken.png?alt=media&token=44b2e7c8-f85b-4eef-a3f7-31367e8d544d",
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fwidowed.png?alt=media&token=3ca6e379-7055-47fa-89d6-722151ff016d"
            ],
            "show_bottom_nav": true
        },
        {
            "title": "",
            "option_type": "gross_income",
            "options": [],
            "option_img_path": [],
            "show_bottom_nav": true
        },
        {
            "title": "Check your personal information",
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
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fstickman.png?alt=media&token=e8ec4b68-8c56-40a9-9d3e-63bc58e76598",
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fwedding-rings.png?alt=media&token=cfc82be7-113c-46d6-bbdd-40ae8a841caa",
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fbroken.png?alt=media&token=44b2e7c8-f85b-4eef-a3f7-31367e8d544d",
                "https://firebasestorage.googleapis.com/v0/b/steuermachen.appspot.com/o/assets%2Fprocess%2Fwidowed.png?alt=media&token=3ca6e379-7055-47fa-89d6-722151ff016d"
            ],
            "show_bottom_nav": false
        },
        {
            "title": "",
            "option_type": "gross_income",
            "options": [],
            "option_img_path": [],
            "show_bottom_nav": true
        },
        {
            "title": "Check your personal information",
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
