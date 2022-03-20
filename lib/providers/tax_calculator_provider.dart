import 'package:flutter/material.dart';

class TaxCalculatorProvider extends ChangeNotifier {
  String selectedPrice = "<8000";
  List<String> taxPrices = [
    "<8000",
    "8001 - 16000",
    "16001 - 25000",
    "25001 - 37000",
    "37001 - 50000",
    "50001 - 80000",
    "80001 - 110000",
    "110001 - 150000",
    "150001 - 200000",
    "200001 - 250000",
    ">250000",
  ];
  List<int> prices = [89, 99, 129, 169, 189, 229, 299, 319, 369, 429, 0];
  late int calculatedPrice = 89;
  void calculateTax(String val) {
    int priceIndex = 0;
    if (val == "<8000") {
      priceIndex = 0;
    } else if (val == "8001 - 16000") {
      priceIndex = 1;
    } else if (val == "16001 - 25000") {
      priceIndex = 2;
    } else if (val == "25001 - 37000") {
      priceIndex = 3;
    } else if (val == "37001 - 50000") {
      priceIndex = 4;
    } else if (val == "50001 - 80000") {
      priceIndex = 5;
    } else if (val == "80001 - 110000") {
      priceIndex = 6;
    } else if (val == "110001 - 150000") {
      priceIndex = 7;
    } else if (val == "150001 - 200000") {
      priceIndex = 8;
    } else if (val == "200001 - 250000") {
      priceIndex = 9;
    } else if (val == ">250000") {
      priceIndex = 10;
    }

    calculatedPrice = prices[priceIndex];
    notifyListeners();
  }
}
