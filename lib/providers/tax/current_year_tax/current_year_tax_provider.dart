import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/current_year_view_wrapper.dart';

class CurrentYearTaxProvider extends ChangeNotifier {
  bool _busyStateCurrentYearTax = true;
  bool get getBusyStateDeclarationTax => _busyStateCurrentYearTax;
  set setBusyStateDeclarationTax(bool _isBusy) {
    _busyStateCurrentYearTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getCurrentYearTaxViewData() async {
    try {
      setBusyStateDeclarationTax = true;
      var res =
          await firestore.collection("current_year_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      CurrentYearViewWrapper declarationTaxWrapper = CurrentYearViewWrapper.fromJson(x);
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(status: true, data: declarationTaxWrapper);
    } catch (e) {
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: current_year_tax_view.json
  Future<CommonResponseWrapper> addCurrentYearTaxViewData() async {
    try {
      await firestore.collection("current_year_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "current_year_tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }
}

var json = {
    "en": {
        "title": "Unfortunately, you cannot yet submit a tax return for 2022. But secure your receipts for the current year now and don't give away any taxes ",
        "subtitle": "Get access for only",
        "price": 39.00,
        "points": [
            "You can securely upload and collect documents throughout the year",
            "You will receive qualified tax advice from your tax expert for the current year",
            "If you order a tax return from us, we will reimburse you for all costs already paid "
        ],
        "show_bottom_nav": false
    },
    "du": {
        "title": "Unfortunately, you cannot yet submit a tax return for 2022. But secure your receipts for the current year now and don't give away any taxes ",
        "subtitle": "Get access for only",
        "price": 39.00,
        "points": [
            "You can securely upload and collect documents throughout the year",
            "You will receive qualified tax advice from your tax expert for the current year",
            "If you order a tax return from us, we will reimburse you for all costs already paid "
        ],
        "show_bottom_nav": false
    }
};
