import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class ContactUsProvider extends ChangeNotifier {
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
