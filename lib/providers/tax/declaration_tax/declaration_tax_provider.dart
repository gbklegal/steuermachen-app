import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_wrapper.dart';

class DeclarationTaxProvider extends ChangeNotifier {
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
      EasyTaxWrapper declarationTaxWrapper = EasyTaxWrapper.fromJson(x);
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(status: true, data: declarationTaxWrapper);
    } catch (e) {
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: declaration_tax_view.json
  Future<CommonResponseWrapper> addDeclarationTaxViewData() async {
    try {
      await firestore.collection("declaration_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
}

var json = {
  "en": [
    {
      "title": "Select the appropriate tax year",
      "option_type": "single_select",
      "options": ["2018", "2019", "2020", "2021", "2022"],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "Choose your marital status",
      "option_type": "single_select",
      "options": ["Single", "Married", "Divorced", "Widowed"],
      "option_img_path": ["", "", "", ""],
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
    }
  ],
  "du": [
    {
      "title": "Select the appropriate tax year",
      "option_type": "single_select",
      "options": ["2018", "2019", "2020", "2021", "2022"],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "Choose your marital status",
      "option_type": "single_select",
      "options": ["Single", "Married", "Divorced", "Widowed"],
      "option_img_path": ["", "", "", ""],
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
    }
  ]
};
