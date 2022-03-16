import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/safe_tax/safe_tax_wrapper.dart';

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
      // await firestore.collection("safe_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "safe tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }
}
