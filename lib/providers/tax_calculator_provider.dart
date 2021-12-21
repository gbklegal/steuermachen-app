import 'package:flutter/material.dart';

class TaxCalculatorProvider extends ChangeNotifier {
  List<int> prices = [89, 99, 129, 169, 189, 229, 299, 319, 369, 429, 0];
  late int calculatedPrice = 0;
  void calculateTax(String val) {
    int bje;
    if (val != "") {
      bje = int.parse(val);
    } else {
      bje = 250001;
    }
    int priceIndex = 0;
    // gross annual income
    if (bje <= 8000) {
      priceIndex = 0;
    } else if (bje >= 8001 && bje <= 16000) {
      priceIndex = 1;
    } else if (bje >= 16001 && bje <= 25000) {
      priceIndex = 2;
    } else if (bje >= 25001 && bje <= 37000) {
      priceIndex = 3;
    } else if (bje >= 37001 && bje <= 50000) {
      priceIndex = 4;
    } else if (bje >= 50001 && bje <= 80000) {
      priceIndex = 5;
    } else if (bje >= 80001 && bje <= 110000) {
      priceIndex = 6;
    } else if (bje >= 110001 && bje <= 150000) {
      priceIndex = 7;
    } else if (bje >= 150001 && bje <= 200000) {
      priceIndex = 8;
    } else if (bje >= 200001 && bje <= 250000) {
      priceIndex = 9;
    } else if (bje > 250000) {
      priceIndex = 10;
    }

    calculatedPrice = prices[priceIndex];
    notifyListeners();
  }
}
