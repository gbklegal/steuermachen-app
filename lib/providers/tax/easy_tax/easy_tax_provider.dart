import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_wrapper.dart';

class EasyTaxProvider extends ChangeNotifier {
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
          status: false, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: easy_tax_view.json
  Future<CommonResponseWrapper> addEasyTaxViewData() async {
    try {
      await firestore.collection("easy_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
  //Execute this function for adding UI view in firestore
  // JSON//filepath: easy_tax_initial_view.json
  Future<CommonResponseWrapper> addEasyTaxInitialViewData() async {
    try {
      await firestore.collection("easy_tax").doc("initial_view_content").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
}

var json = {
    "en": {
        "page_title": "Your price for an initial consultation",
        "title": "Inexpensive initial consultation - order taxEASY now!",
        "price": "25.00€",
        "subtitle": "only for initial tax advice",
        "buttonText": "Order now for a fee",
        "advice_points": [
            "Individually to your tax question",
            "Modern digital from anywhere ",
            "Guaranteed security"
        ]
    },
    "du": {
        "page_title": "Dein Preis für eine Erstberatung",
        "title": "Kostengünstige Erstberatung - jetzt taxEASY bestellen!",
        "price": "25.00€",
        "subtitle": "nur für steuerliche Erstberatung",
        "buttonText": "Jetzt kostenpflichtig beauftragen",
        "advice_points": [
            "Individuell auf deine Steuerfrage",
            "Modern digital von überall ",
            "Garantierte Sicherheit"
        ]
    }
};
