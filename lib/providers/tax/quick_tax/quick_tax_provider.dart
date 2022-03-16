import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/quick_tax_wrapper.dart';

class QuickTaxProvider extends ChangeNotifier {
  Map<int, int> _sumPoints = {};
  Map<int, TextEditingController>? _inputFieldsController = {};
  Map<int, TextEditingController>? get controllers => _inputFieldsController;
  bool _busyStateQuickTax = true;
  bool get getBusyStateQuickTax => _busyStateQuickTax;
  set setBusyStateQuickTax(bool _isBusy) {
    _busyStateQuickTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getQuickTaxViewData() async {
    try {
      _inputFieldsController = {};
      setBusyStateQuickTax = true;
      var res = await firestore.collection("quick_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      QuickTaxWrapper quickTaxWrapper = QuickTaxWrapper.fromJson(x);
      for (var i = 0; i < quickTaxWrapper.en.length; i++) {
        if (quickTaxWrapper.en[i].optionType == OptionConstants.input) {
          _inputFieldsController![i] = TextEditingController();
        }
      }
      setBusyStateQuickTax = false;
      return CommonResponseWrapper(status: true, data: quickTaxWrapper);
    } catch (e) {
      setBusyStateQuickTax = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: quick_tax_view.json
  Future<CommonResponseWrapper> addQuickTaxViewData() async {
    try {
      // await firestore.collection("quick_tax").doc("content").set({});
      return CommonResponseWrapper(
          status: true, message: "Quick tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  addPoint(int key, int points) {
    _sumPoints[key] = points;
  }

  String getTotalPoints() {
    int _points = 0;
    _sumPoints.forEach((key, value) {
      _points += value;
    });
    if (_points >= 0 && _points <= 4) {
      return "EUR 150 . EUR 450";
    } else if (_points >= 5 && _points <= 8) {
      return "EUR 451 . EUR 1026";
    } else if (_points >= 8 && _points <= 11) {
      return "EUR 1027 . EUR 1842";
    } else {
      // if (_points >= 8 && _points <= 11)
      return "up to EUR 1843 and more";
    }
  }
}
