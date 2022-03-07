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
      if (snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        UserProfileDataCollector _user =
            UserProfileDataCollector.fromJson(data);
        return CommonResponseWrapper(status: true, message: "", data: _user);
      } else {
        return CommonResponseWrapper(
          status: true,
          message: "",
        );
      }
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }
}

class ContactUsFormDataCollector {
  final String? lastName, firstName, email, reference, phoneNo, news;

  ContactUsFormDataCollector(this.lastName, this.firstName, this.email,
      this.reference, this.phoneNo, this.news);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "reference": reference,
        "phone": phoneNo,
        "news": news,
      };
}

class UserProfileDataCollector {
  final String? firstName,
      lastName,
      street,
      houseNumber,
      plz,
      location,
      phone,
      email,
      land;

  UserProfileDataCollector({
    this.firstName,
    this.lastName,
    this.street,
    this.email,
    this.phone,
    this.land,
    this.houseNumber,
    this.plz,
    this.location,
  });
  factory UserProfileDataCollector.fromJson(Map<String, dynamic> json) =>
      UserProfileDataCollector(
        firstName: json["firstName"],
        lastName: json["lastName"],
        street: json["street"],
        houseNumber: json["houseNumber"],
        plz: json["plz"],
        location: json["location"],
        phone: json["phone"],
        email: json["email"],
        land: json["country"],
      );
  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "street": street,
        "houseNumber": houseNumber,
        "plz": plz,
        "location": location,
        "phone": phone,
        "email": email,
        "land": land,
      };
}
