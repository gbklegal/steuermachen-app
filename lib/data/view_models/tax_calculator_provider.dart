import 'package:flutter/material.dart';

class TaxCalculatorProvider extends ChangeNotifier {
  String selectedPrice = "<8.000 €";
  List<int> prices = [89, 99, 129, 169, 189, 229, 299, 319, 369, 429, 0];
  late int calculatedPrice = 89;
  List<String> taxPrices = [
    "<8.000 €",
    "8.001 € - 16.000 €",
    "16.001 € - 25.000 €",
    "25.001 € - 37.000 €",
    "37.001 € - 50.000 €",
    "50.001 € - 80.000 €",
    "80.001 € - 110.000 €",
    "110.001 € - 150.000 €",
    "150.001 € - 200.000 €",
    "200.001 € - 250.000 €",
    ">250.000€",
  ];

  void calculateTax(String val) {
    int priceIndex = 0;
    selectedPrice = val;
    if (val == "<8.000 €") {
      priceIndex = 0;
    } else if (val == "8.001 € - 16.000 €") {
      priceIndex = 1;
    } else if (val == "16.001 € - 25.000 €") {
      priceIndex = 2;
    } else if (val == "25.001 € - 37.000 €") {
      priceIndex = 3;
    } else if (val == "37.001 € - 50.000 €") {
      priceIndex = 4;
    } else if (val == "50.001 € - 80.000 €") {
      priceIndex = 5;
    } else if (val == "80.001 € - 110.000 €") {
      priceIndex = 6;
    } else if (val == "110.001 € - 150.000 €") {
      priceIndex = 7;
    } else if (val == "150.001 € - 200.000 €") {
      priceIndex = 8;
    } else if (val == "200.001 € - 250.000 €") {
      priceIndex = 9;
    } else if (val == ">250.000€") {
      priceIndex = 10;
    }

    calculatedPrice = prices[priceIndex];
    notifyListeners();
  }
}
