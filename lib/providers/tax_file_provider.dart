import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/providers/document_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class TaxFileProvider extends ChangeNotifier {
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

  Future<CommonResponseWrapper> submitTaxFileForm(
      TaxFileDataCollector formData, BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentsProvider documentsProvider =
          Provider.of<DocumentsProvider>(context, listen: false);
      CommonResponseWrapper _fileRes = await documentsProvider.uploadFiles();
      if (!_fileRes.status!) {
        return CommonResponseWrapper(
            status: true, message: "Something went wrong");
      }
      await firestore
          .collection("forms_data")
          .doc("tax_file")
          .collection("${user?.uid}")
          .add(formData.toJson());
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
