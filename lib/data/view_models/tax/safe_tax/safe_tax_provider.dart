import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/safe_tax/safe_tax_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class SafeTaxProvider extends ChangeNotifier {
  final SafeAndDeclarationTaxDataCollectorWrapper?
      _safeTaxDataCollectorWrapper =
      SafeAndDeclarationTaxDataCollectorWrapper();
  SafeAndDeclarationTaxDataCollectorWrapper? get dataCollectorWrapper =>
      _safeTaxDataCollectorWrapper;
  bool _busyStateSafeTax = true;
  bool get getBusyStateSafeTax => _busyStateSafeTax;
  set setBusyStateSafeTax(bool _isBusy) {
    _busyStateSafeTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getSafeTaxViewData() async {
    try {
      setBusyStateSafeTax = true;
      var res = await firestore.collection("safe_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      SafeTaxWrapper safeTaxWrapper = SafeTaxWrapper.fromJson(x);
      setBusyStateSafeTax = false;
      return CommonResponseWrapper(status: true, data: safeTaxWrapper);
    } catch (e) {
      setBusyStateSafeTax = false;
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: safe_tax_view.json
  Future<CommonResponseWrapper> addSafeTaxViewData() async {
    try {
      // await firestore.collection("safe_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true, message: "safe tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  setTaxYear(String year) {
    _safeTaxDataCollectorWrapper?.taxYear = year;
  }

  setMartialStatus(String status) {
    _safeTaxDataCollectorWrapper?.martialStatus = status;
  }

  Future<CommonResponseWrapper> submitSafeTaxData(BuildContext context) async {
    SignatureProvider _signature =
        Provider.of<SignatureProvider>(context, listen: false);
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    String signaturePath = await Utils.uploadToFirebaseStorage(
        await _signature.getSignaturePath());
    _safeTaxDataCollectorWrapper?.signaturePath = signaturePath;
    _safeTaxDataCollectorWrapper?.userInfo = _user.getUserFromControllers();
    _safeTaxDataCollectorWrapper?.userAddress = _user.getSelectedAddress;
    _safeTaxDataCollectorWrapper?.termsAndConditionChecked = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("safe_and_declaration_tax")
          .add(_safeTaxDataCollectorWrapper!.toJson("safeTax", taxSteps));
      return CommonResponseWrapper(
          status: true, message: StringConstants.thankYouForOrder);
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  Future<CommonResponseWrapper?> checkTaxIsAlreadySubmit() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      var res = await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("safe_and_declaration_tax")
          .get();
      if (res.docs.isNotEmpty) {
        return CommonResponseWrapper(
          status: true,
          data: res.docs,
          message: LocaleKeys.alreadySubmittedTax.tr(),
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
