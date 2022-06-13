import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/email_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/strings/tax_name_constants.dart';
import 'package:steuermachen/data/repositories/remote/email_repository.dart';
import 'package:steuermachen/data/repositories/remote/user_order_repository.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/user_orders_data_model.dart';
import 'package:steuermachen/wrappers/safe_tax/safe_tax_wrapper.dart';
import 'package:steuermachen/wrappers/send_mail_model.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class SafeTaxProvider extends ChangeNotifier {
  final UserOrdersDataModel? _userOrder = UserOrdersDataModel();
  UserOrdersDataModel? get dataCollectorWrapper => _userOrder;
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
    _userOrder?.taxYear = year;
  }

  setMartialStatus(String status) {
    _userOrder?.martialStatus = status;
  }

  Future<CommonResponseWrapper> submitSafeTaxData(BuildContext context) async {
    // SignatureProvider _signature =
    //     Provider.of<SignatureProvider>(context, listen: false);
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    PaymentGateWayProvider _paymentProvider =
        Provider.of<PaymentGateWayProvider>(context, listen: false);
    // String signaturePath = await Utils.uploadToFirebaseStorage(
    //     await _signature.getSignaturePath());
    List<String> orderAndInvoiceNumber =
        await _paymentProvider.generateOrderNumber();
    // _userOrder?.signaturePath = signaturePath;
    _userOrder?.userInfo = _user.getUserFromControllers();
    _userOrder?.userAddress = _user.getSelectedAddress;
    _userOrder?.termsAndConditionChecked = true;
    _userOrder?.invoiceNumber = orderAndInvoiceNumber[1];
    _userOrder?.orderNumber = orderAndInvoiceNumber[0];
    try {
      DocumentReference<Map<String, dynamic>> firestoreResponse =
          await serviceLocatorInstance<UserOrderRepository>().submitUserOrder(
              _userOrder!.toJson(TaxNameConstants.safeTax, steps: taxSteps));

      SendMailModel? sendMailResponse = await EmailRepository().sendMail(
          _userOrder!.userInfo!.email!,
          EmailInvoiceConstants.orderSubject,
          EmailInvoiceConstants.safeTax,
          sendInvoice: false,
          templatePdf: EmailInvoiceConstants.safeTax,
          salutation: _userOrder!.userInfo!.gender,
          lastName: _userOrder!.userInfo!.lastName,
          orderNumber: _userOrder?.orderNumber,
          invoiceNumber: _userOrder?.invoiceNumber,
          orderDate: Utils.dateFormatDDMMYY(DateTime.now().toString()),
          firstName: _userOrder!.userInfo!.firstName,
          street: _userOrder!.userInfo!.street,
          houseNumber: _userOrder!.userInfo!.houseNumber,
          postcode: _userOrder!.userInfo!.plz,
          city: _userOrder!.userInfo!.location,
          email: _userOrder!.userInfo!.email!,
          phone: _userOrder!.userInfo!.phone!,
          maritalStatus: _userOrder!.martialStatus,
          taxYear: _userOrder!.taxYear,
          totalPrice: _userOrder!.taxPrice,
          invoiceTemplate: EmailInvoiceConstants.safeTax);
      await EmailRepository().sendMail("dialog@steuermachen.de",
          EmailInvoiceConstants.orderSubject, EmailInvoiceConstants.safeTax,
          sendInvoice: false,
          templatePdf: EmailInvoiceConstants.safeTax,
          salutation: _userOrder!.userInfo!.gender,
          lastName: _userOrder!.userInfo!.lastName,
          orderNumber: _userOrder?.orderNumber,
          invoiceNumber: _userOrder?.invoiceNumber,
          orderDate: Utils.dateFormatDDMMYY(DateTime.now().toString()),
          firstName: _userOrder!.userInfo!.firstName,
          street: _userOrder!.userInfo!.street,
          houseNumber: _userOrder!.userInfo!.houseNumber,
          postcode: _userOrder!.userInfo!.plz,
          city: _userOrder!.userInfo!.location,
          email: _userOrder!.userInfo!.email!,
          phone: _userOrder!.userInfo!.phone!,
          maritalStatus: _userOrder!.martialStatus,
          taxYear: _userOrder!.taxYear,
          totalPrice: _userOrder!.taxPrice,
          invoiceTemplate: EmailInvoiceConstants.safeTax);
      if (sendMailResponse != null) {
        firestoreResponse.update({
          "invoices_path": [sendMailResponse.pdf.url]
        });
      }
      return CommonResponseWrapper(
          status: true, message: StringConstants.thankYouForOrder);
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  Future<CommonResponseWrapper?> checkTaxIsAlreadySubmit() async {
    try {
      var res = await serviceLocatorInstance<UserOrderRepository>()
          .fetchTaxFiledYears();
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
