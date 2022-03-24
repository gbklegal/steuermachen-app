import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/providers/signature/signature_provider.dart';
import 'package:steuermachen/providers/terms_and_condition_provider.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_court_view_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';

class FinanceCourtProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  late FinanceLawViewWrapper financeLawWrapper;
  final DateFormat formatDate = DateFormat('dd-MM-yyyy');
  bool _busyStateFinanceCourt = true;
  bool _busyStateFinanceLaw = true;
  bool get getBusyStateFinanceCourt => _busyStateFinanceCourt;
  bool get getBusyStateFinanceLaw => _busyStateFinanceLaw;
  set setBusyStateFinanceCourt(bool _isBusy) {
    _busyStateFinanceCourt = _isBusy;
    notifyListeners();
  }

  set setBusyStateFinanceLaw(bool _isBusy) {
    _busyStateFinanceLaw = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getFinanceCourtViewData() async {
    try {
      setBusyStateFinanceCourt = true;
      var res =
          await firestore.collection("finance_court").doc("content-v1").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      FinanceCourtViewWrapper financeCourtWrapper =
          FinanceCourtViewWrapper.fromJson(x);
      setBusyStateFinanceCourt = false;
      return CommonResponseWrapper(status: true, data: financeCourtWrapper);
    } catch (e) {
      setBusyStateFinanceCourt = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<CommonResponseWrapper> getFinanceLawViewData() async {
    try {
      setBusyStateFinanceLaw = true;
      var res = await firestore
          .collection("finance_court")
          .doc("content-finance-law-v1")
          .get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      financeLawWrapper = FinanceLawViewWrapper.fromJson(x);
      setBusyStateFinanceLaw = false;
      return CommonResponseWrapper(status: true, data: financeLawWrapper);
    } catch (e) {
      setBusyStateFinanceLaw = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: finance_court_view.json
  Future<CommonResponseWrapper> addFinanceCourtViewData() async {
    try {
      // await firestore.collection("finance_court").doc("content-v1").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: finance_court_view.json
  Future<CommonResponseWrapper> addFinanceLawViewData() async {
    try {
      // await firestore
      //     .collection("finance_court")
      //     .doc("content-finance-law-v1")
      //     .set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  changeSubjectLawCheckBoxState(FinanceViewData _data, int index) {
    _data.options[index].isSelect = !_data.options[index].isSelect;
    financeLawWrapper.en = _data;
    financeLawWrapper.du = _data;
    notifyListeners();
  }

  Future<CommonResponseWrapper> submitFinanceCourtData(
      BuildContext context) async {
    SignatureProvider _signature =
        Provider.of<SignatureProvider>(context, listen: false);
    TermsAndConditionProvider _termsAndContition =
        Provider.of<TermsAndConditionProvider>(context, listen: false);
    var checkedValue = _termsAndContition.getCommissionCheckedValue();
    String signaturePath = await Utils.uploadToFirebaseStorage(
        await _signature.getSignaturePath());
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("finance_court")
          .add({
        "subject_law_checks":
            financeLawWrapper.en.options.map((e) => e.toJson()).toList(),
        "selected_appeal_date": selectedDate,
        "signature_path": signaturePath,
        "checked_commission": checkedValue!.title.tr(),
        "terms_and_condition_accepted": true,
        "created_at": DateTime.now(),
        "status": ProcessConstants.pending,
        "approved_by": null,
      });
      return CommonResponseWrapper(
          status: true, message: StringConstants.thankYouForOrder);
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }
}
