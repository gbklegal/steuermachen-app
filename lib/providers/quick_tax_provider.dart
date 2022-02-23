import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
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

  final TaxFileDataCollector _taxFileDataCollector = TaxFileDataCollector(
      martialStatus: StringConstants.student, selectYear: "2017");

  TaxFileDataCollector get taxFile => _taxFileDataCollector;
  setMartialStatus(String val) {
    _taxFileDataCollector.martialStatus = val;
    notifyListeners();
  }

  setYear(String val) {
    _taxFileDataCollector.selectYear = val;
    notifyListeners();
  }

  setIncome(String income, String estPrice, String? promoCode) {
    _taxFileDataCollector.income = income;
    _taxFileDataCollector.estimatedPrice = estPrice;
    _taxFileDataCollector.promoCode = promoCode;
    notifyListeners();
  }

  setUserInformation(UserInformation user) {
    _taxFileDataCollector.userInformation = user;
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

class TaxFileDataCollector {
  String? martialStatus;
  String? selectYear;
  String? income;
  String? estimatedPrice;
  String? promoCode;
  UserInformation? userInformation;

  TaxFileDataCollector(
      {this.martialStatus,
      this.selectYear,
      this.income,
      this.estimatedPrice,
      this.userInformation,
      this.promoCode});

  Map<String, dynamic> toJson() => {
        "martial_status": martialStatus,
        "select_year": selectYear,
        "promo_code": promoCode,
        "income": income,
        "estimated_price": estimatedPrice,
        "userInformation": userInformation!.toJson()
      };
}

class UserInformation {
  final String? surname,
      firstName,
      email,
      road,
      houseNo,
      postalCode,
      place,
      phoneNo;

  UserInformation(this.surname, this.firstName, this.email, this.road,
      this.houseNo, this.postalCode, this.place, this.phoneNo);
  Map<String, dynamic> toJson() => {
        "surname": surname,
        "first_name": firstName,
        "email": email,
        "road": road,
        "house_no": houseNo,
        "postal_code": postalCode,
        "place": place,
        "phone_no": phoneNo,
      };
}
