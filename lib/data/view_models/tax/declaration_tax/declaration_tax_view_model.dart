import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/email_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/strings/tax_name_constants.dart';
import 'package:steuermachen/data/repositories/remote/email_repository.dart';
import 'package:steuermachen/data/repositories/remote/user_order_repository.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/data/view_models/tax_calculator_provider.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/user_orders_data_model.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_view_wrapper.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumup_checkout_wrapper.dart';
import 'package:steuermachen/wrappers/send_mail_model.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class DeclarationTaxViewModel extends ChangeNotifier {
  late ApiResponse _viewData = ApiResponse.loading();
  ApiResponse get viewData => _viewData;
  set setViewData(ApiResponse viewData) {
    _viewData = viewData;
  }

  late ApiResponse _taxFiledYears = ApiResponse.loading();
  ApiResponse get taxFiledYears => _taxFiledYears;
  set setTaxFiledYears(ApiResponse taxFiledYears) {
    _taxFiledYears = taxFiledYears;
  }

  final UserOrdersDataModel? _userOrder = UserOrdersDataModel();
  UserOrdersDataModel? get dataCollectorWrapper => _userOrder;

  Future<void> fetchDeclarationTaxViewData() async {
    try {
      setViewData = ApiResponse.loading();
      notifyListeners();
      var res = await serviceLocatorInstance<UserOrderRepository>()
          .fetchDeclarationTaxViewData();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      DeclarationTaxViewWrapper declarationTaxWrapper =
          DeclarationTaxViewWrapper.fromJson(x);
      setViewData = ApiResponse.completed(declarationTaxWrapper);
    } catch (e) {
      setViewData = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<CommonResponseWrapper> addDeclarationTaxViewData() async {
    try {
      await serviceLocatorInstance<UserOrderRepository>()
          .addDeclarationTaxViewData();
      return CommonResponseWrapper(
          status: true, message: StringConstants.success);
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

  setIncome(String income) {
    _userOrder?.grossIncome = income;
  }

  setTaxPrice(String taxPrice) {
    _userOrder?.taxPrice = taxPrice;
  }

  Future<CommonResponseWrapper> submitDeclarationTaxData(BuildContext context,
      {bool isCurrentYear = false, String? taxPrice}) async {
    PaymentGateWayProvider _paymentProvider =
        Provider.of<PaymentGateWayProvider>(context, listen: false);
    if (isCurrentYear) {
      _setCurrentYearTax(context, taxPrice!);
    } else {
      await _setDataDeclarationTax(context);
    }
    try {
      DocumentReference<Map<String, dynamic>> firestoreResponse;
      if (_paymentProvider.isCardPayment) {
        ApiResponse apiResponse = await _paymentProvider.completeCheckout();
        if (apiResponse.status == Status.completed) {
          SumpupCheckoutWrapper checkoutWrapper = apiResponse.data;
          _userOrder?.paymentInfo = checkoutWrapper;
          _userOrder?.paymentType = OptionConstants.card;
          _userOrder?.invoiceNumber = checkoutWrapper.invoiceNumber;
          _userOrder?.orderNumber = checkoutWrapper.orderNumber;
          firestoreResponse =
              await serviceLocatorInstance<UserOrderRepository>()
                  .submitUserOrder(_userOrder!.toJson(
                      isCurrentYear
                          ? TaxNameConstants.currentYear
                          : TaxNameConstants.declarationTax,
                      steps: taxSteps));
          _paymentProvider.isCardPayment = false;
        } else {
          return CommonResponseWrapper(
              status: false, message: apiResponse.message);
        }
      } else {
        List<String> orderAndInvoiceNo =
            await _paymentProvider.generateOrderNumber();
        _userOrder?.invoiceNumber = orderAndInvoiceNo[1];
        _userOrder?.orderNumber = orderAndInvoiceNo[0];
        _userOrder?.paymentType = OptionConstants.billing;
        firestoreResponse = await serviceLocatorInstance<UserOrderRepository>()
            .submitUserOrder(_userOrder!.toJson(
                isCurrentYear
                    ? TaxNameConstants.currentYear
                    : TaxNameConstants.declarationTax,
                steps: taxSteps));
      }

      SendMailModel? sendMailResponse = await EmailRepository().sendMail(
          _userOrder!.userInfo!.email!,
          EmailInvoiceConstants.orderSubject,
          isCurrentYear
              ? EmailInvoiceConstants.currentYearTax
              : EmailInvoiceConstants.declarationTax,
          templatePdf: isCurrentYear
              ? EmailInvoiceConstants.currentYearTax
              : EmailInvoiceConstants.declarationPdf,
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
          invoiceTemplate: isCurrentYear
              ? EmailInvoiceConstants.currentYearTax
              : EmailInvoiceConstants.declarationTaxInvoice);
      await EmailRepository().sendMail(
          "dialog@steuermachen.de",
          EmailInvoiceConstants.orderSubject,
          isCurrentYear
              ? EmailInvoiceConstants.currentYearTax
              : EmailInvoiceConstants.declarationTax,
          templatePdf: isCurrentYear
              ? EmailInvoiceConstants.currentYearTax
              : EmailInvoiceConstants.declarationPdf,
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
          invoiceTemplate: isCurrentYear
              ? EmailInvoiceConstants.currentYearTax
              : EmailInvoiceConstants.declarationTaxInvoice);
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

  Future<void> _setDataDeclarationTax(BuildContext context) async {
    SignatureProvider _signature =
        Provider.of<SignatureProvider>(context, listen: false);
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    TaxCalculatorProvider _tax =
        Provider.of<TaxCalculatorProvider>(context, listen: false);
    String signaturePath = await Utils.uploadToFirebaseStorage(
        await _signature.getSignaturePath());
    _userOrder?.signaturePath = signaturePath;
    _userOrder?.userInfo = _user.userData;
    _userOrder?.userAddress = _user.getSelectedAddress;
    _userOrder?.termsAndConditionChecked = true;
    _userOrder?.grossIncome = _tax.selectedPrice;
  }

  Future<void> _setCurrentYearTax(BuildContext context, String taxPrice) async {
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    _userOrder?.userInfo = _user.userData;
    _userOrder?.userAddress = _user.getSelectedAddress;
    _userOrder?.termsAndConditionChecked = true;
    _userOrder?.subscriptionPrice = double.parse(taxPrice);
  }

  Future<void> fetchTaxFiledYears({bool isNotifify = true}) async {
    try {
      setTaxFiledYears = ApiResponse.loading();
      if (isNotifify) {
        notifyListeners();
      }
      var res = await serviceLocatorInstance<UserOrderRepository>()
          .fetchTaxFiledYears();
      if (res.docs.isNotEmpty) {
        setTaxFiledYears = ApiResponse.completed(res.docs);
      } else {
        setTaxFiledYears = ApiResponse.completed(null);
      }
    } catch (e) {
      setTaxFiledYears = ApiResponse.error(e.toString());
    }
    if (isNotifify) {
      notifyListeners();
    }
  }
}
