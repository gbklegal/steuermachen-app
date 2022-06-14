import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/email_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/constants/strings/tax_name_constants.dart';
import 'package:steuermachen/data/repositories/remote/email_repository.dart';
import 'package:steuermachen/data/repositories/remote/user_order_repository.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/data/view_models/terms_and_condition_provider.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/user_orders_data_model.dart';
import 'package:steuermachen/wrappers/finance/finance_court_view_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';
import 'package:steuermachen/wrappers/send_mail_model.dart';

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
          status: false, message: LocaleKeys.somethingWentWrong.tr());
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
          status: false, message: LocaleKeys.somethingWentWrong.tr());
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
          status: true, message: LocaleKeys.somethingWentWrong.tr());
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
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  changeSubjectLawCheckBoxState(FinanceViewData _data, int index) {
    for (var i = 0; i < financeLawWrapper.du.options.length; i++) {
      financeLawWrapper.du.options[i].isSelect = false;
      financeLawWrapper.en.options[i].isSelect = false;
    }
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
    PaymentGateWayProvider _paymentProvider =
        Provider.of<PaymentGateWayProvider>(context, listen: false);
    ProfileProvider _profile =
        Provider.of<ProfileProvider>(context, listen: false);
    var checkedValue = _termsAndContition.getCommissionCheckedValue();
    String signaturePath = await Utils.uploadToFirebaseStorage(
        await _signature.getSignaturePath());
    List<String> orderAndInvoiceNumber =
        await _paymentProvider.generateOrderNumber();
    try {
      UserOrdersDataModel _userOrder = UserOrdersDataModel();
      _userOrder.subjectLawChecks = financeLawWrapper;
      _userOrder.selectedAppealDate = selectedDate;
      _userOrder.signaturePath = signaturePath;
      _userOrder.orderNumber = orderAndInvoiceNumber[0];
      _userOrder.invoiceNumber = orderAndInvoiceNumber[1];
      _userOrder.checkedCommission = checkedValue!.title.tr();
      _userOrder.userInfo = _profile.userData;
      _userOrder.termsAndConditionChecked = true;

      DocumentReference<Map<String, dynamic>> firestoreResponse =
          await serviceLocatorInstance<UserOrderRepository>()
              .submitUserOrder(_userOrder.toJson(
        TaxNameConstants.financeCourt,
      ));
      SendMailModel? sendMailResponse = await EmailRepository().sendMail(
          _profile.userData!.email!,
          EmailInvoiceConstants.orderSubject,
          EmailInvoiceConstants.objection,
          templatePdf: EmailInvoiceConstants.objection,
          salutation: _profile.userData?.gender,
          lastName: _profile.userData?.lastName,
          orderNumber: orderAndInvoiceNumber[0],
          invoiceNumber: orderAndInvoiceNumber[1],
          orderDate: Utils.dateFormatDDMMYY(DateTime.now().toString()),
          firstName: _profile.userData?.firstName,
          street: _profile.userData?.street,
          houseNumber: _profile.userData?.houseNumber,
          postcode: _profile.userData?.plz,
          city: _profile.userData?.location,
          email: _profile.userData?.email!,
          phone: _profile.userData?.phone!,
          taxYear: DateTime.now().year.toString(),
          invoiceTemplate: EmailInvoiceConstants.objectionInvoice);
      await EmailRepository().sendMail("dialog@steuermachen.de",
          EmailInvoiceConstants.orderSubject, EmailInvoiceConstants.objection,
          templatePdf: EmailInvoiceConstants.objection,
          salutation: _profile.userData?.gender,
          lastName: _profile.userData?.lastName,
          orderNumber: orderAndInvoiceNumber[0],
          invoiceNumber: orderAndInvoiceNumber[1],
          orderDate: Utils.dateFormatDDMMYY(DateTime.now().toString()),
          firstName: _profile.userData?.firstName,
          street: _profile.userData?.street,
          houseNumber: _profile.userData?.houseNumber,
          postcode: _profile.userData?.plz,
          city: _profile.userData?.location,
          email: _profile.userData?.email!,
          phone: _profile.userData?.phone!,
          taxYear: DateTime.now().year.toString(),
          invoiceTemplate: EmailInvoiceConstants.objectionInvoice);
      if (sendMailResponse != null) {
        firestoreResponse.update({
          "invoices_path": [sendMailResponse.pdf.url]
        });
      }
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.thankYouForOrder.tr());
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
    }
  }
}
