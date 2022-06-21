import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class ContactUsProvider extends ChangeNotifier {
  Future<CommonResponseWrapper> submitContactUsForm(
      ContactUsFormDataCollector formData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      formData.userId = user?.uid;
      await firestore.collection("contact_us").add(formData.toJson());
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.formSubMessage.tr());
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }
}

class ContactUsFormDataCollector {
  String? userId, lastName, firstName, email, subject, phoneNo, message;

  ContactUsFormDataCollector(
      {this.userId,
      this.lastName,
      this.firstName,
      this.email,
      this.subject,
      this.phoneNo,
      this.message});

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "subject": subject,
        "phone": phoneNo,
        "message": message,
        "createdDate": DateTime.now(),
        "status": ProcessConstants.pending
      };
}
