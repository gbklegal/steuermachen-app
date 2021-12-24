import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class FormsProvider extends ChangeNotifier {
  Future<CommonResponseWrapper> submitContactUsForm(
      ContactUsFormDataCollector formData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("forms_data")
          .doc("contact_us")
          .collection("${user?.uid}")
          .add(formData.toJson());
      return CommonResponseWrapper(
          status: true, message: "Form submitted successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }

  Future<CommonResponseWrapper> submitInitialAviceForm(
      ContactUsFormDataCollector formData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("forms_data")
          .doc("initial_advice")
          .collection("${user?.uid}")
          .add(formData.toJson());
      return CommonResponseWrapper(
          status: true, message: "Form submitted successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }

  Future<CommonResponseWrapper> submitUserProfile(
      UserProfileDataCollector formData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_profile")
          .doc("${user?.uid}")
          .set(formData.toJson());
      return CommonResponseWrapper(
          status: true, message: "Profile updated successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }

  Future<CommonResponseWrapper> getUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot snapshot =
          await firestore.collection("user_profile").doc("${user?.uid}").get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      UserProfileDataCollector _user = UserProfileDataCollector.fromJson(data);
      return CommonResponseWrapper(status: true, message: "", data: _user);
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
}

class ContactUsFormDataCollector {
  final String? surname, firstName, email, subject, phoneNo, message;

  ContactUsFormDataCollector(this.surname, this.firstName, this.email,
      this.subject, this.phoneNo, this.message);

  Map<String, dynamic> toJson() => {
        "surname": surname,
        "firstName": firstName,
        "email": email,
        "subject": subject,
        "phoneNo": phoneNo,
        "message": message,
      };
}

class UserProfileDataCollector {
  final String? surname, firstName, street, postalCode, cityTown, country;

  UserProfileDataCollector(
      {this.surname,
      this.firstName,
      this.street,
      this.postalCode,
      this.cityTown,
      this.country});
  factory UserProfileDataCollector.fromJson(Map<String, dynamic> json) =>
      UserProfileDataCollector(
        surname: json["surname"],
        firstName: json["firstName"],
        street: json["street"],
        postalCode: json["postalCode"],
        cityTown: json["cityTown"],
        country: json["country"],
      );
  Map<String, dynamic> toJson() => {
        "surname": surname,
        "firstName": firstName,
        "street": street,
        "postalCode": postalCode,
        "cityTown": cityTown,
        "country": country,
      };
}
