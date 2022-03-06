import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/finance_court_view_wrapper.dart';

class FinanceCourtProvider extends ChangeNotifier {
  bool _busyStateFinanceCourt = true;
  bool get getBusyStateFinanceCourt => _busyStateFinanceCourt;
  set setBusyStateFinanceCourt(bool _isBusy) {
    _busyStateFinanceCourt = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getFinanceCourtViewData() async {
    try {
      setBusyStateFinanceCourt = true;
      var res =
          await firestore.collection("finance_court").doc("content-v1").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      FinanceCourtViewWrapper financeCourtWrapper = FinanceCourtViewWrapper.fromJson(x);
      setBusyStateFinanceCourt = false;
      return CommonResponseWrapper(status: true, data: financeCourtWrapper);
    } catch (e) {
      setBusyStateFinanceCourt = false;
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: finance_court_view.json
  Future<CommonResponseWrapper> addFinanceCourtViewData() async {
    try {
      await firestore.collection("finance_court").doc("content-v1").set(json);
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
            "title": "Check your personal information",
            "option_type": "user_form",
            "options": [],
            "option_img_path": [],
            "show_bottom_nav": true
        },

        {
            "title": "",
            "option_type": "subject_tax_law",
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
            "title": "Check your personal information",
            "option_type": "user_form",
            "options": [],
            "option_img_path": [],
            "show_bottom_nav": true
        },

        {
            "title": "",
            "option_type": "subject_tax_law",
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
