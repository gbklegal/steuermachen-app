import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_court_view_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';

class FinanceCourtProvider extends ChangeNotifier {
  bool _busyStateFinanceCourt = true;
  bool _busyStateFinanceLaw = true;
  bool get getBusyStateFinanceCourt => _busyStateFinanceCourt;
  bool get getBusyStateFinanceLaw => _busyStateFinanceLaw;
  set setBusyStateFinanceCourt(bool _isBusy) {
    _busyStateFinanceCourt = _isBusy;
    notifyListeners();
  }
  set setBusyStateFinanceLaw(bool _isBusy) {
    _busyStateFinanceLaw = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getFinanceCourtViewData() async {
    try {
      setBusyStateFinanceCourt = true;
      var res =
          await firestore.collection("finance_court").doc("content-v1").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      FinanceCourtViewWrapper financeCourtWrapper =
          FinanceCourtViewWrapper.fromJson(x);
      setBusyStateFinanceCourt = false;
      return CommonResponseWrapper(status: true, data: financeCourtWrapper);
    } catch (e) {
      setBusyStateFinanceCourt = false;
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }

  Future<CommonResponseWrapper> getFinanceLawViewData() async {
    try {
      setBusyStateFinanceLaw = true;
      var res = await firestore
          .collection("finance_court")
          .doc("content-finance-law-v1")
          .get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      FinanceLawViewWrapper financeLawWrapper =
          FinanceLawViewWrapper.fromJson(x);
      setBusyStateFinanceLaw = false;
      return CommonResponseWrapper(status: true, data: financeLawWrapper);
    } catch (e) {
      setBusyStateFinanceLaw = false;
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: finance_court_view.json
  Future<CommonResponseWrapper> addFinanceCourtViewData() async {
    try {
      // await firestore.collection("finance_court").doc("content-v1").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: finance_court_view.json
  Future<CommonResponseWrapper> addFinanceLawViewData() async {
    try {
      await firestore
          .collection("finance_court")
          .doc("content-finance-law-v1")
          .set(json);
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
    "title": "Your application on the subject of tax law",
    "subtitle": "What is your goal?",
    "options": [
      {
        "type": "checkbox",
        "title":
            "I demand the change of the opposition decision in the lawsuit",
        "isSelect": false
      },
      {
        "type": "checkbox",
        "title":
            "I would like to submit my income tax return during the legal proceedings",
        "isSelect": false
      },
      {
        "type": "checkbox",
        "title": "I would like to have both options checked ",
        "isSelect": false
      }
    ],
    "thirdTitle": "Wann hast du die Einspruchsentscheidung erhalten? *?",
    "show_bottom_nav": true
  },
  "du": {
    "title": "Your application on the subject of tax law",
    "subtitle": "What is your goal?",
    "options": [
      {
        "type": "checkbox",
        "title":
            "I demand the change of the opposition decision in the lawsuit",
        "isSelect": false
      },
      {
        "type": "checkbox",
        "title":
            "I would like to submit my income tax return during the legal proceedings",
        "isSelect": false
      },
      {
        "type": "checkbox",
        "title": "I would like to have both options checked ",
        "isSelect": false
      }
    ],
    "thirdTitle": "Wann hast du die Einspruchsentscheidung erhalten? *?",
    "show_bottom_nav": true
  }
};
