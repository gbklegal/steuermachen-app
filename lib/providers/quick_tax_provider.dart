import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/quick_tax_wrapper.dart';

class QuickTaxProvider extends ChangeNotifier {
  bool _busyStateQuickTax = true;
  bool get getBusyStateQuickState => _busyStateQuickTax;
  set setBusyStateQuickTax(bool _isBusy) {
    _busyStateQuickTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getQuickTaxViewData() async {
    try {
      setBusyStateQuickTax = true;
      var res = await firestore.collection("quick_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      QuickTaxWrapper quickTaxWrapper = QuickTaxWrapper.fromJson(x);
      setBusyStateQuickTax = false;
      return CommonResponseWrapper(status: true, data: quickTaxWrapper);
    } catch (e) {
      setBusyStateQuickTax = false;
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore 
  // JSON//filepath: quick_tax_view.json
  Future<CommonResponseWrapper> addQuickTaxViewData() async {
    try {
      // await firestore.collection("quick_tax").doc("content").set({});
      return CommonResponseWrapper(
          status: true, message: "Tax filed successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
}
