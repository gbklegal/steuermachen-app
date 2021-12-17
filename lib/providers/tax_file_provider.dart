import 'package:flutter/material.dart';

class TaxFileProvider extends ChangeNotifier {}

class TaxFileDataCollector {
  final String martialStatus;
  final String selectYear;
  final String income;
  final String estimatedPrice;
  final UserInformation userInformation;

  TaxFileDataCollector(this.martialStatus, this.selectYear, this.income,
      this.estimatedPrice, this.userInformation);
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
