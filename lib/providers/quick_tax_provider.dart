import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/providers/document_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class QuickTaxProvider extends ChangeNotifier {
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

  Future<CommonResponseWrapper> addQuickTaxViewData() async {
    try {
      await firestore
          .collection("quick_tax")
          .doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "Tax filed successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
}

var json = {
  "en": [
    {
      "title": "Wähle dein jährliches Bruttoeinkommen aus (ca.)",
      "option_type": "single_select",
      "options": [
        "bis 9.000 Euro",
        "10.000 Euro - 14.000 Euro",
        "15.000 Euro - 34.000 Euro",
        "35.000 Euro - 54.000 Euro",
        "55.000 Euro - 69.000 Euro",
        "über 70.000 Euro"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Wähle deine Steuerklasse aus",
      "option_type": "single_select",
      "options": [
        "Steuerklasse 1",
        "Steuerklasse 2",
        "Steuerklasse 3",
        "Steuerklasse 4",
        "Steuerklasse 5",
        "Steuerklasse 6"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Gib deinen Arbeitsweg in km an (einfache Wegstrecke)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Hattest du eine/mehrere berufliche Weiterbildung/en?",
      "option_type": "single_select",
      "options": [
        "Ja",
        "Nein"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Wie viele Weiterbildungen hattest du?",
      "option_type": "single_select",
      "options": [
        "1",
        "2",
        "3",
        "4",
        "5",
        "5 oder mehr"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Bist du bereits verheiratet?aus",
      "option_type": "single_select",
      "options": [
        "Ja",
        "Nein"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Wähle dein jährliches Bruttoeinkommen aus (ca.)",
      "option_type": "single_select",
      "options": [
        "bis 9.000 Euro",
        "10.000 Euro - 14.000 Euro",
        "15.000 Euro - 34.000 Euro",
        "35.000 Euro - 54.000 Euro",
        "55.000 Euro - 69.000 Euro",
        "über 70.000 Euro"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "In welcher Steuerklasse ist dein Partner?",
      "option_type": "single_select",
      "options": [
        "Steuerklasse 3",
        "Steuerklasse 4",
        "Steuerklasse 5"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Gib den Arbeitsweg deines Partners in km an (einfache Wegstrecke)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Hatte dein Partner eine/mehrere berufliche Weiterbildung/en?",
      "option_type": "single_select",
      "options": [
        "Ja",
        "Nein"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    }
  ],
   "du": [
    {
      "title": "Wähle dein jährliches Bruttoeinkommen aus (ca.)",
      "option_type": "single_select",
      "options": [
        "bis 9.000 Euro",
        "10.000 Euro - 14.000 Euro",
        "15.000 Euro - 34.000 Euro",
        "35.000 Euro - 54.000 Euro",
        "55.000 Euro - 69.000 Euro",
        "über 70.000 Euro"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Wähle deine Steuerklasse aus",
      "option_type": "single_select",
      "options": [
        "Steuerklasse 1",
        "Steuerklasse 2",
        "Steuerklasse 3",
        "Steuerklasse 4",
        "Steuerklasse 5",
        "Steuerklasse 6"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Gib deinen Arbeitsweg in km an (einfache Wegstrecke)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Hattest du eine/mehrere berufliche Weiterbildung/en?",
      "option_type": "single_select",
      "options": [
        "Ja",
        "Nein"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Wie viele Weiterbildungen hattest du?",
      "option_type": "single_select",
      "options": [
        "1",
        "2",
        "3",
        "4",
        "5",
        "5 oder mehr"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Bist du bereits verheiratet?aus",
      "option_type": "single_select",
      "options": [
        "Ja",
        "Nein"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Wähle dein jährliches Bruttoeinkommen aus (ca.)",
      "option_type": "single_select",
      "options": [
        "bis 9.000 Euro",
        "10.000 Euro - 14.000 Euro",
        "15.000 Euro - 34.000 Euro",
        "35.000 Euro - 54.000 Euro",
        "55.000 Euro - 69.000 Euro",
        "über 70.000 Euro"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "In welcher Steuerklasse ist dein Partner?",
      "option_type": "single_select",
      "options": [
        "Steuerklasse 3",
        "Steuerklasse 4",
        "Steuerklasse 5"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    },
    {
      "title": "Gib den Arbeitsweg deines Partners in km an (einfache Wegstrecke)",
      "option_type": "input",
      "options": [],
      "input_title": "km",
      "input_type": "number",
      "show_bottom_nav": true
    },
    {
      "title": "Hatte dein Partner eine/mehrere berufliche Weiterbildung/en?",
      "option_type": "single_select",
      "options": [
        "Ja",
        "Nein"
      ],
      "input_title": "",
      "input_type": "",
      "show_bottom_nav": false
    }
  ]
};

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
